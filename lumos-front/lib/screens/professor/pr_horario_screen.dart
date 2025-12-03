import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_professor.dart';

class PrHorarioScreen extends StatelessWidget {
  const PrHorarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerPR(),
      appBar: AppBar(
        title: const Text(
          'Grade Horária',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F4F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: Table(
                border: TableBorder(
                  horizontalInside: BorderSide(color: Colors.grey.shade300),
                ),
                columnWidths: const {
                  0: FixedColumnWidth(80),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                  5: FlexColumnWidth(),
                },
                children: [
                  _buildHeaderRow(),
                  ..._buildHorarioRows(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildHeaderRow() {
    final headers = ['Horário', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta'];
    return TableRow(
      children: List.generate(headers.length, (index) {
        final radius = index == 0
            ? const BorderRadius.only(topLeft: Radius.circular(12))
            : index == headers.length - 1
                ? const BorderRadius.only(topRight: Radius.circular(12))
                : BorderRadius.zero;
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F1FF),
            borderRadius: radius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child: Text(
              headers[index],
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

  List<TableRow> _buildHorarioRows() {
    final linhas = [
      ['7:30', '1°B', '3°A', '2°B', '-', '3°A'],
      ['8:20', '2°C', '3°C', '1°C', '-', '1°A'],
      ['9:10', 'Intervalo', 'Intervalo', 'Intervalo', 'Intervalo', 'Intervalo'],
      ['9:30', '2°A', '1°A', '3°B', '3°C', '1°C'],
      ['10:20', '3°B', '2°B', '1°B', '2°C', '2°A'],
    ];

    return linhas.map((linha) {
      return TableRow(
        children: linha.map((c) {
          final isIntervalo = c == 'Intervalo';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 15,
                  color: isIntervalo ? Colors.grey.shade500 : Colors.black87,
                  fontWeight: isIntervalo ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      );
    }).toList();
  }
}
