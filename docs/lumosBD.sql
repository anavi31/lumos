CREATE DATABASE escola_db1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE escola_db1;

CREATE TABLE usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  sobrenome VARCHAR(80),
  data_nascimento DATE,
  sexo ENUM('M','F','OUTRO'),
  telefone VARCHAR(20),
  celular VARCHAR(20),
  email VARCHAR(120) UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE login (
  id_login INT AUTO_INCREMENT PRIMARY KEY,
  login VARCHAR(50) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  tipo_usuario ENUM('ADMIN','PROFESSOR','ALUNO','RESPONSAVEL') NOT NULL,
  id_usuario INT,
  ativo TINYINT(1) DEFAULT 1,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE responsavel (
  id_responsavel INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  cpf VARCHAR(14),
  tipo_responsavel ENUM('PAI','MAE','OUTRO') DEFAULT 'OUTRO',
  tipo_acesso ENUM('ACADEMICO','FINANCEIRO','AMBOS') NOT NULL DEFAULT 'ACADEMICO',
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE responsavel_aluno (
  id_responsavel_aluno INT AUTO_INCREMENT PRIMARY KEY,
  id_aluno INT NOT NULL,
  id_responsavel INT NOT NULL,
  papel ENUM('ACADEMICO','FINANCEIRO') NOT NULL DEFAULT 'ACADEMICO',
  FOREIGN KEY (id_aluno) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
  FOREIGN KEY (id_responsavel) REFERENCES responsavel(id_responsavel) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE aluno (
  id_aluno INT AUTO_INCREMENT PRIMARY KEY,
  matricula VARCHAR(20) UNIQUE,
  id_usuario INT NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE professor (
  id_professor INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  cpf VARCHAR(14),
  especialidade VARCHAR(80),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE turma (
  id_turma INT AUTO_INCREMENT PRIMARY KEY,
  serie ENUM('1','2','3') DEFAULT '1',
  turno ENUM('M','T','N','A'),
  ano_letivo YEAR,
  sala VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE disciplina (
  id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE turma_disciplina (
  id_turmaDisciplina INT AUTO_INCREMENT PRIMARY KEY,
  id_turma INT NOT NULL,
  id_disciplina INT NOT NULL,
  id_professor INT,
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma) ON DELETE CASCADE,
  FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina) ON DELETE CASCADE,
  FOREIGN KEY (id_professor) REFERENCES professor(id_professor) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE horario_aula (
  id_horarioAula INT AUTO_INCREMENT PRIMARY KEY,
  id_turmaDisciplina INT NOT NULL,
  dia_semana ENUM('SEG','TER','QUA','QUI','SEX','SAB','DOM'),
  hora_inicio TIME,
  hora_fim TIME,
  FOREIGN KEY (id_turmaDisciplina) REFERENCES turma_disciplina(id_turmaDisciplina) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE matricula (
  id_matricula INT AUTO_INCREMENT PRIMARY KEY,
  id_aluno INT NOT NULL,
  id_turma INT NOT NULL,
  ano_letivo YEAR,
  status ENUM('ATIVA','TRANCADA','CANCELADA','CONCLUIDA') DEFAULT 'ATIVA',
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE,
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE avaliacao (
  id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
  id_professor INT,
  id_disciplina INT,
  id_turma INT,
  tipo ENUM('PROVA','TRABALHO','ATIVIDADE','RECUPERACAO') NOT NULL,
  unidade ENUM('1','2','3') DEFAULT '1',
  peso DECIMAL(4,2) DEFAULT 1.0,
  data DATE,
  FOREIGN KEY (id_professor) REFERENCES professor(id_professor) ON DELETE SET NULL,
  FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina) ON DELETE SET NULL,
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE nota (
  id_nota INT AUTO_INCREMENT PRIMARY KEY,
  id_avaliacao INT NOT NULL,
  id_aluno INT NOT NULL,
  valor DECIMAL(5,2),
  FOREIGN KEY (id_avaliacao) REFERENCES avaliacao(id_avaliacao) ON DELETE CASCADE,
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE frequencia (
  id_frequencia INT AUTO_INCREMENT PRIMARY KEY,
  id_horarioAula INT NOT NULL,
  id_aluno INT NOT NULL,
  data DATE,
  presente TINYINT(1) DEFAULT 0,
  FOREIGN KEY (id_horarioAula) REFERENCES horario_aula(id_horarioAula) ON DELETE CASCADE,
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE mensalidade (
  id_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
  id_aluno INT NOT NULL,
  id_responsavel_financeiro INT DEFAULT NULL,
  mes TINYINT,
  ano YEAR,
  valor DECIMAL(10,2),
  valor_pago DECIMAL(10,2),
  data_pagamento DATE,
  vencimento DATE,
  status ENUM('PENDENTE','PAGO','ATRASADO') DEFAULT 'PENDENTE',
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE,
  FOREIGN KEY (id_responsavel_financeiro) REFERENCES responsavel(id_responsavel) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE postagem (
  id_postagem INT AUTO_INCREMENT PRIMARY KEY,
  titulo VARCHAR(150),
  descricao TEXT,
  data DATETIME,
  tipo ENUM('AVISO','NOTICIA','COMUNICADO') DEFAULT 'AVISO',
  id_autor INT,
  FOREIGN KEY (id_autor) REFERENCES usuario(id_usuario) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE postagem_target (
  id_postagem_target INT AUTO_INCREMENT PRIMARY KEY,
  id_postagem INT NOT NULL,
  id_turma INT,
  id_aluno INT,
  FOREIGN KEY (id_postagem) REFERENCES postagem(id_postagem) ON DELETE CASCADE,
  FOREIGN KEY (id_turma) REFERENCES turma(id_turma) ON DELETE CASCADE,
  FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ÍNDICES
CREATE INDEX idx_usuario_email ON usuario(email);
CREATE INDEX idx_matricula_aluno ON matricula(id_aluno);
CREATE INDEX idx_matricula_turma ON matricula(id_turma);
CREATE INDEX idx_prof_cpf ON professor(cpf);


INSERT INTO usuario (nome, sobrenome, data_nascimento, sexo, celular, email) VALUES
('Carlos', 'Souza', '1980-03-12', 'M', '11987654321', 'carlos.prof@escola.com'),
('Marina', 'Alves', '1985-09-23', 'F', '11933445566', 'marina.prof@escola.com'),
('João', 'Pereira', '2008-05-10', 'M', '11999887766', 'joao.aluno@escola.com'),
('Maria', 'Silva', '2009-02-18', 'F', '11988776655', 'maria.aluna@escola.com'),
('Paulo', 'Santos', '1978-06-10', 'M', '11966554433', 'paulo.resp@familia.com'),
('Ana', 'Santos', '1981-01-09', 'F', '11955443322', 'ana.resp@familia.com'),
('Cristina', 'Diretora', '1970-06-15', 'F', '11944332211', 'cristina.admin@escola.com');

INSERT INTO login (login, senha, tipo_usuario, id_usuario) VALUES
('carlos', '123', 'PROFESSOR', 1),
('marina', '123', 'PROFESSOR', 2),
('joao', '123', 'ALUNO', 3),
('maria', '123', 'ALUNO', 4),
('paulo', '123', 'RESPONSAVEL', 5),
('ana', '123', 'RESPONSAVEL', 6),
('admin', '123', 'ADMIN', 7);

INSERT INTO professor (id_usuario, cpf, especialidade) VALUES
(1, '111.111.111-11', 'Matemática'),
(2, '222.222.222-22', 'Português');

INSERT INTO aluno (matricula, id_usuario) VALUES
('2025-0001', 3),
('2025-0002', 4);

INSERT INTO responsavel (id_usuario, cpf, tipo_responsavel, tipo_acesso) VALUES
(5, '555.555.555-55', 'PAI', 'FINANCEIRO'),
(6, '666.666.666-66', 'MAE', 'ACADEMICO');

INSERT INTO responsavel_aluno (id_aluno, id_responsavel, papel) VALUES
(1, 1, 'FINANCEIRO'),
(1, 2, 'ACADEMICO'),
(2, 1, 'FINANCEIRO');

INSERT INTO turma (serie, turno, ano_letivo, sala) VALUES
('1','M',2025,'101'),
('2','T',2025,'203');

INSERT INTO disciplina (nome) VALUES
('Matemática'),
('Português'),
('História'),
('Ciências');

INSERT INTO turma_disciplina (id_turma, id_disciplina, id_professor) VALUES
(1,1,1),
(1,2,2),
(2,1,1),
(2,2,2);

INSERT INTO horario_aula (id_turmaDisciplina, dia_semana, hora_inicio, hora_fim) VALUES
(1,'SEG','07:00','07:50'),
(1,'QUA','07:00','07:50'),
(2,'TER','08:00','08:50'),
(2,'QUI','08:00','08:50');

INSERT INTO matricula (id_aluno, id_turma, ano_letivo) VALUES
(1,1,2025),
(2,1,2025);

INSERT INTO avaliacao (id_professor, id_disciplina, id_turma, tipo, unidade, peso, data) VALUES
(1,1,1,'PROVA','1',2.0,'2025-03-10'),
(2,2,1,'TRABALHO','1',1.0,'2025-03-15');

INSERT INTO nota (id_avaliacao, id_aluno, valor) VALUES
(1,1,8.5),
(1,2,7.0),
(2,1,9.0),
(2,2,8.0);

INSERT INTO frequencia (id_horarioAula, id_aluno, data, presente) VALUES
(1,1,'2025-03-01',1),
(1,2,'2025-03-01',0),
(2,1,'2025-03-03',1),
(2,2,'2025-03-03',1);

INSERT INTO mensalidade (id_aluno, id_responsavel_financeiro, mes, ano, valor, valor_pago, data_pagamento, vencimento, status) VALUES
(1,1,3,2025,500.00,500.00,'2025-03-05','2025-03-10','PAGO'),
(2,1,3,2025,500.00,0.00,NULL,'2025-03-10','PENDENTE');

INSERT INTO postagem (titulo, descricao, data, tipo, id_autor) VALUES
('Reunião de Pais','Reunião geral às 19h na sala 101.',NOW(),'AVISO',7),
('Feira de Ciências','Feira anual será na próxima sexta.',NOW(),'NOTICIA',7);

INSERT INTO postagem_target (id_postagem, id_turma) VALUES
(1,1),
(2,1),
(2,2);


SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'escola_db1'
  AND TABLE_NAME = 'responsavel_aluno'
  AND COLUMN_NAME = 'id_aluno';

ALTER TABLE responsavel_aluno
DROP FOREIGN KEY responsavel_aluno_ibfk_1;

ALTER TABLE responsavel_aluno
ADD CONSTRAINT fk_responsavel_aluno_aluno
FOREIGN KEY (id_aluno)
REFERENCES aluno(id_aluno)
ON DELETE CASCADE;

SHOW CREATE TABLE responsavel_aluno;