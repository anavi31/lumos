import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lumos/screens/secretaria/sec_gerenciar_screen.dart';
import '../screens/autenticacao/login_screen.dart';
import '../screens/secretaria/sec_criar_perfil_screen.dart';
import '../screens/secretaria/sec_desativar_perfil_screen.dart';
import '../screens/secretaria/sec_avisos_screen.dart';
import '../screens/secretaria/sec_advertencias_screen.dart';

class LumosDrawerSEC extends StatelessWidget {
  const LumosDrawerSEC({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/images/atomo.png', width: 60, height: 60),
                const SizedBox(width: 10),
                const Text(
                  'Lumos',
                  style: TextStyle(
                    fontFamily: 'Frogie',
                    fontSize: 42,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _drawerItem(
              icon: 'assets/images/profile-2user.svg',
              text: 'Criar Perfis',
              onTap: () => _navigate(context, const CriarPerfilScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/profile-2user.svg',
              text: 'Gerenciamento de Perfis',
              onTap: () => _navigate(context, const GerenciarScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/profile-2user.svg',
              text: 'Desativar Perfis',
              onTap: () => _navigate(context, const DesativarPerfisScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/message-square-dots-2.svg',
              text: 'Postar Passeios e Eventos',
              onTap: () => _navigate(context, const SecAvisosScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/message-square-dots-1.svg',
              text: 'Postar Advertências',
              onTap: () => _navigate(context, const SecAdvertenciasScreen()),
            ),

            const Spacer(),

            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8E38D),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Encerrar sessão",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/images/arrow-right-circle.svg',
                      width: 22,
                      height: 22,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required String icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 26, height: 26),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }
}