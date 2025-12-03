import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_professor.dart';

class PrNotasScreen extends StatefulWidget {
  const PrNotasScreen({super.key});

  @override
  State<PrNotasScreen> createState() => _PrNotasScreenState();
}

class _PrNotasScreenState extends State<PrNotasScreen> {
  final List<Map<String, dynamic>> alunos = [
    {'nome': 'Allana Sobrenome Sobrenome', 'matricula': '1234567812', 'n1': 6.5, 'n2': 5.2, 'n3': 0.0},
    {'nome': 'Amanda Sobrenome Sobrenome', 'matricula': '1234567812', 'n1': 7.0, 'n2': 7.2, 'n3': 0.0},
    {'nome': 'Antônio Sobrenome Sobrenome', 'matricula': '1234567812', 'n1': 4.0, 'n2': 8.9, 'n3': 0.0},
    {'nome': 'Bárbara Sobrenome Sobrenome', 'matricula': '9876541230', 'n1': 5.3, 'n2': 6.0, 'n3': 0.0},
    {'nome': 'Bruno Sobrenome Sobrenome', 'matricula': '3265785423', 'n1': 8.1, 'n2': 4.9, 'n3': 0.0},
    {'nome': 'Caio Sobrenome Sobrenome', 'matricula': '9865745230', 'n1': 6.5, 'n2': 6.5, 'n3': 0.0},
    {'nome': 'Fernanda Sobrenome Sobrenome', 'matricula': '0235648954', 'n1': 5.9, 'n2': 5.5, 'n3': 0.0},
    {'nome': 'Hugo Sobrenome Sobrenome', 'matricula': '1254785206', 'n1': 9.0, 'n2': 7.5, 'n3': 0.0},
    {'nome': 'Joana Sobrenome Sobrenome', 'matricula': '1426985425', 'n1': 3.4, 'n2': 8.8, 'n3': 0.0},
    {'nome': 'Júlia Sobrenome Sobrenome', 'matricula': '3210569874', 'n1': 2.1, 'n2': 9.3, 'n3': 0.0},
    {'nome': 'Lucas Sobrenome Sobrenome', 'matricula': '3025631007', 'n1': 6.7, 'n2': 7.4, 'n3': 0.0},
    {'nome': 'Luciana Sobrenome Sobrenome', 'matricula': '5478654201', 'n1': 8.9, 'n2': 5.2, 'n3': 0.0},
    {'nome': 'Lis Sobrenome Sobrenome', 'matricula': '4511256335', 'n1': 8.0, 'n2': 9.5, 'n3': 0.0},
    {'nome': 'Nathália Sobrenome Sobrenome', 'matricula': '7854124569', 'n1': 9.3, 'n2': 8.0, 'n3': 0.0},
    {'nome': 'Pedro Sobrenome Sobrenome', 'matricula': '3022278104', 'n1': 9.5, 'n2': 9.8, 'n3': 0.0},
  ];

  List<double> medias = [];

  @override
  void initState() {
    super.initState();
    _calcularTodas();
  }

  void _calcularTodas() {
    medias = alunos.map((aluno) {
      double m = ((aluno['n1'] + aluno['n2'] + aluno['n3']) / 3);
      return double.parse(m.toStringAsFixed(1));
    }).toList();
    setState(() {});
  }

  void _calcularMedia(int index) {
    double m = (alunos[index]['n1'] + alunos[index]['n2'] + alunos[index]['n3']) / 3;
    medias[index] = double.parse(m.toStringAsFixed(1));
    setState(() {});
  }

  String? serieTurmaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerPR(),
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            width: 1000,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDCC9FF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lançar notas',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                          SizedBox(height: 6),
                          Text('Disciplina: Biologia'),
                          Text('Docente: Professora X'),
                          Text('Ano: 2025'),
                          Text('Período: 3º Trimestre'),
                        ],
                      ),

                      SizedBox(
                        width: 140,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E1FF),
                            labelText: 'Série/Turma',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                                borderSide: BorderSide.none),
                          ),
                          initialValue: serieTurmaSelecionada,
                          items: const [
                            DropdownMenuItem(value: "1A", child: Text("1° A")),
                            DropdownMenuItem(value: "2A", child: Text("2° A")),
                            DropdownMenuItem(value: "3A", child: Text("3° A")),
                            DropdownMenuItem(value: "1B", child: Text("1° B")),
                            DropdownMenuItem(value: "2B", child: Text("2° B")),
                            DropdownMenuItem(value: "3B", child: Text("3° B")),
                          ],
                          onChanged: (v) {
                            setState(() => serieTurmaSelecionada = v);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(const Color(0xFFE6F1FF)),
                          columns: const [
                            DataColumn(label: Text('Nº')),
                            DataColumn(label: Text('Estudante')),
                            DataColumn(label: Text('Matrícula')),
                            DataColumn(label: Text('1ª Unidade')),
                            DataColumn(label: Text('2ª Unidade')),
                            DataColumn(label: Text('3ª Unidade')),
                            DataColumn(label: Text('Média')),
                          ],
                          rows: List.generate(alunos.length, (i) {
                            final aluno = alunos[i];

                            return DataRow(cells: [
                              DataCell(Text('${i + 1}'.padLeft(2, '0'))),
                              DataCell(Text(aluno['nome'])),
                              DataCell(Text(aluno['matricula'])),
                              DataCell(_campoNota(i, 'n1')),
                              DataCell(_campoNota(i, 'n2')),
                              DataCell(_campoNota(i, 'n3')),
                              DataCell(Text(medias[i].toString())),
                            ]);
                          }),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoNota(int index, String campo) {
    final controller = TextEditingController(
      text: alunos[index][campo].toString(),
    );

    return SizedBox(
      width: 65,
      height: 32, // 🔥 MAIS BAIXINHA
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: TextInputType.number,
        onSubmitted: (value) {
          alunos[index][campo] = double.tryParse(value) ?? 0.0;
          _calcularMedia(index);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

}
