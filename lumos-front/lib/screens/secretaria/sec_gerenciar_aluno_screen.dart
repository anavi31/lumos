import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_secretaria.dart';

class GerenciarALScreen extends StatefulWidget {
  const GerenciarALScreen({super.key});

  @override
  State<GerenciarALScreen> createState() => _GerenciarALScreenState();
}

class _GerenciarALScreenState extends State<GerenciarALScreen> {
  List<Map<String, dynamic>> alunos = List.generate(
    25,
    (i) => {
      "nome": "Aluno Sobrenome ${i + 1}",
      "matricula": "20250${i}77${i + 3}",
      "turma": null,
    },
  );

  String busca = "";

  int page = 0;
  final int pageSize = 10;

  void resetarTudo() {
    setState(() {
      busca = "";
      page = 0;

      for (var a in alunos) {
        a["turma"] = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List filtrados = alunos
        .where((a) => a["nome"].toLowerCase().contains(busca.toLowerCase()))
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
                    content: const Text("As turmas dos alunos foram atualizadas com sucesso."),
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
            const Text("Lista de Estudantes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),

            TextField(
              decoration: InputDecoration(
                hintText: "Buscar aluno por nome...",
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
                  var aluno = pagina[i];

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
                        // Nome e matrícula
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(aluno["nome"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(aluno["matricula"],
                                style: const TextStyle(color: Colors.black54)),
                          ],
                        ),

                        SizedBox(
                          width: 180,
                          child: DropdownButtonFormField(
                            initialValue: aluno["turma"],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            items: const [
                              DropdownMenuItem(value: "1A", child: Text("1º Ano A")),
                              DropdownMenuItem(value: "1B", child: Text("1º Ano B")),
                              DropdownMenuItem(value: "1C", child: Text("1º Ano C")),
                              DropdownMenuItem(value: "2A", child: Text("2º Ano A")),
                              DropdownMenuItem(value: "2B", child: Text("2º Ano B")),
                              DropdownMenuItem(value: "2C", child: Text("2º Ano C")),                              
                              DropdownMenuItem(value: "3A", child: Text("3º Ano A")),
                              DropdownMenuItem(value: "3B", child: Text("3º Ano B")),
                              DropdownMenuItem(value: "3C", child: Text("3º Ano C")),
                            ],
                            onChanged: (v) => setState(() => aluno["turma"] = v),
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
