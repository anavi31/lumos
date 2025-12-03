import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_rf.dart';

class RfFaltasScreen extends StatelessWidget {
  const RfFaltasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerRF(),
      appBar: AppBar(
        title: const Text(
          'Frequência',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 2),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Faltas', style: TextStyle(fontSize: 18)),
                  CircleAvatar(
                    backgroundColor: Color(0xFFDCC9FF),
                    child: Text('20'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Carga Horária',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: CircularProgressIndicator(
                        value: 0.54,
                        strokeWidth: 16,
                        backgroundColor: Colors.grey.shade300,
                        color: const Color(0xFFDCC9FF),
                      ),
                    ),
                    const Text(
                      '54%',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(width: 30),

                Container(
                  width: 180,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Carga Horária Total: 3590'),
                      SizedBox(height: 8),
                      Text('Carga Horária Cursada: 1972'),
                      SizedBox(height: 8),
                      Text('Carga Horária Faltante: 1620'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
