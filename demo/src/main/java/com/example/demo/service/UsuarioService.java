package com.example.demo.service;

import com.example.demo.model.Sexo;
import com.example.demo.model.Usuario;
import com.example.demo.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    public Usuario criarUsuarioBasico(
            String nome,
            String sobrenome,
            java.time.LocalDate dataNascimento,
            String sexo,
            String telefone,
            String celular,
            String email
    ) {

        Usuario u = new Usuario();
        u.setNome(nome);
        u.setSobrenome(sobrenome);
        u.setDataNascimento(dataNascimento);

        if (sexo != null && !sexo.isBlank()) {
            String s = sexo.trim().toUpperCase();


            if (s.equals("MASCULINO")) s = "M";
            if (s.equals("FEMININO")) s = "F";

            if (s.equals("M") || s.equals("F") || s.equals("OUTRO")) {
                try {
                    u.setSexo(Sexo.valueOf(s));
                } catch (IllegalArgumentException e) {
                    throw new RuntimeException("Sexo inválido. Use: 'M', 'F' ou 'OUTRO'.");
                }
            } else {
                throw new RuntimeException("Sexo inválido. Use: 'M', 'F' ou 'OUTRO'.");
            }
        }

        u.setTelefone(telefone);
        u.setCelular(celular);
        u.setEmail(email);

        return u;
    }

    public Usuario salvarUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    public boolean emailExiste(String email) {
        return usuarioRepository.existsByEmail(email);
    }
}
