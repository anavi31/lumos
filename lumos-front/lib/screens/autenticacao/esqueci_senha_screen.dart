import 'package:flutter/material.dart';

class EsqueciSenhaScreen extends StatefulWidget {
  const EsqueciSenhaScreen({super.key});

  @override
  State<EsqueciSenhaScreen> createState() => _EsqueciSenhaScreenState();
}

class _EsqueciSenhaScreenState extends State<EsqueciSenhaScreen> {
  final TextEditingController cpfController = TextEditingController();

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
                    BoxShadow(color: Colors.black12, blurRadius: 6),
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
          child: SizedBox(width: 350, child: _buildForm()),
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
      children: [
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset('assets/images/atomo.png', height: 55),
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
        const SizedBox(height: 30),

        const Text(
          "Esqueceu a senha?",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),

        const Text(
          "Se você é um professor(a) ou responsável insira seu CPF para a recuperação. Caso esteja recuperando a senha de um aluno(a), insira o número de matrícula.",
          style: TextStyle(color: Colors.black54),
        ),

        const SizedBox(height: 30),

        TextField(
          controller: cpfController,
          decoration: InputDecoration(
            labelText: 'Insira seu CPF ou número de matrícula.',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            filled: true,
            fillColor: const Color(0xFFEAF5FF),
          ),
          keyboardType: TextInputType.number,
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
              if (cpfController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Por favor, insira seu CPF ou matrícula."),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              Navigator.pushNamed(context, '/nova_senha');
            },
            child: const Text(
              "Avançar",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        )

      ],
    );
  }
}
