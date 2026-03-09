import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import pg from "pg";

dotenv.config();

const { Pool } = pg;
const app = express();

app.use(cors());
app.use(express.json());

// Conexão com Supabase Postgres via Pooler
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  //ssl: { rejectUnauthorized: false }, // comum em bancos gerenciados
});

app.get("/ordens", async (req, res) => {
  try {
    const r = await pool.query(
      `select
         os.id_ordem_servico,
         os.data_ordem_servico,
         os.status_ordem_servico,
         v.identifica_veiculo
       from promec_gti.tb_ordem_servico os
       join promec_gti.tb_veiculo v on v.id_veiculo = os.id_veiculo
       where os.ativo = true
       order by os.data_ordem_servico desc`
    );

    res.json(r.rows);
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});

app.post("/ordens/:id/orcamento", async (req, res) => {
  const idOrdem = Number(req.params.id);
  const { descricao_orcamento, valor_orcamento } = req.body;

  if (!idOrdem) return res.status(400).json({ error: "idOrdem inválido" });
  if (!descricao_orcamento) return res.status(400).json({ error: "descricao_orcamento é obrigatório" });
  if (valor_orcamento == null) return res.status(400).json({ error: "valor_orcamento é obrigatório" });

  try {
    // pega próximo id (MVP). Melhor depois: usar SERIAL/IDENTITY.
    const nextIdRes = await pool.query(
      "select coalesce(max(id_orcamento), 0) + 1 as next_id from promec_gti.tb_orcamento"
    );
    const nextId = nextIdRes.rows[0].next_id;

    // cria orçamento
    await pool.query(
      `insert into promec_gti.tb_orcamento
       (id_orcamento, data_orcamento, status_orcamento, valor_orcamento, descricao_orcamento, pdf_orcamento)
       values ($1, now(), 'PENDENTE', $2, $3, 'nao_gerado')`,
      [nextId, valor_orcamento, descricao_orcamento]
    );

    // vincula na OS
    await pool.query(
      `update promec_gti.tb_ordem_servico
       set id_orcamento = $1
       where id_ordem_servico = $2`,
      [nextId, idOrdem]
    );

    res.status(201).json({ id_orcamento: nextId });
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});


// Rota de teste: confirma se conectou no banco
app.get("/health", async (req, res) => {
  try {
    const r = await pool.query("select now() as server_time");
    res.json({ ok: true, server_time: r.rows[0].server_time });
  } catch (e) {
    res.status(500).json({ ok: false, error: String(e) });
  }
});

// Login (por email) — usa sua tabela do schema promec_gti
app.get("/usuarios", async (req, res) => {
  const { email } = req.query;
  if (!email) return res.status(400).json({ error: "email é obrigatório" });

  try {
    const r = await pool.query(
      `select id_usuario, nm_usuario, email_usuario, tipo_usuario
       from promec_gti.tb_usuario
       where email_usuario = $1
       limit 1`,
      [email]
    );

    if (r.rowCount === 0) return res.status(404).json(null);
    res.json(r.rows[0]);
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});

app.get("/ordens/:id/orcamento", async (req, res) => {
  const id = Number(req.params.id);

  if (!id) return res.status(400).json({ error: "id inválido" });

  try {
    const r = await pool.query(
      `select
         o.id_orcamento,
         o.data_orcamento,
         o.status_orcamento,
         o.valor_orcamento,
         o.descricao_orcamento,
         o.pdf_orcamento
       from promec_gti.tb_ordem_servico os
       join promec_gti.tb_orcamento o on o.id_orcamento = os.id_orcamento
       where os.id_ordem_servico = $1
       limit 1`,
      [id]
    );

    if (r.rowCount === 0) return res.status(404).json(null);
    res.json(r.rows[0]);
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});


const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`API rodando em http://localhost:${port}`);
});
