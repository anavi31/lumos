import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_secretaria.dart';

class GerenciarPRScreen extends StatefulWidget {
  const GerenciarPRScreen({super.key});

  @override
  State<GerenciarPRScreen> createState() => _GerenciarPRScreenState();
}

class _GerenciarPRScreenState extends State<GerenciarPRScreen> {
  List<Map<String, dynamic>> professores = List.generate(
    25,
    (i) => {
      "nome": "Professor Sobrenome ${i + 1}",
      "materia": "Matéria ${i + 1}",
      "turmas": <String>[],
    },
  );

  String busca = "";
  int page = 0;
  final int pageSize = 10;

  final List<String> turmasDisponiveis = [
    "1A", "1B", "1C",
    "2A", "2B", "2C",
    "3A", "3B", "3C",
  ];

  void resetarTudo() {
    setState(() {
      busca = "";
      page = 0;
      for (var p in professores) {
        p["turmas"] = [];
      }
    });
  }

  void abrirSelecaoTurmas(Map professor) {
    List<String> selecionadasTemp = List.from(professor["turmas"]);

    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Selecionar turmas para ${professor["nome"]}"),
              content: SizedBox(
                width: 300,
                child: ListView(
                  shrinkWrap: true,
                  children: turmasDisponiveis.map((t) {
                    return CheckboxListTile(
                      value: selecionadasTemp.contains(t),
                      title: Text(t),
                      onChanged: (v) {
                        setStateDialog(() {
                          if (v == true) {
                            selecionadasTemp.add(t);
                          } else {
                            selecionadasTemp.remove(t);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      professor["turmas"] = selecionadasTemp;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Salvar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List filtrados = professores
        .where((p) => p["nome"].toLowerCase().contains(busca.toLowerCase()))
        .toList();

    int start = page * pageSize;
    int end = (start + pageSize < filtrados.length) ? start + pageSize : filtrados.length;
    List pagina = filtrados.sublist(start, end);

    return Scaffold(
      drawer: const LumosDrawerSEC(),
      backgroundColor: const Color(0xFFF5F4F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        title: const Text("Alocar Perfil"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/sec_gerenciar_perfil'),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: resetarTudo,
            child: const Text("Resetar"),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF7D774)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Alocações salvas!"),
                    content: const Text("As turmas dos professores foram atualizadas com sucesso."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Fechar"),
                      )
                    ],
                  ),
                );
              },
              child: const Text("Salvar", style: TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Lista de Professores",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),

            // BUSCA
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar professor por nome...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (v) => setState(() => busca = v),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: pagina.length,
                itemBuilder: (_, i) {
                  var prof = pagina[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nome e matéria
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(prof["nome"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(prof["materia"],
                                style: const TextStyle(color: Colors.black54)),
                          ],
                        ),

                        SizedBox(
                          width: 180,
                          child: ElevatedButton(
                            onPressed: () => abrirSelecaoTurmas(prof),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              side: const BorderSide(color: Colors.black26),
                            ),
                            child: Text(
                              prof["turmas"].isEmpty
                                  ? "Selecionar turmas"
                                  : "Turmas: ${prof["turmas"].join(", ")}",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: page > 0 ? () => setState(() => page--) : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text("${page + 1} / ${(filtrados.length / pageSize).ceil()}"),
                IconButton(
                  onPressed: end < filtrados.length ? () => setState(() => page++) : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
