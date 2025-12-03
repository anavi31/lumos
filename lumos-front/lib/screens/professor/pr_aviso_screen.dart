import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_professor.dart';
import 'pr_postar_aviso_screen.dart';

class PrAvisosScreen extends StatefulWidget {
  const PrAvisosScreen({super.key});

  @override
  State<PrAvisosScreen> createState() => _PrAvisosScreenState();
}

class _PrAvisosScreenState extends State<PrAvisosScreen> {
  final List<Map<String, String>> avisos = [
    {
      'titulo': '3°B',
      'descricao':
          'Entregar relatório do trabalho prático sobre Ecossistemas até o dia 30/09/2025.',
      'data': 'Postado em 10/09/2025',
      'detalhe':
          'A entrega deve ser feita em grupo até o dia 30/09/2025. Os relatórios devem ser entregues diretamente ao professor no laboratório de ciências.'
    },
    {
      'titulo': '1°C',
      'descricao': 'Slide de Respiração Celular.',
      'data': 'Postado em 12/09/2025',
      'detalhe':
          'Estudar o conteúdo do slide para a avaliação da próxima semana. O material está disponível no ambiente virtual.'
    },
    {
      'titulo': '1°A',
      'descricao': 'Slide de Respiração Celular.',
      'data': 'Postado em 13/09/2025',
      'detalhe':
          'Mesma orientação do 1°C: revisar o slide e preparar-se para a prova curta sobre o tema.'
    },
    {
      'titulo': '2°A',
      'descricao':
          'Entregar resumo escrito sobre Genética Mendeliana até 14/09/2025.',
      'data': 'Postado em 14/09/2025',
      'detalhe':
          'O resumo deve conter pelo menos uma página explicando as leis de Mendel com exemplos próprios.'
    },
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerPR(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        title: const Text(
          'Avisos',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrPostarAvisoScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF8E38D),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Postar Aviso',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          )
        ],
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
