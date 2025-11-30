import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_secretaria.dart';

class SecHomeScreen extends StatelessWidget {
  const SecHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerSEC(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'LUMOS',
          style: TextStyle(
            fontFamily: 'Frogie',
            fontSize: 38,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F4F9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/atomo.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'LUMOS',
              style: TextStyle(
                fontFamily: 'Frogie',
                fontSize: 80,
                color: Color(0xFFCFCEFF),
                height: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
