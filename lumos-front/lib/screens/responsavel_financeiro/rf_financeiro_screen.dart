import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_rf.dart';

class RfFinanceiroScreen extends StatefulWidget {
  const RfFinanceiroScreen({super.key});

  @override
  State<RfFinanceiroScreen> createState() => _RfFinanceiroScreenState();
}

class _RfFinanceiroScreenState extends State<RfFinanceiroScreen> {
  bool selecionado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerRF(),
      appBar: AppBar(
        title: const Text(
          'Débitos Pendentes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F4F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Scroll horizontal só pra tabela
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: 900, // define uma largura mínima pro conteúdo da tabela
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 3),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE6E1FF),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Expanded(flex: 2, child: Text('Selecionar', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(flex: 2, child: Text('Débito', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(child: Text('Parcela', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(child: Text('Série', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(flex: 2, child: Text('Competência', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(flex: 2, child: Text('Data Vencimento', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(flex: 2, child: Text('Valor Total', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(flex: 2, child: Text('Multas e Juros *', textAlign: TextAlign.center, style: _headerStyle)),
                          Expanded(flex: 2, child: Text('Valor Atualizado', textAlign: TextAlign.center, style: _headerStyle)),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Checkbox(
                              value: selecionado,
                              onChanged: (value) {
                                setState(() => selecionado = value ?? false);
                              },
                            ),
                          ),
                          const Expanded(flex: 2, child: Text('Mensalidade', textAlign: TextAlign.center)),
                          const Expanded(child: Text('10', textAlign: TextAlign.center)),
                          const Expanded(child: Text('3º', textAlign: TextAlign.center)),
                          const Expanded(flex: 2, child: Text('out/2025', textAlign: TextAlign.center)),
                          const Expanded(flex: 2, child: Text('05/12/2025', textAlign: TextAlign.center)),
                          const Expanded(flex: 2, child: Text('R\$ 627,33', textAlign: TextAlign.center)),
                          const Expanded(flex: 2, child: Text('R\$ 0,00', textAlign: TextAlign.center)),
                          const Expanded(flex: 2, child: Text('R\$ 627,33', textAlign: TextAlign.center)),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text('Total Selecionado:   R\$ 627,33',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          SizedBox(width: 16),
                          Text('R\$ 0,00'),
                          SizedBox(width: 16),
                          Text('R\$ 627,33',
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '*Calculados até: 20/11/2025',
                style: TextStyle(fontSize: 12, color: Colors.black54, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Formas de Pagamento',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              width: 220,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black26),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: null,
                  hint: const Text('--Selecione--'),
                  items: const [
                    DropdownMenuItem(value: 'boleto', child: Text('Boleto Bancário')),
                    DropdownMenuItem(value: 'pix', child: Text('PIX')),
                    DropdownMenuItem(value: 'cartao', child: Text('Cartão de Crédito')),
                  ],
                  onChanged: (value) {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TextStyle _headerStyle = TextStyle(
  fontWeight: FontWeight.w600,
  color: Color(0xFF2B2B2B),
  fontSize: 14,
);
