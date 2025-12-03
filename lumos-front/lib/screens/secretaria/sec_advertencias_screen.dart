import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_secretaria.dart';

class SecAdvertenciasScreen extends StatefulWidget {
  const SecAdvertenciasScreen({super.key});

  @override
  State<SecAdvertenciasScreen> createState() => _SecAdvertenciasScreenState();
}

class _SecAdvertenciasScreenState extends State<SecAdvertenciasScreen> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  String? serieSelecionada;
  String? turmaSelecionada;
  String? alunoSelecionado;

  final Map<String, List<String>> alunosPorTurma = {
    "1°-A": ["Ana Clara", "Bruno", "Carlos"],
    "1°-B": ["Daniela", "Eduardo", "Fernanda"],
    "1°-C": ["Gabriel", "Helena", "Pedro"],
    "2°-A": ["João", "Karina", "Larissa"],
    "2°-B": ["Marcelo", "Natália", "Otávio"],
    "2°-C": ["Paula", "Rafael", "Sara"],
    "3°-A": ["Tiago", "Ursula", "Victor"],
    "3°-B": ["Wallace", "Xênia", "Yasmin"],
    "3°-C": ["Zeca", "Alan", "Bianca"],
  };

  List<String> get alunosDisponiveis {
    if (serieSelecionada == null || turmaSelecionada == null) return [];
    String chave = "${serieSelecionada!}-${turmaSelecionada!}";
    return alunosPorTurma[chave] ?? [];
  }

  void resetarTudo() {
    tituloController.clear();
    descricaoController.clear();
    setState(() {
      serieSelecionada = null;
      turmaSelecionada = null;
      alunoSelecionado = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerSEC(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        title: const Text(
          'Postar Advertência',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/sec_home'),
            child: const Text('Cancelar', style: TextStyle(color: Colors.black87)),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: resetarTudo,
            child: const Text('Resetar', style: TextStyle(color: Colors.black87)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: const Color(0xFFF5F4F9),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Insira um título...',
                  border: UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              const Text('Descrição', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: descricaoController,
                maxLines: 6,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Série',
                        filled: true,
                        fillColor: const Color(0xFFE6E1FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      initialValue: serieSelecionada,
                      items: ['1°', '2°', '3°']
                          .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          serieSelecionada = value;
                          turmaSelecionada = null;
                          alunoSelecionado = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Turma',
                        filled: true,
                        fillColor: const Color(0xFFE6E1FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      initialValue: turmaSelecionada,
                      items: ['A', 'B', 'C']
                          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          turmaSelecionada = value;
                          alunoSelecionado = null;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Selecione o aluno',
                  filled: true,
                  fillColor: serieSelecionada != null && turmaSelecionada != null
                      ? Colors.white
                      : Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
                initialValue: alunoSelecionado,
                items: alunosDisponiveis
                    .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                    .toList(),
                onChanged: (serieSelecionada != null && turmaSelecionada != null)
                    ? (value) => setState(() => alunoSelecionado = value)
                    : null,
              ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (alunoSelecionado == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Selecione o aluno antes de postar.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Advertência postada com sucesso!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8E38D),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  ),
                  child: const Text('Postar Advertência'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
