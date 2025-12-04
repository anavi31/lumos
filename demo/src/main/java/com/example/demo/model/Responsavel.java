package com.example.demo.model;

import jakarta.persistence.*;

@Entity
@Table(name = "responsavel")
public class Responsavel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_responsavel")
    private Integer idResponsavel;

    // Relacionamento com usuário (já existe a FK no banco)
    @OneToOne
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    private Usuario usuario;

    @Column(length = 14)
    private String cpf;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_responsavel", length = 20)
    private TipoResponsavel tipoResponsavel;

    @Enumerated(EnumType.STRING)
    @Column(name = "tipo_acesso", length = 20)
    private TipoAcesso tipoAcesso = TipoAcesso.ACADEMICO;

    @Column(length = 20)
    private String telefone;

    // getters & setters
    public Integer getIdResponsavel() { return idResponsavel; }
    public void setIdResponsavel(Integer idResponsavel) { this.idResponsavel = idResponsavel; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public String getCpf() { return cpf; }
    public void setCpf(String cpf) { this.cpf = cpf; }

    public TipoResponsavel getTipoResponsavel() { return tipoResponsavel; }
    public void setTipoResponsavel(TipoResponsavel tipoResponsavel) { this.tipoResponsavel = tipoResponsavel; }

    public TipoAcesso getTipoAcesso() { return tipoAcesso; }
    public void setTipoAcesso(TipoAcesso tipoAcesso) { this.tipoAcesso = tipoAcesso; }

    public String getTelefone() { return telefone; }
    public void setTelefone(String telefone) { this.telefone = telefone; }
}
