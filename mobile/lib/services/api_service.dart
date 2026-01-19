import 'package:http/http.dart' as http;

class ApiService {
  // Windows desktop: localhost funciona.
  // Se futuramente testar no Android Emulator, você vai trocar para 10.0.2.2
  static const String baseUrl = 'http://localhost:3000';

  static Future<http.Response> get(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    return http.get(uri, headers: {
      'Content-Type': 'application/json',
    });
  }

  static Future<http.Response> post(
    String path, {
    required String body,
  }) async {
    final uri = Uri.parse('$baseUrl$path');
    return http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );
  }
}
