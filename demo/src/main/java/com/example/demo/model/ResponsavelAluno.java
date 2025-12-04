package com.example.demo.model;

import jakarta.persistence.*;

@Entity
@Table(name = "responsavel_aluno")
public class ResponsavelAluno {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_responsavel_aluno")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_responsavel", nullable = false)
    private Responsavel responsavel;

    @ManyToOne
    @JoinColumn(name = "id_aluno", nullable = false)
    private Aluno aluno;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private PapelResponsavel papel;

    // getters e setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Responsavel getResponsavel() { return responsavel; }
    public void setResponsavel(Responsavel responsavel) { this.responsavel = responsavel; }

    public Aluno getAluno() { return aluno; }
    public void setAluno(Aluno aluno) { this.aluno = aluno; }

    public PapelResponsavel getPapel() { return papel; }
    public void setPapel(PapelResponsavel papel) { this.papel = papel; }
}
