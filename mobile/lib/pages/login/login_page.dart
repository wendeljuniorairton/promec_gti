import 'package:flutter/material.dart';
import '../../services/usuario_service.dart';
import '../../models/usuario_model.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final UsuarioService _usuarioService = UsuarioService();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    UsuarioModel? usuario =
        await _usuarioService.login(_emailController.text);

    setState(() {
      _isLoading = false;
    });

    if (usuario != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, ${usuario.nome}!')),
      );

      Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const HomePage()),
);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não encontrado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Entrar'),
                  ),
          ],
        ),
      ),
    );
  }
}
