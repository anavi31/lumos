package com.example.demo.repository;

import com.example.demo.model.ResponsavelAluno;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List; // <-- Faltava isso!

public interface ResponsavelAlunoRepository extends JpaRepository<ResponsavelAluno, Integer> {

    List<ResponsavelAluno> findByAlunoId(Integer idAluno);

}
