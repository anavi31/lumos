import 'package:flutter/material.dart';
import '../../widgets/lumos_drawer_secretaria.dart';

class CriarPerfilScreen extends StatefulWidget {
  const CriarPerfilScreen({super.key});

  @override
  State<CriarPerfilScreen> createState() => _CriarPerfilScreenState();
}

class _CriarPerfilScreenState extends State<CriarPerfilScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String tipoPerfil = "Aluno";

  String? sexoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const LumosDrawerSEC(),

      appBar: AppBar(
        backgroundColor: const Color(0xFFDCC9FF),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/sec_home'),
            child: const Text("Cancelar", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () => _formKey.currentState!.reset(),
            child: const Text("Resetar", style: TextStyle(color: Colors.black)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF7D774),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Perfil salvo com sucesso!"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: const Text("Salvar", style: TextStyle(color: Colors.black)),
            ),
          )
        ],
      ),

      backgroundColor: const Color(0xFFF5F4F9),

      body: LayoutBuilder(
        builder: (context, constraints) {
          bool mobile = constraints.maxWidth < 900;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Adicionar Perfil",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 20),
                          _dropdownTipoPerfil(),
                        ],
                      ),

                      const SizedBox(height: 30),

                      tipoPerfil == "Aluno"
                          ? _buildAlunoLayout(mobile)
                          : _buildProfessorLayout(mobile),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dropdownTipoPerfil() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: tipoPerfil,
          items: const [
            DropdownMenuItem(value: "Aluno", child: Text("Aluno")),
            DropdownMenuItem(value: "Professor", child: Text("Professor")),
          ],
          onChanged: (value) => setState(() => tipoPerfil = value!),
        ),
      ),
    );
  }

  Widget _buildAlunoLayout(bool mobile) {
    return mobile
        ? Column(
            children: [
              _blocoAluno(),
              const SizedBox(height: 20),
              _blocoResponsaveis(),
              const SizedBox(height: 20),
              _blocoLoginAluno(),
              const SizedBox(height: 20),
              _blocoLoginRespAcad(),
              const SizedBox(height: 20),
              _blocoLoginRespFin(),
              const SizedBox(height: 20),
              _blocoEnderecoAluno(),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _blocoAluno(),
                    const SizedBox(height: 20),
                    _blocoLoginAluno(),
                    const SizedBox(height: 20),
                    _blocoLoginRespAcad(),
                    const SizedBox(height: 20),
                    _blocoLoginRespFin(),
                  ],
                ),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  children: [
                    _blocoResponsaveis(),
                    const SizedBox(height: 20),
                    _blocoEnderecoAluno(),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _buildProfessorLayout(bool mobile) {
    return mobile
        ? Column(
            children: [
              _blocoContatoProfessor(),
              const SizedBox(height: 20),
              _blocoLoginProfessor(),
              const SizedBox(height: 20),
              _blocoBasicoProfessor(),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _blocoContatoProfessor(),
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  children: [
                    _blocoLoginProfessor(),
                    const SizedBox(height: 20),
                    _blocoBasicoProfessor(),
                  ],
                ),
              ),
            ],
          );
  }

  Widget _titulo(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          t,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      );

  Widget _input(String label, String hint, {double? width}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _card({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _blocoAluno() {
    return _card(
      children: [
        _titulo("Informações do Aluno"),
        Row(
          children: [
            Expanded(child: _input("Primeiro Nome", "Nome")),
            const SizedBox(width: 12),
            Expanded(child: _input("Sobrenome", "Sobrenome")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("Data de Nascimento", "dd/mm/aaaa")),
            const SizedBox(width: 12),
            Expanded(child: _input("Matrícula", "N° de matrícula")),
          ],
        ),
      ],
    );
  }

  Widget _blocoResponsaveis() {
    return _card(
      children: [
        _titulo("Informações dos Responsáveis"),
        Row(
          children: [
            Expanded(child: _input("Nome Responsável Acadêmico", "Nome completo")),
            const SizedBox(width: 12),
            Expanded(child: _input("Nome Responsável Financeiro", "Nome completo")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("CPF Acadêmico", "000.000.000-00")),
            const SizedBox(width: 12),
            Expanded(child: _input("CPF Financeiro", "000.000.000-00")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("Telefone Acadêmico", "(00) 00000-0000")),
            const SizedBox(width: 12),
            Expanded(child: _input("Telefone Financeiro", "(00) 00000-0000")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("Email Acadêmico", "exemplo@gmail.com")),
            const SizedBox(width: 12),
            Expanded(child: _input("Email Financeiro", "exemplo@gmail.com")),
          ],
        ),
      ],
    );
  }

  Widget _blocoLoginAluno() {
    return _card(
      children: [
        _titulo("Login do Aluno"),
        Row(
          children: [
            Expanded(child: _input("Matrícula do Aluno", "")),
            const SizedBox(width: 12),
            Expanded(child: _input("Data de nascimento do aluno", "dd/mm/aaaa")),
          ],
        ),
      ],
    );
  }

  Widget _blocoLoginRespAcad() {
    return _card(
      children: [
        _titulo("Login do Responsável Acadêmico"),
        Row(
          children: [
            Expanded(child: _input("CPF", "000.000.000-00")),
            const SizedBox(width: 12),
            Expanded(child: _input("Data de nascimento do aluno", "dd/mm/aaaa")),
          ],
        ),
      ],
    );
  }

  Widget _blocoLoginRespFin() {
    return _card(
      children: [
        _titulo("Login do Responsável Financeiro"),
        Row(
          children: [
            Expanded(child: _input("CPF", "000.000.000-00")),
            const SizedBox(width: 12),
            Expanded(child: _input("Data de nascimento do aluno", "dd/mm/aaaa")),
          ],
        ),
      ],
    );
  }

  Widget _blocoEnderecoAluno() {
    return _card(
      children: [
        _titulo("Endereço do Aluno"),
        _input("Rua", ""),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("Número", "")),
            const SizedBox(width: 12),
            Expanded(child: _input("Bairro", "")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("CEP", "")),
            const SizedBox(width: 12),
            Expanded(child: _input("Complemento", "")),
          ],
        ),
      ],
    );
  }

  Widget _blocoContatoProfessor() {
    return _card(
      children: [
        _titulo("Informações de Contato"),
        Row(
          children: [
            Expanded(child: _input("Celular", "(00) 00000-0000")),
            const SizedBox(width: 12),
            Expanded(child: _input("Telefone", "0000-0000")),
          ],
        ),
        const SizedBox(height: 12),
        _input("Email", "exemplo@gmail.com"),
        const SizedBox(height: 12),
        _input("Rua", ""),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("Número", "")),
            const SizedBox(width: 12),
            Expanded(child: _input("Bairro", "")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("CEP", "")),
            const SizedBox(width: 12),
            Expanded(child: _input("Complemento", "")),
          ],
        ),
      ],
    );
  }

  Widget _blocoLoginProfessor() {
    return _card(
      children: [
        _titulo("Login do(a) Professor(a)"),
        Row(
          children: [
            Expanded(child: _input("CPF", "000.000.000-00")),
            const SizedBox(width: 12),
            Expanded(child: _input("Data de nascimento", "dd/mm/aaaa")),
          ],
        ),
      ],
    );
  }

  Widget _blocoBasicoProfessor() {

    return _card(
      children: [
        _titulo("Informações Básicas"),
        Row(
          children: [
            Expanded(child: _input("Primeiro Nome*", "Nome")),
            const SizedBox(width: 12),
            Expanded(child: _input("Sobrenome*", "Sobrenome")),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _input("Data de Nascimento*", "dd/mm/aaaa")),
            const SizedBox(width: 12),
            Expanded(child: _input("CPF*", "000.000.000-00")),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Sexo"),
            Row(
              children: [
                RadioMenuButton<String>(
                  value: "M",
                  groupValue: sexoSelecionado,
                  onChanged: (value) {
                    setState(() => sexoSelecionado = value);
                  },
                  child: const Text("Masculino"),
                ),
                const SizedBox(width: 20),
                RadioMenuButton<String>(
                  value: "F",
                  groupValue: sexoSelecionado,
                  onChanged: (value) {
                    setState(() => sexoSelecionado = value);
                  },
                  child: const Text("Feminino"),
                ),
              ],
    )

          ],
        ),
        const SizedBox(height: 12),
        _input("Disciplina*", ""),
      ],
    );
  }
}
