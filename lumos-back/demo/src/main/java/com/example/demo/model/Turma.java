package com.example.demo.model;

import jakarta.persistence.*;

@Entity
@Table(name = "turma")
public class Turma {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_turma")
    private Integer idTurma;

    // Armazenamos a série como STRING (usando o enum Serie)
    @Enumerated(EnumType.STRING)
    private Serie serie;

    // Turno (M, T, N, A)
    @Enumerated(EnumType.STRING)
    private Turno turno;

    @Column(name = "ano_letivo")
    private Integer anoLetivo;

    @Column(length = 10)
    private String sala;

    public Turma() {}

    // getters & setters
    public Integer getIdTurma() { return idTurma; }
    public void setIdTurma(Integer idTurma) { this.idTurma = idTurma; }

    public Serie getSerie() { return serie; }
    public void setSerie(Serie serie) { this.serie = serie; }

    public Turno getTurno() { return turno; }
    public void setTurno(Turno turno) { this.turno = turno; }

    public Integer getAnoLetivo() { return anoLetivo; }
    public void setAnoLetivo(Integer anoLetivo) { this.anoLetivo = anoLetivo; }

    public String getSala() { return sala; }
    public void setSala(String sala) { this.sala = sala; }
}
