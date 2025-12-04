package com.example.demo.service;

import com.example.demo.model.Aluno;
import com.example.demo.model.PapelResponsavel;
import com.example.demo.model.Responsavel;
import com.example.demo.model.ResponsavelAluno;
import com.example.demo.repository.AlunoRepository;
import com.example.demo.repository.ResponsavelAlunoRepository;
import com.example.demo.repository.ResponsavelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ResponsavelAlunoService {

    @Autowired
    private AlunoRepository alunoRepository;

    @Autowired
    private ResponsavelRepository responsavelRepository;

    @Autowired
    private ResponsavelAlunoRepository responsavelAlunoRepository;

    public ResponsavelAluno vincularResponsavelAoAluno(Responsavel responsavel, Aluno aluno, PapelResponsavel papel) {

        if (responsavel == null) throw new IllegalArgumentException("Responsável não pode ser nulo");
        if (aluno == null) throw new IllegalArgumentException("Aluno não pode ser nulo");

        if (papel == null) {
            papel = PapelResponsavel.ACADEMICO;
        }

        ResponsavelAluno rel = new ResponsavelAluno();
        rel.setResponsavel(responsavel);
        rel.setAluno(aluno);
        rel.setPapel(papel);

        return responsavelAlunoRepository.save(rel);
    }

    public ResponsavelAluno vincularResponsavelAoAluno(Integer idResponsavel, Integer idAluno, PapelResponsavel papel) {

        Aluno aluno = alunoRepository.findById(idAluno)
                .orElseThrow(() -> new RuntimeException("Aluno não encontrado: " + idAluno));

        Responsavel responsavel = responsavelRepository.findById(idResponsavel)
                .orElseThrow(() -> new RuntimeException("Responsável não encontrado: " + idResponsavel));

        return vincularResponsavelAoAluno(responsavel, aluno, papel);
    }
}
