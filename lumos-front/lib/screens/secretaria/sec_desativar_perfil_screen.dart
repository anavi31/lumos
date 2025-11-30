import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_secretaria.dart';

class DesativarPerfisScreen extends StatefulWidget {
  const DesativarPerfisScreen({super.key});

  @override
  State<DesativarPerfisScreen> createState() => _DesativarPerfisScreenState();
}

class _DesativarPerfisScreenState extends State<DesativarPerfisScreen> {
  String tipoSelecionado = "Alunos";
  String turmaFiltro = "Todas";

  String busca = "";

  int page = 0;
  final int pageSize = 10;

  final List<Map<String, dynamic>> alunos = List.generate(
    35,
    (i) => {
      "nome": "Aluno Sobrenome ${i + 1}",
      "matricula": "20240${i}88${i + 3}",
      "classe": ["1-A", "2-B", "3-C"][i % 3],
      "mensalidade": "R\$ ${(200 + i * 3).toStringAsFixed(2)}",
      "totalPago": "R\$ ${(500 + i * 15).toStringAsFixed(2)}",
      "pendente": "R\$ ${(i * 7).toStringAsFixed(2)}",
      "status": ["Ativo"][i % 1],
    },
  );

  final List<Map<String, dynamic>> professores = List.generate(
    35,
    (i) => {
      "nome": "Professor Sobrenome ${i + 1}",
      "materia": "Matéria ${(i % 5) + 1}",
      "status": ["Ativo"][i % 1],
    },
  );

  void confirmarDesativacao(Map pessoa) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Confirmação de Desativação de Perfil",
          textAlign: TextAlign.center,
        ),
        content: const Text(
          "Você está prestes a desativar o perfil selecionado.\n\n"
          "Após a desativação, o usuário não terá mais acesso ao sistema, "
          "mas os dados permanecerão registrados para consulta administrativa.\n\n"
          "Deseja realmente desativar este perfil?",
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                pessoa["status"] = "Inativo";
              });
              Navigator.pop(context);
            },
            child: const Text("Confirmar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[600],
              foregroundColor: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List listaBase =
        tipoSelecionado == "Alunos" ? alunos : professores;

    List filtrados = listaBase.where((p) {
      final nomeOk =
          p["nome"].toLowerCase().contains(busca.toLowerCase());

      final turmaOk = tipoSelecionado == "Alunos"
          ? (turmaFiltro == "Todas" || p["classe"] == turmaFiltro)
          : true;

      return nomeOk && turmaOk;
    }).toList();

    int start = page * pageSize;
    int end = (start + pageSize < filtrados.length)
        ? start + pageSize
        : filtrados.length;
    List pagina = filtrados.sublist(start, end);

    return Scaffold(
      drawer: const LumosDrawerSEC(),
      backgroundColor: const Color(0xFFF5F4F9),

      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        title: const Text("Desativar Perfis"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Perfis",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                DropdownButton<String>(
                  value: tipoSelecionado,
                  items: const [
                    DropdownMenuItem(
                        value: "Alunos", child: Text("Alunos")),
                    DropdownMenuItem(
                        value: "Professores", child: Text("Professores")),
                  ],
                  onChanged: (v) {
                    setState(() {
                      tipoSelecionado = v!;
                      turmaFiltro = "Todas";
                      page = 0;
                    });
                  },
                ),
                const SizedBox(width: 16),

                if (tipoSelecionado == "Alunos")
                  DropdownButton<String>(
                    value: turmaFiltro,
                    items: [
                      const DropdownMenuItem(
                          value: "Todas", child: Text("Todas")),
                      ...["1-A", "2-B", "3-C"].map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(t),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      setState(() {
                        turmaFiltro = v!;
                        page = 0;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: "Buscar por nome...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (v) => setState(() => busca = v),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: pagina.length,
                itemBuilder: (_, i) {
                  var p = pagina[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 3),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p["nome"],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            if (tipoSelecionado == "Alunos")
                              Text("Classe: ${p["classe"]}",
                                  style:
                                      const TextStyle(color: Colors.black54)),
                            if (tipoSelecionado == "Professores")
                              Text("Matéria: ${p["materia"]}",
                                  style:
                                      const TextStyle(color: Colors.black54)),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: p["status"] == "Ativo"
                                ? const Color(0xFFD1F3D1)
                                : const Color(0xFFFFD8D8),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            p["status"],
                            style: TextStyle(
                              color: p["status"] == "Ativo"
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFC62828),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => confirmarDesativacao(p),
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
                  onPressed:
                      page > 0 ? () => setState(() => page--) : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text("${page + 1} / ${(filtrados.length / pageSize).ceil()}"),
                IconButton(
                  onPressed: end < filtrados.length
                      ? () => setState(() => page++)
                      : null,
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
