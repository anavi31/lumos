package com.example.demo.controller;

import com.example.demo.model.Login;
import com.example.demo.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class LoginApiController {

    @Autowired
    private LoginService loginService;

    @PostMapping("/login")
    public Map<String, String> loginFlutter(@RequestParam String login,
                                            @RequestParam String senha) {

        Map<String, String> response = new HashMap<>();

        Login usuario = loginService.autenticar(login, senha);

        if (usuario == null) {
            response.put("status", "login_incorreto");
            return response;
        }

        switch (usuario.getTipoUsuario()) {
            case ALUNO:
                response.put("status", "al_home");
                break;

            case PROFESSOR:
                response.put("status", "pr_home");
                break;

            case RESPONSAVEL_ACADEMICO:
                response.put("status", "rf_home");
                break;

            case RESPONSAVEL_FINANCEIRO:
                response.put("status", "rf_home");
                break;

            case ADMIN:
                response.put("status", "sec_home");
                break;

            default:
                response.put("status", "erro_tipo_invalido");
        }

        return response;
    }
}
