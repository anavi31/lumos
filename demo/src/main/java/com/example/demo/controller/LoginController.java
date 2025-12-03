package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.demo.model.Login;
import com.example.demo.model.TipoUsuario;
import com.example.demo.service.LoginService;

@Controller
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/login")
    public String mostrarLogin() {
        return "login";
    }

    @PostMapping("/login")
    public String processarLogin(
            @RequestParam String login,
            @RequestParam String senha,
            Model model) {

        Login usuario = loginService.autenticar(login, senha);

        if (usuario == null) {
            model.addAttribute("erro", "Login ou senha inválidos!");
            return "login";
        }

        TipoUsuario tipo = usuario.getTipoUsuario();

        // Redirecionamentos por tipo
        switch (tipo) {

            case ADMIN:
                return "redirect:/admin/home";

            case PROFESSOR:
                return "redirect:/professor/home";

            case ALUNO:
                return "redirect:/aluno/home";

            case RESPONSAVEL_ACADEMICO:
                return "redirect:/responsavel-academico/home";

            case RESPONSAVEL_FINANCEIRO:
                return "redirect:/responsavel-financeiro/home";

            default:
                model.addAttribute("erro", "Tipo de usuário desconhecido!");
                return "login";
        }
    }
}
