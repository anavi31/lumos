import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_rf.dart';

class RfNotasScreen extends StatelessWidget {
  const RfNotasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerRF(),
      appBar: AppBar(
        title: const Text(
          'Notas',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F4F9),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Center(
              child: Container(
                width: isMobile ? double.infinity : constraints.maxWidth * 0.9,
                constraints: const BoxConstraints(maxWidth: 1100),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 3)
                  ],
                ),
                child: isMobile
                    ? _buildMobileTable()
                    : _buildDesktopTable(),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Layout para telas grandes (desktop/tablet)
  Widget _buildDesktopTable() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey.shade300),
        ),
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
        },
        children: [
          _buildHeaderRow(),
          ..._buildNotaRows(),
        ],
      ),
    );
  }

  /// Layout adaptado para telas pequenas (celulares)
  Widget _buildMobileTable() {
    final dados = _dadosNotas();
    return Column(
      children: dados.map((linha) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                linha[0], // Matéria
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1° Unidade: ${linha[1]} | 2° Unidade: ${linha[2]}'),
                  Text('Média: ${linha[4]}'),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  TableRow _buildHeaderRow() {
    final headers = [
      'Matéria',
      '1° Unidade',
      '2° Unidade',
      '3° Unidade',
      'Média'
    ];

    return TableRow(
      children: List.generate(headers.length, (index) {
        return Container(
          color: const Color(0xFFE6F1FF),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Center(
            child: Text(
              headers[index],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF2B2B2B),
              ),
            ),
          ),
        );
      }),
    );
  }

  List<TableRow> _buildNotaRows() {
    final dados = _dadosNotas();
    return dados.map((linha) {
      return TableRow(
        children: linha.map((c) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Center(
              child: Text(
                c,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }).toList();
  }

  List<List<String>> _dadosNotas() => [
        ['Português', '6,5', '7,0', '---', '4,5'],
        ['Matemática', '7,0', '9,5', '---', '5,5'],
        ['História', '4,0', '5,8', '---', '3,3'],
        ['Geografia', '5,3', '6,0', '---', '3,8'],
        ['Física', '5,1', '6,5', '---', '3,9'],
        ['Química', '6,5', '7,0', '---', '4,5'],
        ['Biologia', '5,9', '8,4', '---', '4,8'],
        ['Inglês', '9,0', '10', '---', '6,3'],
        ['Artes', '8,4', '8,0', '---', '5,5'],
        ['Educação Física', '10', '10', '---', '6,7'],
        ['Filosofia', '8,7', '7,6', '---', '5,4'],
        ['Sociologia', '8,9', '9,5', '---', '6,1'],
      ];
}
