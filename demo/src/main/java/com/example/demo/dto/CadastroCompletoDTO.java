package com.example.demo.dto;

import java.time.LocalDate;

public class CadastroCompletoDTO {

    // Dados do aluno
    public String nome;
    public String sobrenome;
    public LocalDate dataNascimento;
    public String sexo;
    public String telefone;
    public String celular;
    public String email;
    public String loginAluno;
    public String senhaAluno;
    public String matricula;
    public Integer idTurma;

    // Endereço
    public String rua;
    public String numero;
    public String bairro;
    public String cep;
    public String complemento;

    // Responsável Acadêmico
    public String nomeRespAcademico;
    public String cpfRespAcademico;
    public String telefoneRespAcademico;
    public String emailRespAcademico; // <-- ADICIONADO

    // Responsável Financeiro
    public String nomeRespFinanceiro;
    public String cpfRespFinanceiro;
    public String telefoneRespFinanceiro;
    public String emailRespFinanceiro; // <-- ADICIONADO
}
