import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool lembrar = false;
  bool senhaVisivel = false;

  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void login() async {
    final response = await http.post(
      Uri.parse("http://localhost:8080/api/login"),
      body: {
        'login': matriculaController.text,
        'senha': senhaController.text,
      },
    );

    if (!mounted) return;

    final data = jsonDecode(response.body);
    String status = data["status"];

    Navigator.pushNamed(context, "/$status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 800;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              child: Container(
                width: isMobile ? double.infinity : 900,
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 32 : 40,
                  horizontal: isMobile ? 24 : 0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 6)
                  ],
                ),
                child: isMobile
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: SizedBox(
            width: 350,
            child: _buildLoginForm(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 80),
          child: Image.asset(
            'assets/images/auth.png',
            height: 300,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLoginForm(),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/atomo.png',
              height: 55,
            ),
            const SizedBox(width: 8),
            const Text(
              "LUMOS",
              style: TextStyle(
                fontFamily: 'Frogie',
                fontSize: 38,
                color: Color(0xFF9E7BFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),

        const Text(
          "Conecte-se",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          "Olá, bem-vindo de volta!",
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 30),

        TextField(
          controller: matriculaController,
          decoration: InputDecoration(
            labelText: 'Matrícula',
            hintText: 'Insira seu número de matrícula',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            filled: true,
            fillColor: const Color(0xFFEAF5FF),
          ),
        ),
        const SizedBox(height: 16),

        TextField(
          controller: senhaController,
          obscureText: !senhaVisivel,
          decoration: InputDecoration(
            labelText: 'Senha',
            hintText: 'Insira sua senha',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            filled: true,
            fillColor: const Color(0xFFEAF5FF),
            suffixIcon: IconButton(
              icon: Icon(
                senhaVisivel ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() => senhaVisivel = !senhaVisivel);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: lembrar,
                  activeColor: const Color(0xFF9E7BFF),
                  onChanged: (value) {
                    setState(() => lembrar = value ?? false);
                  },
                ),
                const Text("Lembrar-se"),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/esqueci_senha');
              },
              child: const Text(
                "Esqueceu a senha?",
                style: TextStyle(
                  color: Colors.black54,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDCC9FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/al_home");
            },
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
