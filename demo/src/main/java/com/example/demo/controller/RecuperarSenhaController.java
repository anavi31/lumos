/*package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

@Controller
public class RecuperarSenhaController {

    @GetMapping("/recuperar-senha")
    public String mostrarPagina() {
        return "recuperar-senha";
    }

    @PostMapping("/recuperar-senha")
    public String processarCpf(@RequestParam("cpf") String cpf, Model model) {
        model.addAttribute("cpf", cpf);

        // Aqui você futuramente fará a lógica de verificar o CPF no banco,
        // gerar token, mandar e-mail, etc.

        return "senha-enviada";
    }
}
*/