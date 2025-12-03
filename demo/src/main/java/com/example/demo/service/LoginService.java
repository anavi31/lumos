package com.example.demo.service;

import com.example.demo.model.Login;
import com.example.demo.model.TipoUsuario;
import com.example.demo.model.Usuario;
import com.example.demo.repository.LoginRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private LoginRepository loginRepository;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public Login criarLogin(Usuario usuario, String loginUsuario, String senha, TipoUsuario tipoUsuario) {

        if (usuario == null) {
            throw new RuntimeException("Usuário não pode ser nulo ao criar login.");
        }

        if (loginUsuario == null || loginUsuario.isBlank()) {
            throw new RuntimeException("Login não pode ser vazio.");
        }

        if (senha == null || senha.isBlank()) {
            throw new RuntimeException("Senha não pode ser vazia.");
        }

        // Impede que o mesmo usuário tenha mais de 1 login
        if (usuario.getLogin() != null) {
            throw new RuntimeException("Este usuário já possui um login cadastrado.");
        }

        // Impede login duplicado
        if (loginRepository.existsByLogin(loginUsuario)) {
            throw new RuntimeException("Já existe um login cadastrado com este nome: " + loginUsuario);
        }

        // Define tipo padrão (por exemplo, USUARIO)
        if (tipoUsuario == null) {
            tipoUsuario = TipoUsuario.USUARIO;
        }

        Login login = new Login();
        login.setLogin(loginUsuario);
        login.setSenha(passwordEncoder.encode(senha));
        login.setTipoUsuario(tipoUsuario);
        login.setAtivo(true);
        login.setUsuario(usuario);

        // IMPORTANTE: vincula no objeto de usuário também
        usuario.setLogin(login);

        return loginRepository.save(login);
    }

    public boolean existeLogin(String login) {
        return loginRepository.existsByLogin(login);
    }

    public Login autenticar(String loginUsuario, String senha) {

        if (loginUsuario == null || senha == null) return null;

        Login login = loginRepository.findByLogin(loginUsuario);

        if (login == null || !login.getAtivo()) {
            return null;
        }

        if (passwordEncoder.matches(senha, login.getSenha())) {
            return login;
        }

        return null;
    }
}
