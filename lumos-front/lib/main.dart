import 'package:flutter/material.dart';

//Auntenticação
import 'screens/autenticacao/login_screen.dart';
import 'screens/autenticacao/esqueci_senha_screen.dart';
import 'screens/autenticacao/nova_senha_screen.dart';
//Aluno
import 'screens/aluno/al_home_screen.dart';
import 'screens/aluno/al_horario_screen.dart';
import 'screens/aluno/al_avisos_screen.dart';
import 'screens/aluno/al_notas_screen.dart';
import 'screens/aluno/al_faltas_screen.dart';
//Professor
import 'screens/professor/pr_home_screen.dart';
import 'screens/professor/pr_horario_screen.dart';
import 'screens/professor/pr_aviso_screen.dart';
import 'screens/professor/pr_notas_screen.dart';
import 'screens/professor/pr_chamadas_screen.dart';
//Responsável Acadêmico
import 'screens/responsavel_academico/ra_home_screen.dart';
import 'screens/responsavel_academico/ra_notas_screen.dart';
import 'screens/responsavel_academico/ra_horario_screen.dart';
import 'screens/responsavel_academico/ra_avisos_screen.dart';
import 'screens/responsavel_academico/ra_advertencias_screen.dart';
import 'screens/responsavel_academico/ra_faltas_screen.dart';
//Responsável Financeiro
import 'package:lumos/screens/responsavel_financeiro/rf_home_screen.dart';
import 'package:lumos/screens/responsavel_financeiro/rf_financeiro_screen.dart';
import 'package:lumos/screens/responsavel_financeiro/rf_notas_screen.dart';
import 'package:lumos/screens/responsavel_financeiro/rf_faltas_screen.dart';
//Secretaria
import '../screens/secretaria/sec_home_screen.dart';
import 'screens/secretaria/sec_criar_perfil_screen.dart';
import 'screens/secretaria/sec_gerenciar_screen.dart';
import 'screens/secretaria/sec_gerenciar_aluno_screen.dart';
import 'screens/secretaria/sec_gerenciar_professor.dart';
import 'screens/secretaria/sec_desativar_perfil_screen.dart';
import 'screens/secretaria/sec_avisos_screen.dart';
import 'screens/secretaria/sec_advertencias_screen.dart';

void main() {
  runApp(const LumosApp());
}

class LumosApp extends StatelessWidget {
  const LumosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF5F4F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFDCC9FF),
        ),
      ),
      initialRoute: '/login', // !! VC ALTERA AQUI A TELA QUE VC QUER QUE RODE PRIMEIRO ok !! (só enquanto as credenciais no login n tão prontas)

      routes: {
        '/login': (context) => const LoginScreen(),
        '/esqueci_senha': (context) => const EsqueciSenhaScreen(),
        '/nova_senha': (context) => const NovaSenhaScreen(),
        '/al_home': (context) => const AlHomeScreen(),
        '/al_notas': (context) => const AlNotasScreen(),
        '/al_horario': (context) => const AlHorarioScreen(),
        '/al_avisos': (context) => const AlAvisosScreen(),
        '/al_faltas': (context) => const AlFaltasScreen(),
        '/pr_home': (context) => const PrHomeScreen(),
        '/pr_horario':(context) => const PrHorarioScreen(),
        'pr_avisos':(context) => const PrAvisosScreen(),
        '/pr_notas':(context) => const PrNotasScreen(),
        '/pr_chamadas':(context) => const PrChamadasScreen(),
        '/ra_home': (context) => const RaHomeScreen(),
        '/ra_notas': (context) => const RaNotasScreen(),
        '/ra_horario': (context) => const RaHorarioScreen(),
        '/ra_avisos': (context) => const RaAvisosScreen(),
        '/ra_advertencias': (context) => const RaAdvertenciasScreen(),
        '/ra_faltas': (context) => const RaFaltasScreen(),
        '/rf_faltas': (context) => const RfFaltasScreen(),
        '/rf_financeiro': (context) => const RfFinanceiroScreen(),
        '/rf_notas': (context) => const RfNotasScreen(),
        '/rf_home': (context) => const RfHomeScreen(),
        '/sec_home': (context) => const SecHomeScreen(),
        '/sec_criar_perfil': (context) => const CriarPerfilScreen(),
        '/sec_gerenciar_perfil': (context) => const GerenciarScreen(),
        '/sec_gerenciar_aluno': (context) => const GerenciarALScreen(),
        '/sec_gerenciar_professor': (context) => const GerenciarPRScreen(),
        '/sec_desativar_perfil': (context) => const DesativarPerfisScreen(),
        '/sec_avisos': (context) => const SecAvisosScreen(),
        '/sec_advertencias': (context) => const SecAdvertenciasScreen(),
      },
    );
  }
}