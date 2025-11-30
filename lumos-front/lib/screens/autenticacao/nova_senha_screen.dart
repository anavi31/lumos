import 'package:flutter/material.dart';

class NovaSenhaScreen extends StatelessWidget {
  const NovaSenhaScreen({super.key});

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
                    ? _buildMobileLayout(context)
                    : _buildDesktopLayout(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60),
          child: SizedBox(
            width: 360,
            child: _buildTextContent(context),
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

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
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
          "Recuperação de senha",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),

        const Text(
          "Prezado(a) NOME SOBRENOME,",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          "Sua nova senha será enviada para o e-mail\n"
          "associado à sua conta. Caso não se lembre\n"
          "do endereço cadastrado, entre em contato com\n"
          "a administração de sua Escola.",
          style: TextStyle(height: 1.3),
        ),
        const SizedBox(height: 12),

        const Text(
          "Se não encontrar a mensagem de confirmação,\n"
          "verifique também sua caixa de spam.",
          style: TextStyle(height: 1.3),
        ),
        const SizedBox(height: 12),

        const Text(
          "Ao seguir o link, você receberá um código de\n"
          "segurança (OTP) para concluir sua redefinição\n"
          "de senha rapidamente.",
          style: TextStyle(height: 1.3),
        ),

        const SizedBox(height: 28),

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
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              "Enviar",
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
