import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/autenticacao/login_screen.dart';
import '../screens/responsavel_academico/ra_notas_screen.dart';
import '../screens/responsavel_academico/ra_horario_screen.dart';
import '../screens/responsavel_academico/ra_avisos_screen.dart';
import '../screens/responsavel_academico/ra_advertencias_screen.dart';
import '../screens/responsavel_academico/ra_faltas_screen.dart';

class LumosDrawerRA extends StatelessWidget {
  const LumosDrawerRA({super.key});

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
                  Text("Responsável por:", style: TextStyle(fontSize: 15)),
                  Divider(thickness: 1),
                  Text("Nome Sobrenome", style: TextStyle(fontSize: 17)),
                  Text("2230123456", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 25),

            _drawerItem(
              icon: 'assets/images/teacher.svg',
              text: 'Grade Horária',
              onTap: () => _navigate(context, const RaHorarioScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/profile-2user.svg',
              text: 'Notas',
              onTap: () => _navigate(context, const RaNotasScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/note_line.svg',
              text: 'Faltas',
              onTap: () => _navigate(context, const RaFaltasScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/message-square-dots-2.svg',
              text: 'Passeios e Eventos',
              onTap: () => _navigate(context, const RaAvisosScreen()),
            ),
            _drawerItem(
              icon: 'assets/images/message-square-dots-1.svg',
              text: 'Advertências',
              onTap: () => _navigate(context, const RaAdvertenciasScreen()),
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