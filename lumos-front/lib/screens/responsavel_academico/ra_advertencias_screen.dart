import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_ra.dart';

class RaAdvertenciasScreen extends StatefulWidget {
  const RaAdvertenciasScreen({super.key});

  @override
  State<RaAdvertenciasScreen> createState() => _RaAdvertenciasScreenState();
}

class _RaAdvertenciasScreenState extends State<RaAdvertenciasScreen> {
  final List<Map<String, String>> advertencias = [
    {
      'titulo': 'Advertência — Atrasos Frequentes',
      'descricao': 'O aluno apresentou atrasos recorrentes nas últimas semanas.',
      'data': 'Publicado em 10/10/2025',
      'detalhe':
          'O aluno foi advertido devido a atrasos recorrentes em suas aulas. Solicitamos mais atenção quanto aos horários de chegada para evitar futuras penalizações.'
    },
    {
      'titulo': 'Advertência — Uso Indevido do Celular',
      'descricao':
          'O aluno foi advertido verbalmente por utilizar o celular durante a aula.',
      'data': 'Publicado em 07/10/2025',
      'detalhe':
          'O aluno foi advertido verbalmente por utilizar o celular durante a aula no dia 07/10/2025. Reforçamos a importância de manter o foco e respeitar as orientações da escola.'
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
          'Advertências',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: advertencias.length,
          itemBuilder: (context, index) {
            final adv = advertencias[index];
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
                      adv['titulo']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(isExpanded ? adv['detalhe']! : adv['descricao']!),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        adv['data']!,
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
