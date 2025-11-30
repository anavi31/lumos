package com.lumos.lumos;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.*;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
@RequestMapping("/api/chamadas")
@CrossOrigin(origins = "*")
public class LumosController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping
    public List<Map<String, Object>> listarChamadas(
            @RequestParam(required = false) Integer idHorarioAula) {

        if (idHorarioAula == null) {
            idHorarioAula = 1;
        }

        String sql = """
            SELECT 
                a.id_aluno AS id,
                a.matricula,
                CONCAT(u.nome, ' ', u.sobrenome) AS aluno,
                COALESCE(f.presente, 0) AS presenca
            FROM aluno a
            JOIN usuario u ON u.id_usuario = a.id_usuario
            LEFT JOIN frequencia f 
                ON f.id_aluno = a.id_aluno
            AND f.id_horarioAula = ?
            AND f.data = CURDATE()
            ORDER BY aluno
        """;

        return jdbcTemplate.queryForList(sql, idHorarioAula);
    }

    @PostMapping("/registrar")
    public Map<String, Object> registrarChamada(@RequestBody Map<String, Object> body) {

        Integer idAluno = (Integer) body.get("idAluno");
        Integer idHorarioAula = (Integer) body.get("idHorarioAula");
        Boolean presente = (Boolean) body.get("presente");

        String sql = """
            INSERT INTO frequencia (id_horarioAula, id_aluno, data, presente)
            VALUES (?, ?, CURDATE(), ?)
            ON DUPLICATE KEY UPDATE presente = VALUES(presente)
        """;

        jdbcTemplate.update(sql, idHorarioAula, idAluno, presente);

        String sqlFaltas = """
            SELECT COUNT(*) AS faltas
            FROM frequencia
            WHERE id_aluno = ? AND presente = 0
        """;

        Map<String, Object> resultado = jdbcTemplate.queryForMap(sqlFaltas, idAluno);

        return Map.of(
            "mensagem", "Chamada registrada!",
            "faltasAtualizadas", resultado.get("faltas")
        );
    }

}
