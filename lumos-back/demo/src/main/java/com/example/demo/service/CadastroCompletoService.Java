@Service
public class CadastroCompletoService {

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private EnderecoService enderecoService;

    @Autowired
    private AlunoService alunoService;

    @Autowired
    private LoginService loginService;

    public void cadastrarCompleto(CadastroCompletoDTO dto) {

        // 1) Criar usuário básico (AINDA NÃO SALVA)
        Usuario usuario = usuarioService.criarUsuarioBasico(
                dto.getNome(),
                dto.getEmail(),
                dto.getCpf(),
                dto.getTelefone()
        );

        // ❗ Garantir que SEMPRE será salvo ANTES de criar login
        usuario = usuarioService.salvarUsuario(usuario);

        // 2) Criar Endereço (opcional)
        if (dto.getEndereco() != null) {
            Endereco endereco = new Endereco();
            endereco.setCep(dto.getEndereco().getCep());
            endereco.setRua(dto.getEndereco().getRua());
            endereco.setNumero(dto.getEndereco().getNumero());
            endereco.setComplemento(dto.getEndereco().getComplemento());
            endereco.setBairro(dto.getEndereco().getBairro());
            endereco.setCidade(dto.getEndereco().getCidade());
            endereco.setEstado(dto.getEndereco().getEstado());
            endereco.setUsuario(usuario); // FK
            enderecoService.salvar(endereco);

            // associar ao usuário
            usuario.setEndereco(endereco);
            usuarioService.salvarUsuario(usuario);
        }

        // 3) Criar Aluno (opcional)
        if (dto.getAluno() != null) {
            Aluno aluno = new Aluno();
            aluno.setMatricula(dto.getAluno().getMatricula());
            aluno.setCurso(dto.getAluno().getCurso());
            aluno.setPeriodo(dto.getAluno().getPeriodo());
            aluno.setUsuario(usuario);
            alunoService.salvar(aluno);

            usuario.setAluno(aluno);
            usuarioService.salvarUsuario(usuario);
        }

        // 4) Criar Login (sempre depois do usuário salvo)
        loginService.criarLogin(
                usuario,
                dto.getLogin().getUsuarioLogin(),
                dto.getLogin().getSenha()
        );
    }
}
