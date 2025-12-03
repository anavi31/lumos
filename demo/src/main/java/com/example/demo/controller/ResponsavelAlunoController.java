package com.example.demo.controller;

import com.example.demo.model.ResponsavelAluno;
import com.example.demo.model.PapelResponsavel;
import com.example.demo.service.ResponsavelAlunoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class ResponsavelAlunoController {

    @Autowired
    private ResponsavelAlunoService responsavelAlunoService;

    /**
     * Exemplo de chamada:
     * POST /api/aluno/5/responsavel/2/ACADEMICO
     */
    @PostMapping("/aluno/{idAluno}/responsavel/{idResponsavel}/{papel}")
    public ResponseEntity<?> vincularResponsavel(
            @PathVariable Integer idAluno,
            @PathVariable Integer idResponsavel,
            @PathVariable PapelResponsavel papel) {

        try {

            ResponsavelAluno relacao =
                    responsavelAlunoService.vincularResponsavelAoAluno(idResponsavel, idAluno, papel);

            return ResponseEntity.ok(relacao);

        } catch (RuntimeException e) {
            return ResponseEntity.status(404).body(e.getMessage());

        } catch (Exception e) {
            return ResponseEntity.status(500).body("Erro ao vincular responsável ao aluno.");
        }
    }
}
