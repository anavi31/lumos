package com.example.demo.controller;

import com.example.demo.dto.CadastroCompletoDTO;
import com.example.demo.model.*;
import com.example.demo.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cadastro")
@CrossOrigin(origins = "*")
public class CadastroCompletoController {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private EnderecoService enderecoService;

    @Autowired
    private AlunoService alunoService;

    @Autowired
    private LoginService loginService;

    @Autowired
    private ResponsavelService responsavelService;

    @Autowired
    private ResponsavelAlunoService responsavelAlunoService;

    @PostMapping("/aluno")
    @Transactional
    public ResponseEntity<?> cadastrarAlunoCompleto(@RequestBody CadastroCompletoDTO dto) {

        // ---------------- VALID AÇÕES ----------------
        if (dto == null) {
            return ResponseEntity.badRequest().body("Payload vazio.");
        }
        if (dto.loginAluno == null || dto.senhaAluno == null) {
            return ResponseEntity.badRequest().body("Login e senha do aluno são obrigatórios.");
        }
        if (dto.nome == null || dto.email == null) {
            return ResponseEntity.badRequest().body("Nome e e-mail do aluno são obrigatórios.");
        }

        // ---------------- ENDEREÇO (opcional) ----------------
        Endereco endereco = null;
        boolean temEndereco =
                (dto.rua != null && !dto.rua.isBlank()) ||
                (dto.bairro != null && !dto.bairro.isBlank()) ||
                (dto.cep != null && !dto.cep.isBlank());

        if (temEndereco) {
            endereco = enderecoService.criarEndereco(
                    dto.rua,
                    dto.numero,
                    dto.bairro,
                    dto.cep,
                    dto.complemento
            );
        }

        // ---------------- USUÁRIO ----------------
        Usuario usuarioAluno = usuarioService.criarUsuarioBasico(
                dto.nome,
                dto.sobrenome,
                dto.dataNascimento,
                dto.sexo,
                dto.telefone,
                dto.celular,
                dto.email
        );

        if (endereco != null) {
            usuarioAluno.setEndereco(endereco);
            usuarioAluno = usuarioService.salvarUsuario(usuarioAluno);
        }

        // ---------------- ALUNO ----------------
        Aluno aluno = alunoService.criarAluno(
                usuarioAluno,
                dto.idTurma,
                dto.matricula
        );

        // ---------------- LOGIN ----------------
        loginService.criarLogin(
                usuarioAluno,
                dto.loginAluno,
                dto.senhaAluno,
                TipoUsuario.ALUNO
        );

        // ---------------- RESPONSÁVEL ACADÊMICO ----------------
        Responsavel respAcad = responsavelService.criarResponsavel(
                dto.nomeRespAcademico,
                dto.cpfRespAcademico,
                dto.telefoneRespAcademico
        );

        responsavelAlunoService.vincularResponsavelAoAluno(
                respAcad,
                aluno,
                PapelResponsavel.ACADEMICO
        );

        // ---------------- RESPONSÁVEL FINANCEIRO ----------------
        Responsavel respFin = responsavelService.criarResponsavel(
                dto.nomeRespFinanceiro,
                dto.cpfRespFinanceiro,
                dto.telefoneRespFinanceiro
        );

        responsavelAlunoService.vincularResponsavelAoAluno(
                respFin,
                aluno,
                PapelResponsavel.FINANCEIRO
        );

        // ---------------- RETORNO ----------------
        return ResponseEntity.ok("Aluno cadastrado com sucesso!");
    }
}
