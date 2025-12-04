package com.example.demo.dto;

import java.time.LocalDate;

public class CadastroCompletoDTO {

    // --- Dados do aluno (usuário pessoa física)
    public String nome;
    public String sobrenome;
    public LocalDate dataNascimento;
    public String sexo; // "M","F","OUTRO"
    public String telefone;
    public String celular;
    public String email;
    public String matricula;
    public Integer idTurma;

    // Login do aluno
    public String loginAluno;
    public String senhaAluno;

    // --- Endereço do aluno (opcional mas presente na tela)
    public String rua;
    public String numero;
    public String bairro;
    public String cep;
    public String complemento;

    // --- Responsável acadêmico
    public String nomeResponsavelAcademico;
    public String cpfResponsavelAcademico;
    public String telefoneResponsavelAcademico;
    public String emailResponsavelAcademico;
    public String loginResponsavelAcademico;
    public String senhaResponsavelAcademico;

    // --- Responsável financeiro
    public String nomeResponsavelFinanceiro;
    public String cpfResponsavelFinanceiro;
    public String telefoneResponsavelFinanceiro;
    public String emailResponsavelFinanceiro;
    public String loginResponsavelFinanceiro;
    public String senhaResponsavelFinanceiro;
}
