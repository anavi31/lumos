import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_aluno.dart';

class AlAvisosScreen extends StatefulWidget {
  const AlAvisosScreen({super.key});

  @override
  State<AlAvisosScreen> createState() => _AlAvisosScreenState();
}

class _AlAvisosScreenState extends State<AlAvisosScreen> {
  final List<Map<String, String>> avisos = [
    {
      'titulo': 'Biologia',
      'descricao':
          'Entregar relatório do trabalho prático sobre Ecossistemas até o dia 30/10/2025.',
      'data': 'Publicado em 15/10/2025',
      'detalhe':
          'Pessoal, não esqueçam de trazer o relatório da equipe para o trabalho! A entrega deve ser feita até o dia 30/10/2025 para que possamos organizar as apresentações.'
    },
    {
      'titulo': 'Português',
      'descricao':
          'Leitura obrigatória do livro Vidas Secas para prova de interpretação no dia 10/10/2025.',
      'data': 'Publicado em 15/10/2025',
      'detalhe':
          'Leitura obrigatória do livro "Vidas Secas", de Graciliano Ramos. A prova de interpretação ocorrerá no dia 10/10/2025 e cobrará os capítulos 1 a 6. Aproveitem para revisar também as características do regionalismo literário.'
    },
    {
      'titulo': 'Química',
      'descricao':
          'Entrega da lista de exercícios sobre Funções Inorgânicas até o dia 16/10/2025.',
      'data': 'Publicado em 09/10/2025',
      'detalhe':
          'A lista de exercícios sobre Funções Inorgânicas deve ser entregue até o dia 16/10/2025. O material será utilizado para revisão antes da prova prática. Lembrem-se de revisar as principais propriedades dos ácidos e bases.'
    },
    {
      'titulo': 'História',
      'descricao':
          'Preparar apresentação em grupo sobre a Revolução Francesa para o dia 15/10/2025.',
      'data': 'Publicado em 03/10/2025',
      'detalhe':
          'Os grupos devem preparar uma apresentação sobre os principais eventos e personagens da Revolução Francesa. As apresentações ocorrerão no dia 15/10/2025, e cada grupo terá até 10 minutos para expor o conteúdo.'
    },
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerAL(),
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
