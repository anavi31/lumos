package com.example.demo.service;

import com.example.demo.model.Endereco;
import com.example.demo.repository.EnderecoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EnderecoService {

    @Autowired
    private EnderecoRepository enderecoRepository;

    public Endereco criarEndereco(String rua, String numero, String bairro, String cep, String complemento) {
        Endereco e = new Endereco();
        e.setRua(rua);
        e.setNumero(numero);
        e.setBairro(bairro);
        e.setCep(cep);
        e.setComplemento(complemento);
        return enderecoRepository.save(e);
    }
}
