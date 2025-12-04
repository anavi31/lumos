@Service
public class ResponsavelService {

    @Autowired
    private ResponsavelRepository responsavelRepository;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private LoginService loginService;

    // ===========================
    // MÉTODO COMPLETO (6 params)
    // ===========================
    public Responsavel criarResponsavel(
            String nome,
            String cpf,
            String telefone,
            String email,
            TipoResponsavel tipoResponsavel,
            TipoAcesso tipoAcesso
    ) {

        Usuario usuario = usuarioService.criarUsuarioBasico(
                nome,
                null,
                null,
                null,
                telefone,
                null,
                email
        );

        usuario = usuarioService.salvarUsuario(usuario);

        // Login automático (senha fixa por enquanto)
        loginService.criarLogin(
                usuario,
                email,
                "senha_padrao",
                TipoUsuario.RESPONSAVEL
        );

        Responsavel responsavel = new Responsavel();
        responsavel.setUsuario(usuario);
        responsavel.setCpf(cpf);
        responsavel.setTipoResponsavel(tipoResponsavel);
        responsavel.setTipoAcesso(tipoAcesso);

        return responsavelRepository.save(responsavel);
    }

    // ======================================================
    // MÉTODO SIMPLIFICADO — ESTE É O QUE O CONTROLLER USA
    // ======================================================
    public Responsavel criarResponsavel(
            String nome,
            String cpf,
            String telefone,
            String email
    ) {
        return criarResponsavel(
                nome,
                cpf,
                telefone,
                email,
                TipoResponsavel.OUTRO,     // padrão
                TipoAcesso.ACADEMICO       // padrão
        );
    }
}
