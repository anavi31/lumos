import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_ra.dart';

class RaAvisosScreen extends StatefulWidget {
  const RaAvisosScreen({super.key});

  @override
  State<RaAvisosScreen> createState() => _RaAvisosScreenState();
}

class _RaAvisosScreenState extends State<RaAvisosScreen> {
  final List<Map<String, String>> avisos = [
    {
      'titulo': 'Passeio ao Zoológico',
      'descricao':
          'A atividade será avaliada como parte do trabalho interdisciplinar de Ciências e Geografia.',
      'data': 'Publicado em 15/10/2025',
      'detalhe':
          'A visita ao Zoológico será realizada como atividade interdisciplinar de Ciências e Geografia. Os alunos deverão entregar um relatório na semana seguinte.'
    },
    {
      'titulo': 'Passeio ao Parque da Cidade',
      'descricao':
          'No dia 18/10/2025, os alunos participarão de um passeio ao Parque da Cidade.',
      'data': 'Publicado em 09/10/2025',
      'detalhe':
          'No dia 18/10/2025, os alunos participarão de um passeio ao Parque da Cidade. O passeio será uma atividade integradora das disciplinas de Ciências e Educação Física. A autorização será entregue na semana seguinte.'
    },
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerRA(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        title: const Text(
          'Passeios e Eventos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: avisos.length,
          itemBuilder: (context, index) {
            final aviso = avisos[index];
            final isExpanded = expandedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E1FF),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    if (isExpanded)
                      BoxShadow(
                        color: Colors.black.withAlpha((0.1 * 255).toInt()),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aviso['titulo']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(isExpanded ? aviso['detalhe']! : aviso['descricao']!),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        aviso['data']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
