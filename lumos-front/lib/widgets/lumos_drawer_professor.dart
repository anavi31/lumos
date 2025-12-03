import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/autenticacao/login_screen.dart';
import '../screens/professor/pr_horario_screen.dart';
import '../screens/professor/pr_aviso_screen.dart';
import '../screens/professor/pr_notas_screen.dart';
import '../screens/professor/pr_chamadas_screen.dart';

class LumosDrawerPR extends StatelessWidget {
  const LumosDrawerPR({super.key});

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

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(137, 195, 235, 250),
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.all(10),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Professora Biologia", style: TextStyle(fontSize: 17)),
                  Text("1234567890", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 25),

            _drawerItem(
              icon: 'assets/images/teacher.svg',
              text: 'Grade Horária',
              onTap: () => _navigate(context, const PrHorarioScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/profile-2user.svg',
              text: 'Notas',
              onTap: () => _navigate(context, const PrNotasScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/note_line.svg',
              text: 'Chamada',
              onTap: () => _navigate(context, const PrChamadasScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/message-square-dots-2.svg',
              text: 'Avisos',
              onTap: () => _navigate(context, const PrAvisosScreen()),
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