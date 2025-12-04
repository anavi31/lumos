package com.example.demo.service;

import com.example.demo.model.Aluno;
import com.example.demo.model.Turma;
import com.example.demo.model.Usuario;
import com.example.demo.repository.AlunoRepository;
import com.example.demo.repository.TurmaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlunoService {

    @Autowired
    private AlunoRepository alunoRepository;

    @Autowired
    private TurmaRepository turmaRepository;

    public Aluno criarAluno(Usuario usuario, Integer idTurma, String matricula) {

        if (matricula == null || matricula.isBlank()) {
            throw new RuntimeException("Matrícula do aluno é obrigatória.");
        }

        Turma turma = turmaRepository.findById(idTurma)
                .orElseThrow(() -> new RuntimeException("Turma não encontrada: " + idTurma));

        Aluno aluno = new Aluno();
        aluno.setUsuario(usuario);
        aluno.setTurma(turma);
        aluno.setMatricula(matricula);

        return alunoRepository.save(aluno);
    }

    public Aluno buscarPorId(Integer id) {
        return alunoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Aluno não encontrado: " + id));
    }
}
