-- TRABALHO NOTAS DO FUTURO 12/05/2026 - UMC - ENGENHARIA DE SOFTWARE 

-- Criação, utilização e exclusão do Banco de Dados
CREATE DATABASE Notas_do_Futuro;
Use Notas_do_Futuro;

DROP DATABASE notas_do_futuro;

CREATE TABLE ADM(
ID_Adm SMALLINT AUTO_INCREMENT,
Nome VARCHAR (100),
Login_usuario_Adm VARCHAR (50) NOT NULL UNIQUE,
SENHA VARCHAR (255) NOT NULL,
CONSTRAINT pk_ID_Adm PRIMARY KEY (ID_Adm)
) AUTO_INCREMENT = 100;

CREATE TABLE Usuario_Padrao
(ID_Usuario SMALLINT AUTO_INCREMENT,
Email VARCHAR (100) NOT NULL UNIQUE,
SENHA VARCHAR (255) NOT NULL,
Nome VARCHAR (100),
CONSTRAINT pk_ID_Usuario PRIMARY KEY (ID_Usuario)
); 

CREATE TABLE Professor
(ID_Professor SMALLINT AUTO_INCREMENT,
Email VARCHAR (100) NOT NULL UNIQUE,
Nome VARCHAR (100),
Senha VARCHAR (255) NOT NULL,
CONSTRAINT pk_ID_Professor PRIMARY KEY (ID_Professor)
);

CREATE TABLE Regiao
(ID_Regiao SMALLINT AUTO_INCREMENT,
Nome_Regiao VARCHAR (50) UNIQUE,
CONSTRAINT pk_ID_Regiao PRIMARY KEY (ID_Regiao)
); 

CREATE TABLE Quiz
(ID_Quiz SMALLINT AUTO_INCREMENT,
Nome_Quiz VARCHAR (50) UNIQUE,
CONSTRAINT pk_ID_Quiz PRIMARY KEY (ID_Quiz)
); 

CREATE TABLE Estado
(ID_Estado SMALLINT AUTO_INCREMENT,
Nome_Estado VARCHAR (50) UNIQUE,
Sigla CHAR(2) UNIQUE NOT NULL,
ID_Regiao SMALLINT NOT NULL,
CONSTRAINT fk_ID_Regiao FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao) ON DELETE CASCADE,
CONSTRAINT pk_ID_Estado PRIMARY KEY (ID_Estado)
); 

CREATE TABLE Perfil_Usuario
(Id_Perfil SMALLINT AUTO_INCREMENT,
Nome VARCHAR (100),
Foto VARCHAR(255),
ID_Usuario SMALLINT NOT NULL,
CONSTRAINT fk_ID_Usuario FOREIGN KEY (ID_Usuario)
REFERENCES Usuario_Padrao (ID_Usuario),
CONSTRAINT pk_ID_Perfil PRIMARY KEY (ID_Perfil)
);

CREATE TABLE Info_Regiao
(ID_Info_Regiao SMALLINT AUTO_INCREMENT,
Info_Regiao TEXT NOT NULL,
ID_Regiao SMALLINT NOT NULL,
CONSTRAINT fk_ID_Info_Regiao FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao),
CONSTRAINT pk_ID_Info_Regiao PRIMARY KEY (ID_Info_Regiao)
);

CREATE TABLE Notas
(ID_Nota SMALLINT AUTO_INCREMENT,
Nota DECIMAL(4,2) NOT NULL,
ID_Quiz SMALLINT NOT NULL,
ID_Usuario SMALLINT NOT NULL,
ID_Professor SMALLINT,
CONSTRAINT pk_ID_Nota PRIMARY KEY (ID_Nota),
CONSTRAINT fk_Nota_Usuario FOREIGN KEY (Id_Usuario)
REFERENCES Usuario_Padrao (ID_Usuario),
CONSTRAINT fk_Quiz FOREIGN KEY (ID_Quiz)
REFERENCES Quiz (ID_Quiz),
CONSTRAINT fk_Notas_Professor FOREIGN KEY (ID_Professor)
REFERENCES Professor (ID_Professor)
);

CREATE TABLE Pergunta
(ID_Pergunta SMALLINT AUTO_INCREMENT,
Enunciado TEXT NOT NULL,
ID_Quiz SMALLINT NOT NULL,
ID_Estado SMALLINT NOT NULL,	
CONSTRAINT pk_ID_Pergunta PRIMARY KEY (ID_Pergunta),
CONSTRAINT fk_Pergunta_Quiz FOREIGN KEY (ID_Quiz)
REFERENCES Quiz (ID_Quiz),
CONSTRAINT fk_Pergunta_Estado FOREIGN KEY (ID_Estado) 
REFERENCES Estado(ID_Estado) ON DELETE CASCADE
);

CREATE TABLE MiniJogo
(ID_MiniJogo SMALLINT AUTO_INCREMENT,
Nome_Jogo VARCHAR (100) UNIQUE NOT NULL,
Tipo_Jogo VARCHAR (30) NOT NULL,
Descricao TEXT NOT NULL,
ID_Regiao SMALLINT NOT NULL,
CONSTRAINT pk_ID_MiniJogo PRIMARY KEY (ID_MiniJogo),
CONSTRAINT fk_MiniJogo_Regiao FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao)
);

CREATE TABLE Alternativa
(ID_Alternativa SMALLINT AUTO_INCREMENT,
Descricao TEXT NOT NULL,
Alternativa_Correta BOOLEAN DEFAULT FALSE,
ID_Pergunta SMALLINT NOT NULL,
CONSTRAINT pk_ID_Alternativa PRIMARY KEY (ID_Alternativa),
CONSTRAINT fk_ID_Pergunta FOREIGN KEY (ID_Pergunta)
REFERENCES Pergunta (ID_Pergunta)
);

CREATE TABLE Gerenciar (
ID_ADM SMALLINT,
ID_Usuario SMALLINT,
Data_Gerenciamento DATETIME DEFAULT CURRENT_TIMESTAMP, 
PRIMARY KEY (ID_ADM, ID_Usuario),
CONSTRAINT fk_gerenciar_adm FOREIGN KEY (ID_ADM) 
REFERENCES ADM(ID_ADM) ON DELETE CASCADE,
CONSTRAINT fk_gerenciar_usuario FOREIGN KEY (ID_Usuario) 
REFERENCES Usuario_Padrao(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Consultar (
ID_Usuario SMALLINT,
ID_nota SMALLINT,
Data_da_Consulta DATETIME DEFAULT CURRENT_TIMESTAMP, 
PRIMARY KEY (ID_Usuario, ID_nota), 
CONSTRAINT fk_consultar_usuario FOREIGN KEY (ID_Usuario) 
REFERENCES Usuario_Padrao(ID_Usuario) ON DELETE CASCADE,
CONSTRAINT fk_consultar_nota FOREIGN KEY (ID_nota) 
REFERENCES Notas(ID_nota) ON DELETE CASCADE
);

	CREATE TABLE Modificar_Nota (
	ID_Professor SMALLINT,
	ID_nota SMALLINT,
	Ultima_Alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ID_Professor, ID_nota),
	CONSTRAINT fk_modificar_professor FOREIGN KEY (ID_Professor) 
	REFERENCES Professor(ID_Professor) ON DELETE CASCADE,
	CONSTRAINT fk_modificar_nota FOREIGN KEY (ID_nota) 
	REFERENCES Notas(ID_nota) ON DELETE CASCADE
	);

CREATE TABLE Log_Modificar_Nota (
    ID_Log INT AUTO_INCREMENT PRIMARY KEY,
    ID_Professor SMALLINT,
    ID_nota SMALLINT,
    Data_Alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Acao VARCHAR(50) DEFAULT 'ALTERACAO',
    CONSTRAINT fk_log_professor FOREIGN KEY (ID_Professor) 
	REFERENCES Professor(ID_Professor) ON DELETE CASCADE,
    CONSTRAINT fk_log_nota FOREIGN KEY (ID_nota) 
	REFERENCES Notas(ID_nota) ON DELETE CASCADE
);

CREATE TABLE Interacao
(
ID_Usuario SMALLINT,
ID_Regiao SMALLINT,
Data_Interacao DATETIME DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (ID_Usuario, ID_Regiao),
CONSTRAINT fk_ID_Usuario_Int FOREIGN KEY (ID_Usuario)
REFERENCES Usuario_Padrao (ID_Usuario) ON DELETE CASCADE,
CONSTRAINT fk_ID_Regiao_Int FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao) ON DELETE CASCADE
);

-- Criação, alteração e exclusão de tabelas
ALTER TABLE ADM	
ADD Bio_Professor TEXT;
ALTER TABLE ADM
MODIFY Bio_Professor VARCHAR (255);
ALTER TABLE ADM
DROP COLUMN Bio_Professor;

CREATE TABLE Coordenacao
(Id_Coordenacao SMALLINT AUTO_INCREMENT,
Nome_Coordenador VARCHAR (100),
CONSTRAINT pk_ID_Coordenacao PRIMARY KEY (ID_Coordenacao)
);
DROP TABLE Coordenacao;
ALTER TABLE Adm
ADD RGM SMALLINT NOT NULL;
ALTER TABLE ADM
MODIFY RGM CHAR(11) NOT NULL;
-- Inserção, atualização e exclusão de Dados
INSERT INTO Adm (Nome, RGM, Login_usuario_Adm, Senha)
VALUES ('Jessica Claro', 11252100357, 'ADM_Jessica_Claro', SHA2('minhasenha123', 512)),
('Paloma Bichler', 11261405986, 'ADM_Paloma_Bichler', SHA2('minhasenha456', 224)),
('Beatriz Alves', 11252102196, 'ADM_Beatriz_Alves', SHA2('minhasenha789', 224)),
('Érika Rocha', 11252101010, 'ADM_Érika_Rocha', SHA2('minhasenha1011112', 224)),
('Jessé Lucatelli', 11252101010, 'ADM_Jessé_Lucatelli', SHA2('minhasenha121314', 224));

-- Inserção de usuários
INSERT INTO Usuario_Padrao (Email, SENHA, Nome) VALUES
('ana.silva@gmail.com', SHA2('Senha@123', 256), 'Ana Silva'),
('bruno.costa@hotmail.com', SHA2('Bruno#2026', 256), 'Bruno Costa'),
('carla.mendes@yahoo.com', SHA2('Carla456!', 256), 'Carla Mendes'),
('diego.alves@gmail.com', SHA2('Diego789@', 256), 'Diego Alves'),
('eduarda.rocha@outlook.com', SHA2('Edu123#', 256), 'Eduarda Rocha'),
('felipe.lima@gmail.com', SHA2('Felipe@321', 256), 'Felipe Lima'),
('gabriela.souza@yahoo.com', SHA2('Gabi#654', 256), 'Gabriela Souza'),
('henrique.pereira@hotmail.com', SHA2('Henrique@1', 256), 'Henrique Pereira'),
('isabela.castro@gmail.com', SHA2('Isa789#', 256), 'Isabela Castro'),
('joao.vieira@outlook.com', SHA2('Joao@2025', 256), 'João Vieira'),
('karina.martins@gmail.com', SHA2('Karina#777', 256), 'Karina Martins'),
('lucas.ribeiro@yahoo.com', SHA2('Lucas123!', 256), 'Lucas Ribeiro'),
('mariana.almeida@gmail.com', SHA2('Mari@456', 256), 'Mariana Almeida'),
('nicolas.barros@hotmail.com', SHA2('Nico#2024', 256), 'Nicolas Barros'),
('olivia.gomes@gmail.com', SHA2('Olivia@999', 256), 'Olivia Gomes'),
('paulo.teixeira@yahoo.com', SHA2('Paulo#111', 256), 'Paulo Teixeira'),
('quiteria.santos@outlook.com', SHA2('Quiteria@2', 256), 'Quitéria Santos'),
('rafael.cardoso@gmail.com', SHA2('Rafa321#', 256), 'Rafael Cardoso'),
('sabrina.ferreira@yahoo.com', SHA2('Sabri@555', 256), 'Sabrina Ferreira'),
('thiago.moraes@hotmail.com', SHA2('Thiago#88', 256), 'Thiago Moraes'),
('ursula.nunes@gmail.com', SHA2('Ursula@2026', 256), 'Úrsula Nunes'),
('vinicius.oliveira@yahoo.com', SHA2('Vini#123', 256), 'Vinícius Oliveira'),
('wendy.araujo@gmail.com', SHA2('Wendy@789', 256), 'Wendy Araújo'),
('xavier.campos@hotmail.com', SHA2('Xavier#01', 256), 'Xavier Campos'),
('yasmin.freitas@gmail.com', SHA2('Yasmin@456', 256), 'Yasmin Freitas'),
('zeca.batista@yahoo.com', SHA2('Zeca#999', 256), 'Zeca Batista'),
('aline.melo@gmail.com', SHA2('Aline@321', 256), 'Aline Melo'),
('bianca.dias@hotmail.com', SHA2('Bianca#2025', 256), 'Bianca Dias'),
('caio.torres@yahoo.com', SHA2('Caio@741', 256), 'Caio Torres'),
('daniela.ramos@gmail.com', SHA2('Dani#852', 256), 'Daniela Ramos'),
('enzo.pinto@outlook.com', SHA2('Enzo@159', 256), 'Enzo Pinto'),
('fabiana.cunha@gmail.com', SHA2('Fabi#753', 256), 'Fabiana Cunha'),
('gustavo.leal@yahoo.com', SHA2('Gusta@951', 256), 'Gustavo Leal'),
('helena.moreira@hotmail.com', SHA2('Helena#147', 256), 'Helena Moreira'),
('igor.machado@gmail.com', SHA2('Igor@258', 256), 'Igor Machado'),
('juliana.reis@yahoo.com', SHA2('JuReis#369', 256), 'Juliana Reis'),
('kevin.andrade@hotmail.com', SHA2('Kevin@753', 256), 'Kevin Andrade'),
('larissa.pires@gmail.com', SHA2('Lari#852', 256), 'Larissa Pires'),
('matheus.fonseca@yahoo.com', SHA2('Math@951', 256), 'Matheus Fonseca'),
('natalia.borges@gmail.com', SHA2('Naty#357', 256), 'Natália Borges');

-- Inserção de professores
INSERT INTO Professor (Email, Nome, Senha) VALUES
('carlos.almeida@universidade.com', 'Carlos Almeida', SHA2('Carlos@123', 256)),
('fernanda.lopes@universidade.com', 'Fernanda Lopes', SHA2('Fernanda#2026', 256)),
('ricardo.mendes@universidade.com', 'Ricardo Mendes', SHA2('Ricardo@456', 256)),
('patricia.souza@universidade.com', 'Patrícia Souza', SHA2('Patricia#789', 256)),
('marcos.pereira@universidade.com', 'Marcos Pereira', SHA2('Marcos@321', 256)),
('juliana.castro@universidade.com', 'Juliana Castro', SHA2('Juliana#654', 256)),
('andre.rocha@universidade.com', 'André Rocha', SHA2('Andre@987', 256)),
('camila.teixeira@universidade.com', 'Camila Teixeira', SHA2('Camila#852', 256)),
('roberto.lima@universidade.com', 'Roberto Lima', SHA2('Roberto@159', 256)),
('beatriz.ramos@universidade.com', 'Beatriz Ramos', SHA2('Beatriz#753', 256)),
('leonardo.cardoso@universidade.com', 'Leonardo Cardoso', SHA2('Leo@951', 256)),
('simone.barros@universidade.com', 'Simone Barros', SHA2('Simone#147', 256)),
('fabio.moraes@universidade.com', 'Fábio Moraes', SHA2('Fabio@258', 256)),
('renata.gomes@universidade.com', 'Renata Gomes', SHA2('Renata#369', 256)),
('eduardo.freitas@universidade.com', 'Eduardo Freitas', SHA2('Eduardo@741', 256)),
('aline.nunes@universidade.com', 'Aline Nunes', SHA2('Aline#852', 256)),
('gustavo.oliveira@universidade.com', 'Gustavo Oliveira', SHA2('Gustavo@963', 256)),
('tatiane.cunha@universidade.com', 'Tatiane Cunha', SHA2('Tatiane#159', 256)),
('henrique.dias@universidade.com', 'Henrique Dias', SHA2('Henrique@357', 256)),
('priscila.reis@universidade.com', 'Priscila Reis', SHA2('Priscila#951', 256)),
('rafaela.pinto@universidade.com', 'Rafaela Pinto', SHA2('Rafaela@111', 256)),
('thiago.machado@universidade.com', 'Thiago Machado', SHA2('Thiago#222', 256)),
('luciana.fonseca@universidade.com', 'Luciana Fonseca', SHA2('Luciana@333', 256)),
('vinicius.andrade@universidade.com', 'Vinícius Andrade', SHA2('Vinicius#444', 256)),
('cristiane.alves@universidade.com', 'Cristiane Alves', SHA2('Cristiane@555', 256)),
('paulo.costa@universidade.com', 'Paulo Costa', SHA2('Paulo#666', 256)),
('debora.santos@universidade.com', 'Débora Santos', SHA2('Debora@777', 256)),
('mateus.borges@universidade.com', 'Mateus Borges', SHA2('Mateus#888', 256)),
('daniela.campos@universidade.com', 'Daniela Campos', SHA2('Daniela@999', 256)),
('sergio.leal@universidade.com', 'Sérgio Leal', SHA2('Sergio#101', 256)),
('vanessa.vieira@universidade.com', 'Vanessa Vieira', SHA2('Vanessa@202', 256)),
('alexandre.melo@universidade.com', 'Alexandre Melo', SHA2('Alexandre#303', 256)),
('claudia.martins@universidade.com', 'Cláudia Martins', SHA2('Claudia@404', 256)),
('rodrigo.torres@universidade.com', 'Rodrigo Torres', SHA2('Rodrigo#505', 256)),
('isabela.ribeiro@universidade.com', 'Isabela Ribeiro', SHA2('Isabela@606', 256)),
('felipe.araujo@universidade.com', 'Felipe Araújo', SHA2('Felipe#707', 256)),
('monica.pereira@universidade.com', 'Mônica Pereira', SHA2('Monica@808', 256)),
('caio.mendes@universidade.com', 'Caio Mendes', SHA2('Caio#909', 256)),
('elaine.moreira@universidade.com', 'Elaine Moreira', SHA2('Elaine@010', 256)),
('wesley.lopes@universidade.com', 'Wesley Lopes', SHA2('Wesley#111', 256));

-- Inserção de regiões
INSERT INTO Regiao (Nome_Regiao) VALUES
('Norte'),
('Nordeste'),
('Centro-Oeste'),
('Sudeste'),
('Sul');

-- Inserir quizes dos estados 
INSERT INTO Quiz (Nome_Quiz) VALUES
('Quiz Acre'),
('Quiz Alagoas'),
('Quiz Amapá'),
('Quiz Amazonas'),
('Quiz Bahia'),
('Quiz Ceará'),
('Quiz Distrito Federal'),
('Quiz Espírito Santo'),
('Quiz Goiás'),
('Quiz Maranhão'),
('Quiz Mato Grosso'),
('Quiz Mato Grosso do Sul'),
('Quiz Minas Gerais'),
('Quiz Pará'),
('Quiz Paraíba'),
('Quiz Paraná'),
('Quiz Pernambuco'),
('Quiz Piauí'),
('Quiz Rio de Janeiro'),
('Quiz Rio Grande do Norte'),
('Quiz Rio Grande do Sul'),
('Quiz Rondônia'),
('Quiz Roraima'),
('Quiz Santa Catarina'),
('Quiz São Paulo'),
('Quiz Sergipe'),
('Quiz Tocantins');

-- Inserir Estados
INSERT INTO Estado (Nome_Estado, Sigla, ID_Regiao) VALUES
('Acre', 'AC', 1),
('Alagoas', 'AL', 2),
('Amapá', 'AP', 1),
('Amazonas', 'AM', 1),
('Bahia', 'BA', 2),
('Ceará', 'CE', 2),
('Distrito Federal', 'DF', 3),
('Espírito Santo', 'ES', 4),
('Goiás', 'GO', 3),
('Maranhão', 'MA', 2),
('Mato Grosso', 'MT', 3),
('Mato Grosso do Sul', 'MS', 3),
('Minas Gerais', 'MG', 4),
('Pará', 'PA', 1),
('Paraíba', 'PB', 2),
('Paraná', 'PR', 5),
('Pernambuco', 'PE', 2),
('Piauí', 'PI', 2),
('Rio de Janeiro', 'RJ', 4),
('Rio Grande do Norte', 'RN', 2),
('Rio Grande do Sul', 'RS', 5),
('Rondônia', 'RO', 1),
('Roraima', 'RR', 1),
('Santa Catarina', 'SC', 5),
('São Paulo', 'SP', 4),
('Sergipe', 'SE', 2),
('Tocantins', 'TO', 1);

-- Inserir Perfil do usuário
INSERT INTO Perfil_Usuario (Nome, Foto, ID_Usuario) VALUES
('Ana Silva', 'https://notasdofuturo.com/imagens/foto_ana.jpg', 1),
('Bruno Costa', 'https://notasdofuturo.com/imagens/foto_bruno.jpg', 2),
('Carla Mendes', 'https://notasdofuturo.com/imagens/foto_carla.jpg', 3),
('Diego Alves', 'https://notasdofuturo.com/imagens/foto_diego.jpg', 4),
('Eduarda Rocha', 'https://notasdofuturo.com/imagens/foto_eduarda.jpg', 5),
('Felipe Lima', 'https://notasdofuturo.com/imagens/foto_felipe.jpg', 6),
('Gabriela Souza', 'https://notasdofuturo.com/imagens/foto_gabriela.jpg', 7),
('Henrique Pereira', 'https://notasdofuturo.com/imagens/foto_henrique.jpg', 8),
('Isabela Castro', 'https://notasdofuturo.com/imagens/foto_isabela.jpg', 9),
('João Vieira', 'https://notasdofuturo.com/imagens/foto_joao.jpg', 10),
('Karina Martins', 'https://notasdofuturo.com/imagens/foto_karina.jpg', 11),
('Lucas Ribeiro', 'https://notasdofuturo.com/imagens/foto_lucas.jpg', 12),
('Mariana Almeida', 'https://notasdofuturo.com/imagens/foto_mariana.jpg', 13),
('Nicolas Barros', 'https://notasdofuturo.com/imagens/foto_nicolas.jpg', 14),
('Olivia Gomes', 'https://notasdofuturo.com/imagens/foto_olivia.jpg', 15),
('Paulo Teixeira', 'https://notasdofuturo.com/imagens/foto_paulo.jpg', 16),
('Quitéria Santos', 'https://notasdofuturo.com/imagens/foto_quiteria.jpg', 17),
('Rafael Cardoso', 'https://notasdofuturo.com/imagens/foto_rafael.jpg', 18),
('Sabrina Ferreira', 'https://notasdofuturo.com/imagens/foto_sabrina.jpg', 19),
('Thiago Moraes', 'https://notasdofuturo.com/imagens/foto_thiago.jpg', 20),
('Úrsula Nunes', 'https://notasdofuturo.com/imagens/foto_ursula.jpg', 21),
('Vinícius Oliveira', 'https://notasdofuturo.com/imagens/foto_vinicius.jpg', 22),
('Wendy Araújo', 'https://notasdofuturo.com/imagens/foto_wendy.jpg', 23),
('Xavier Campos', 'https://notasdofuturo.com/imagens/foto_xavier.jpg', 24),
('Yasmin Freitas', 'https://notasdofuturo.com/imagens/foto_yasmin.jpg', 25),
('Zeca Batista', 'https://notasdofuturo.com/imagens/foto_zeca.jpg', 26),
('Aline Melo', 'https://notasdofuturo.com/imagens/foto_aline.jpg', 27),
('Bianca Dias', 'https://notasdofuturo.com/imagens/foto_bianca.jpg', 28),
('Caio Torres', 'https://notasdofuturo.com/imagens/foto_caio.jpg', 29),
('Daniela Ramos', 'https://notasdofuturo.com/imagens/foto_daniela.jpg', 30),
('Enzo Pinto', 'https://notasdofuturo.com/imagens/foto_enzo.jpg', 31),
('Fabiana Cunha', 'https://notasdofuturo.com/imagens/foto_fabiana.jpg', 32),
('Gustavo Leal', 'https://notasdofuturo.com/imagens/foto_gustavo.jpg', 33),
('Helena Moreira', 'https://notasdofuturo.com/imagens/foto_helena.jpg', 34),
('Igor Machado', 'https://notasdofuturo.com/imagens/foto_igor.jpg', 35),
('Juliana Reis', 'https://notasdofuturo.com/imagens/foto_juliana.jpg', 36),
('Kevin Andrade', 'https://notasdofuturo.com/imagens/foto_kevin.jpg', 37),
('Larissa Pires', 'https://notasdofuturo.com/imagens/foto_larissa.jpg', 38),
('Matheus Fonseca', 'https://notasdofuturo.com/imagens/foto_matheus.jpg', 39),
('Natália Borges', 'https://notasdofuturo.com/imagens/foto_natalia.jpg', 40);

-- Inserir Info_Regiões
INSERT INTO Info_Regiao (Info_Regiao, ID_Regiao) VALUES
('A Região Norte é a maior do Brasil e abriga a impressionante Floresta Amazônica, considerada a maior floresta tropical do planeta.
Seus rios gigantescos, como o Amazonas, influenciam o clima mundial e escondem espécies que ainda nem foram totalmente descobertas.
Explorar a Região Norte é mergulhar em uma mistura fascinante de natureza extrema, culturas indígenas e riquezas naturais únicas.', 1),

('A Região Nordeste encanta pela força de sua cultura, pelas músicas marcantes e pelas tradições que atravessam gerações.
Além das praias paradisíacas e da culinária famosa, o Nordeste possui histórias de resistência, festas populares gigantescas e um povo conhecido pela hospitalidade.
Cada estado nordestino revela costumes, sotaques e paisagens que despertam curiosidade e admiração.', 2),

('A Região Centro-Oeste é conhecida por suas enormes áreas naturais e pelo papel essencial na produção agrícola brasileira.
O Pantanal, uma das maiores áreas alagadas do mundo, abriga animais impressionantes e cenários de tirar o fôlego.
Além disso, Brasília chama atenção por sua arquitetura moderna e importância política para todo o país.', 3),

('A Região Sudeste é o coração econômico do Brasil e reúne algumas das cidades mais influentes da América Latina.
Entre arranha-céus, centros tecnológicos, praias famosas e patrimônios históricos, a região mistura inovação, cultura e oportunidades.
É no Sudeste que tradição e modernidade convivem lado a lado, despertando interesse em diferentes áreas do conhecimento.', 4),

('A Região Sul chama atenção pelo clima mais frio, pelas paisagens verdes e pelas fortes influências europeias presentes na arquitetura e na culinária.
A região possui cidades organizadas, festas tradicionais e um turismo que vai desde serras até vinícolas famosas.
Conhecer o Sul é descobrir costumes únicos e uma diversidade cultural que diferencia a região do restante do país.', 5),

('A Amazônia, localizada principalmente na Região Norte, exerce influência direta no equilíbrio ambiental do planeta.
A floresta produz umidade, abriga milhões de espécies e desperta interesse científico no mundo inteiro.
Muitos pesquisadores acreditam que ainda existem segredos naturais e medicinais escondidos em suas matas.', 1),

('O Nordeste brasileiro vai muito além do turismo de praia e guarda riquezas históricas fundamentais para entender o Brasil.
Suas cidades históricas preservam construções coloniais, tradições religiosas e manifestações culturais extremamente importantes.
A região desperta curiosidade por unir beleza natural, história e identidade cultural forte.', 2),

('O Centro-Oeste possui paisagens naturais que impressionam pela grandiosidade e diversidade.
O encontro entre Cerrado, Pantanal e áreas agrícolas cria uma região estratégica para a economia e para o meio ambiente.
Além disso, o turismo ecológico atrai pessoas interessadas em aventura, natureza e observação da vida selvagem.', 3),

('A Região Sudeste concentra universidades renomadas, centros financeiros e importantes polos industriais do Brasil.
Ao mesmo tempo, preserva patrimônios históricos, museus, manifestações artísticas e eventos culturais conhecidos internacionalmente.
A região desperta interesse justamente por combinar desenvolvimento econômico com intensa diversidade cultural.', 4),

('A Região Sul é conhecida por suas tradições, pela gastronomia diferenciada e pelas paisagens naturais que mudam bastante durante o ano.
As temperaturas mais baixas favorecem experiências incomuns para muitos brasileiros, incluindo geadas e até neve em algumas cidades.
Entre montanhas, festas típicas e influência europeia, o Sul desperta curiosidade em quem busca cultura e turismo.', 5);

-- Inserir Notas
INSERT INTO Notas (Nota, ID_Quiz, ID_Usuario, ID_Professor) VALUES
(8.50, 1, 1, 1),
(7.25, 2, 2, 2),
(9.00, 3, 3, 3),
(6.75, 4, 4, 4),
(8.90, 5, 5, 5),
(7.80, 6, 6, 6),
(9.50, 7, 7, 7),
(5.60, 8, 8, 8),
(8.10, 9, 9, 9),
(7.95, 10, 10, 10),

(6.40, 11, 11, 11),
(9.20, 12, 12, 12),
(8.75, 13, 13, 13),
(7.10, 14, 14, 14),
(9.85, 15, 15, 15),
(6.95, 16, 16, 16),
(8.30, 17, 17, 17),
(7.45, 18, 18, 18),
(9.10, 19, 19, 19),
(5.90, 20, 20, 20),

(8.60, 21, 21, 21),
(7.70, 22, 22, 22),
(9.40, 23, 23, 23),
(6.80, 24, 24, 24),
(8.95, 25, 25, 25),
(7.35, 26, 26, 26),
(9.75, 27, 27, 27),
(6.20, 1, 28, 28),
(8.15, 2, 29, 29),
(7.55, 3, 30, 30),

(9.30, 4, 31, 31),
(5.75, 5, 32, 32),
(8.45, 6, 33, 33),
(7.90, 7, 34, 34),
(9.60, 8, 35, 35),
(6.50, 9, 36, 36),
(8.70, 10, 37, 37),
(7.05, 11, 38, 38),
(9.15, 12, 39, 39),
(6.85, 13, 40, 40);

-- Inserir perguntas
INSERT INTO Pergunta (Enunciado, ID_Quiz, ID_Estado) VALUES
('Qual é a capital do Acre?', 1, 1),
('Qual é a capital de Alagoas?', 2, 2),
('Qual estado brasileiro é cortado pela Linha do Equador e possui o Marco Zero?', 3, 3),
('Qual é o nome da maior floresta tropical do mundo presente no Amazonas?', 4, 4),
('Qual cidade da Bahia foi a primeira capital do Brasil?', 5, 5),
('Qual é a capital do Ceará?', 6, 6),
('Qual cidade planejada está localizada no Distrito Federal?', 7, 7),
('Qual é a capital do Espírito Santo?', 8, 8),
('Qual é a capital de Goiás?', 9, 9),
('Qual parque nacional famoso pelas dunas e lagoas está localizado no Maranhão?', 10, 10),
('Qual importante bioma está presente no Mato Grosso?', 11, 11),
('Qual bioma atrai turistas para o Mato Grosso do Sul?', 12, 12),
('Qual é a capital de Minas Gerais?', 13, 13),
('Qual é a capital do Pará?', 14, 14),
('Em qual capital da Paraíba o sol nasce primeiro nas Américas?', 15, 15),
('Qual é o nome da famosa usina hidrelétrica localizada no Paraná?', 16, 16),
('Qual é a capital de Pernambuco?', 17, 17),
('Qual parque arqueológico famoso está localizado no Piauí?', 18, 18),
('Qual monumento famoso está localizado no Rio de Janeiro?', 19, 19),
('Qual é a capital do Rio Grande do Norte?', 20, 20),
('Qual é a capital do Rio Grande do Sul?', 21, 21),
('Qual é a capital de Rondônia?', 22, 22),
('Qual é a capital de Roraima?', 23, 23),
('Qual é a capital de Santa Catarina?', 24, 24),
('Qual é a capital de São Paulo?', 25, 25),
('Qual é a capital de Sergipe?', 26, 26),
('Qual cidade planejada é a capital do Tocantins?', 27, 27);

INSERT INTO MiniJogo (Nome_Jogo, Tipo_Jogo, Descricao, ID_Regiao) VALUES
('Batidas da Amazônia', 'Musical',
'Combine sons da floresta, acompanhe ritmos indígenas e desbloqueie instrumentos tradicionais escondidos no coração da Amazônia.', 1),

('Forró Turbo', 'Musical',
'Entre em batalhas de dança eletrizantes no sertão nordestino e prove que seus reflexos conseguem acompanhar o ritmo acelerado da sanfona.', 2),

('Pantanal Selvagem', 'Aventura',
'Explore o Pantanal, fotografe animais raros e sobreviva aos desafios naturais enquanto descobre curiosidades da Região Centro-Oeste.', 3),

('Corrida Maluca Paulista', 'Corrida',
'Desvie do trânsito caótico, enfrente pistas urbanas insanas e descubra quem domina as ruas mais aceleradas do Sudeste.', 4),

('Lobisomem da Serra', 'Terror',
'Investigue lendas misteriosas em florestas cobertas por neblina e sobreviva às criaturas escondidas nas montanhas do Sul do Brasil.', 5);

INSERT INTO Alternativa (Descricao, Alternativa_Correta, ID_Pergunta) VALUES
-- Pergunta 1
('Rio Branco', TRUE, 1),
('Manaus', FALSE, 1),
('Belém', FALSE, 1),
('Porto Velho', FALSE, 1),

-- Pergunta 2
('Maceió', TRUE, 2),
('Recife', FALSE, 2),
('Natal', FALSE, 2),
('Aracaju', FALSE, 2),

-- Pergunta 3
('Amapá', TRUE, 3),
('Pará', FALSE, 3),
('Amazonas', FALSE, 3),
('Roraima', FALSE, 3),

-- Pergunta 4
('Floresta Amazônica', TRUE, 4),
('Mata Atlântica', FALSE, 4),
('Caatinga', FALSE, 4),
('Pantanal', FALSE, 4),

-- Pergunta 5
('Salvador', TRUE, 5),
('Porto Seguro', FALSE, 5),
('Feira de Santana', FALSE, 5),
('Ilhéus', FALSE, 5),

-- Pergunta 6
('Fortaleza', TRUE, 6),
('Sobral', FALSE, 6),
('Juazeiro do Norte', FALSE, 6),
('Caucaia', FALSE, 6),

-- Pergunta 7
('Brasília', TRUE, 7),
('Goiânia', FALSE, 7),
('Palmas', FALSE, 7),
('Cuiabá', FALSE, 7),

-- Pergunta 8
('Vitória', TRUE, 8),
('Vila Velha', FALSE, 8),
('Serra', FALSE, 8),
('Cariacica', FALSE, 8),

-- Pergunta 9
('Goiânia', TRUE, 9),
('Anápolis', FALSE, 9),
('Rio Verde', FALSE, 9),
('Catalão', FALSE, 9),

-- Pergunta 10
('Lençóis Maranhenses', TRUE, 10),
('Chapada Diamantina', FALSE, 10),
('Jalapão', FALSE, 10),
('Serra do Cipó', FALSE, 10),

-- Pergunta 11
('Cerrado', TRUE, 11),
('Pampa', FALSE, 11),
('Caatinga', FALSE, 11),
('Mata Atlântica', FALSE, 11),

-- Pergunta 12
('Pantanal', TRUE, 12),
('Amazônia', FALSE, 12),
('Caatinga', FALSE, 12),
('Pampa', FALSE, 12),

-- Pergunta 13
('Belo Horizonte', TRUE, 13),
('Uberlândia', FALSE, 13),
('Ouro Preto', FALSE, 13),
('Montes Claros', FALSE, 13),

-- Pergunta 14
('Belém', TRUE, 14),
('Santarém', FALSE, 14),
('Marabá', FALSE, 14),
('Altamira', FALSE, 14),

-- Pergunta 15
('João Pessoa', TRUE, 15),
('Campina Grande', FALSE, 15),
('Patos', FALSE, 15),
('Sousa', FALSE, 15),

-- Pergunta 16
('Itaipu', TRUE, 16),
('Belo Monte', FALSE, 16),
('Tucuruí', FALSE, 16),
('Xingó', FALSE, 16),

-- Pergunta 17
('Recife', TRUE, 17),
('Olinda', FALSE, 17),
('Caruaru', FALSE, 17),
('Petrolina', FALSE, 17),

-- Pergunta 18
('Serra da Capivara', TRUE, 18),
('Chapada dos Veadeiros', FALSE, 18),
('Lençóis Maranhenses', FALSE, 18),
('Aparados da Serra', FALSE, 18),

-- Pergunta 19
('Cristo Redentor', TRUE, 19),
('Pão de Açúcar', FALSE, 19),
('Maracanã', FALSE, 19),
('Escadaria Selarón', FALSE, 19),

-- Pergunta 20
('Natal', TRUE, 20),
('Mossoró', FALSE, 20),
('Parnamirim', FALSE, 20),
('Caicó', FALSE, 20),

-- Pergunta 21
('Porto Alegre', TRUE, 21),
('Caxias do Sul', FALSE, 21),
('Pelotas', FALSE, 21),
('Gramado', FALSE, 21),

-- Pergunta 22
('Porto Velho', TRUE, 22),
('Ji-Paraná', FALSE, 22),
('Ariquemes', FALSE, 22),
('Vilhena', FALSE, 22),

-- Pergunta 23
('Boa Vista', TRUE, 23),
('Pacaraima', FALSE, 23),
('Caracaraí', FALSE, 23),
('Mucajaí', FALSE, 23),

-- Pergunta 24
('Florianópolis', TRUE, 24),
('Joinville', FALSE, 24),
('Blumenau', FALSE, 24),
('Chapecó', FALSE, 24),

-- Pergunta 25
('São Paulo', TRUE, 25),
('Campinas', FALSE, 25),
('Santos', FALSE, 25),
('Sorocaba', FALSE, 25),

-- Pergunta 26
('Aracaju', TRUE, 26),
('Lagarto', FALSE, 26),
('Itabaiana', FALSE, 26),
('Estância', FALSE, 26),

-- Pergunta 27
('Palmas', TRUE, 27),
('Araguaína', FALSE, 27),
('Gurupi', FALSE, 27),
('Porto Nacional', FALSE, 27);


-- Consulta de Tabelas
SELECT * FROM Adm;
SELECT * FROM Alternativa;
SELECT * FROM Consultar;
SELECT * FROM Estado;
SELECT * FROM Gerenciar;
SELECT * FROM Info_regiao;
SELECT * FROM Interacao;
SELECT * FROM MiniJogo;
SELECT * FROM Modificar_nota;
SELECT * FROM Notas;
SELECT * FROM Perfil_Usuario;
SELECT * FROM Pergunta;
SELECT * FROM Professor;
SELECT * FROM Quiz;
SELECT * FROM Regiao;
SELECT * FROM Usuario_Padrao;

DESC Adm;

-- DISTINCT Ignora valores duplicados EX SELECT DISTINCT Pergunta;


SELECT Nome 
FROM Usuario_Padrao
WHERE ID_Usuario IN (	
SELECT ID_Usuario 
    FROM Notas 
    WHERE Nota > 9.00
    );

select adm;

SELECT nome
FROM adm
WHERE 'Jessica Claro';

-- SELECT COM JUNCAO DE TABELAS
-- Me retorna o Usuario e a Nota que ele tirou
SELECT 
Usuario_Padrao.Nome AS Usuario, 
Notas.Nota
FROM 
Usuario_Padrao, 
Notas
WHERE 
Usuario_Padrao.ID_Usuario = Notas.ID_Usuario;

-- Retorna os Usuarios e link da foto de perfil
SELECT 
U.Nome AS Usuario, 
P.Foto
FROM 
Usuario_Padrao U, 
Perfil_Usuario P
WHERE 
U.ID_Usuario = P.ID_Usuario;

-- Trazer o nome da regiao e os estados que pertencem a ela
SELECT 
R.Nome_Regiao, 
E.Nome_Estado
FROM 
Regiao R, 
Estado E
WHERE 
R.ID_Regiao = E.ID_Regiao;

-- Listar o nome do Quizz e o seu enunciado apenas de uma regiao especifica
SELECT 
R.Nome_Regiao, 
M.Nome_Jogo
FROM 
Regiao R, 
MiniJogo M
WHERE 
    R.ID_Regiao = M.ID_Regiao
    AND R.Nome_Regiao = 'Nordeste';
    
-- Traz o enunciado e a pergunta correta
SELECT 
P.Enunciado, 
A.Descricao
FROM 
Pergunta P, 
Alternativa A
WHERE 
P.ID_Pergunta = A.ID_Pergunta
AND A.Alternativa_Correta = TRUE;

-- PALOMA - SELECT/SUBSELECT --

-- NOTAS ACIMA DA MEDIA -- 

	SELECT Nome
	FROM Usuario_Padrao
	WHERE ID_Usuario IN (
		SELECT ID_Usuario
		FROM Notas
		WHERE Nota > (
			SELECT AVG(Nota)
			FROM Notas
		)
	);
    
 -- PROFESSOR NOTAS ACIMA DA MEDIA --    -- IN RETORNA VARIOS VALORES --
    
SELECT Nome
FROM Professor
WHERE ID_Professor IN (
    SELECT ID_Professor
    FROM Notas
    WHERE Nota = (
        SELECT MAX(Nota)
        FROM Notas
    )
);

 -- quiz nota minima  --    -- IN RETORNA VARIOS VALORES --
 
SELECT Nome_Quiz
FROM Quiz
WHERE ID_Quiz = (
    SELECT ID_Quiz
    FROM Notas
    WHERE Nota = (
        SELECT MIN(Nota)
        FROM Notas
    )
);

-- tras os estados dentro da região selecionada -- 

SELECT Nome_Estado
FROM Estado
WHERE ID_Regiao = (
    SELECT ID_Regiao
    FROM Regiao
    WHERE Nome_Regiao = 'Sudeste'
);

-- Quais usuários fizeram o Quiz São Paulo? --

SELECT Nome
FROM Usuario_Padrao
WHERE ID_Usuario IN (
    SELECT ID_Usuario
    FROM Notas
    WHERE ID_Quiz = (
        SELECT ID_Quiz
        FROM Quiz
        WHERE Nome_Quiz = 'Quiz São Paulo'
    )
);

-- Views com filtragem --

-- 1. Usuários com nota acima de 8 --
CREATE VIEW vw_Usuarios_Nota_Alta AS
SELECT u.Nome, n.Nota
FROM Usuario_Padrao u
JOIN Notas n
ON u.ID_Usuario = n.ID_Usuario
WHERE n.Nota > 8;

SELECT * FROM vw_Usuarios_Nota_Alta;
-- mostra apenas os alunos com desempenho alto (acima de 8) --

-- 2. Professores que corrigiram notas acima de 9 -- 
CREATE VIEW vw_Professores_Excelencia AS
SELECT p.Nome, n.Nota
FROM Professor p
JOIN Notas n
ON p.ID_Professor = n.ID_Professor
WHERE n.Nota >= 9;

SELECT * FROM vw_Professores_Excelencia;
-- exibe os professores associados às melhores notas. --

-- 3. Estados da Região Sudeste -- 
CREATE VIEW vw_Estados_Sudeste AS
SELECT e.Nome_Estado, e.Sigla
FROM Estado e
JOIN Regiao r
ON e.ID_Regiao = r.ID_Regiao
WHERE r.Nome_Regiao = 'Sudeste';

SELECT * FROM vw_Estados_Sudeste;
-- mostra apenas os estados pertencentes ao Sudeste. --

-- 4. Usuários e os quizzes que realizaram -- 
CREATE VIEW vw_Usuarios_Quiz AS
SELECT u.Nome AS Usuario,
       q.Nome_Quiz,
       n.Nota
FROM Usuario_Padrao u
JOIN Notas n
    ON u.ID_Usuario = n.ID_Usuario
JOIN Quiz q
    ON n.ID_Quiz = q.ID_Quiz
WHERE n.Nota >= 7;

SELECT * FROM vw_Usuarios_Quiz;
-- mostra os usuários aprovados (nota maior ou igual a 7), qual quiz fizeram e a nota obtida.--

-- 5. Usuários e os quizzes que realizaram -- 
CREATE VIEW vw_Informacoes_Regioes AS
SELECT r.Nome_Regiao,
       ir.Info_Regiao
FROM Regiao r
JOIN Info_Regiao ir
    ON r.ID_Regiao = ir.ID_Regiao
WHERE LENGTH(ir.Info_Regiao) > 200;

SELECT * FROM vw_Informacoes_Regioes;
-- exibe apenas as regiões que possuem descrições detalhadas cadastradas.--

-- criação de backup 

CREATE TABLE backup_ADM like ADM;
insert into backup_ADM (select * from ADM);
select * from backup_ADM;

CREATE TABLE backup_Alternativa like Alternativa;
insert into backup_Alternativa (select * from Alternativa);
select * from backup_Alternativa;

CREATE TABLE backup_Estado like Estado;
insert into backup_Estado (select * from Estado);
select * from backup_Estado;

CREATE TABLE backup_Info_regiao like Info_regiao;
insert into backup_Info_regiao (select * from Info_regiao);
select * from backup_Info_regiao;

CREATE TABLE backup_MiniJogo like MiniJogo;
insert into backup_MiniJogo (select * from MiniJogo);
select * from backup_MiniJogo;

CREATE TABLE backup_Notas like Notas;
insert into backup_Notas (select * from Notas);
select * from backup_Notas;

CREATE TABLE backup_Perfil_Usuario like Perfil_Usuario;
insert into backup_Perfil_Usuario (select * From Perfil_Usuario);
select * from backup_Perfil_Usuario;

CREATE TABLE backup_Pergunta like Pergunta;
insert into backup_Pergunta (select * from Pergunta);
select * from backup_Pergunta;

CREATE TABLE backup_Professor like Professor;
insert into backup_Professor (select * from Professor);
select * from backup_Professor;

CREATE TABLE backup_Quiz like Quiz;
insert into backup_Quiz (select * from Quiz);
select * from backup_Quiz;


CREATE TABLE backup_Regiao like Regiao;
insert into backup_Regiao (select * from Regiao);
select * from backup_Regiao;

CREATE TABLE backup_Usuario_Padrao like Usuario_Padrao;
insert into backup_Usuario_Padrao (select * from Usuario_Padrao);
select * from backup_Usuario_Padrao;

-- criação de trigger para atualização automática das tabelas de backup

-- backup ADM

DELIMITER $$

CREATE TRIGGER trg_adm_insert AFTER INSERT ON ADM
FOR EACH ROW
BEGIN
    INSERT INTO backup_ADM VALUES (
        NEW.ID_Adm, NEW.Nome, NEW.Login_usuario_Adm, NEW.SENHA, NEW.RGM
    );
END $$

CREATE TRIGGER trg_adm_update AFTER UPDATE ON ADM
FOR EACH ROW
BEGIN
    UPDATE backup_ADM SET
        Nome = NEW.Nome,
        Login_usuario_Adm = NEW.Login_usuario_Adm,
        SENHA = NEW.SENHA,
        RGM = NEW.RGM
    WHERE ID_Adm = NEW.ID_Adm;
END $$

CREATE TRIGGER trg_adm_delete AFTER DELETE ON ADM
FOR EACH ROW
BEGIN
    DELETE FROM backup_ADM WHERE ID_Adm = OLD.ID_Adm;
END $$

DELIMITER ;

-- backup úsuario padrao

DELIMITER $$

CREATE TRIGGER trg_usuario_insert AFTER INSERT ON Usuario_Padrao
FOR EACH ROW
BEGIN
    INSERT INTO backup_Usuario_Padrao VALUES (
        NEW.ID_Usuario, NEW.Email, NEW.SENHA, NEW.Nome
    );
END $$

CREATE TRIGGER trg_usuario_update AFTER UPDATE ON Usuario_Padrao
FOR EACH ROW
BEGIN
    UPDATE backup_Usuario_Padrao SET
        Email = NEW.Email,
        SENHA = NEW.SENHA,
        Nome = NEW.Nome
    WHERE ID_Usuario = NEW.ID_Usuario;
END $$

CREATE TRIGGER trg_usuario_delete AFTER DELETE ON Usuario_Padrao
FOR EACH ROW
BEGIN
    DELETE FROM backup_Usuario_Padrao WHERE ID_Usuario = OLD.ID_Usuario;
END $$

DELIMITER ;

-- backup professor

DELIMITER $$

CREATE TRIGGER trg_professor_insert AFTER INSERT ON Professor
FOR EACH ROW
BEGIN
    INSERT INTO backup_Professor VALUES (
        NEW.ID_Professor, NEW.Email, NEW.Nome, NEW.Senha
    );
END $$

CREATE TRIGGER trg_professor_update AFTER UPDATE ON Professor
FOR EACH ROW
BEGIN
    UPDATE backup_Professor SET
        Email = NEW.Email,
        Nome = NEW.Nome,
        Senha = NEW.Senha
    WHERE ID_Professor = NEW.ID_Professor;
END $$

CREATE TRIGGER trg_professor_delete AFTER DELETE ON Professor
FOR EACH ROW
BEGIN
    DELETE FROM backup_Professor WHERE ID_Professor = OLD.ID_Professor;
END $$

DELIMITER ;

-- backup regiao

DELIMITER $$

CREATE TRIGGER trg_regiao_insert AFTER INSERT ON Regiao
FOR EACH ROW BEGIN
INSERT INTO backup_Regiao VALUES (NEW.ID_Regiao, NEW.Nome_Regiao);
END $$

CREATE TRIGGER trg_regiao_update AFTER UPDATE ON Regiao
FOR EACH ROW BEGIN
UPDATE backup_Regiao SET Nome_Regiao=NEW.Nome_Regiao
WHERE ID_Regiao=NEW.ID_Regiao;
END $$

CREATE TRIGGER trg_regiao_delete AFTER DELETE ON Regiao
FOR EACH ROW BEGIN
DELETE FROM backup_Regiao WHERE ID_Regiao=OLD.ID_Regiao;
END $$

DELIMITER ;

-- backup notas

DELIMITER $$

CREATE TRIGGER trg_notas_insert AFTER INSERT ON Notas
FOR EACH ROW
BEGIN
    INSERT INTO backup_Notas VALUES (
        NEW.ID_Nota, NEW.Nota, NEW.ID_Quiz, NEW.ID_Usuario, NEW.ID_Professor
    );
END $$

CREATE TRIGGER trg_notas_update AFTER UPDATE ON Notas
FOR EACH ROW
BEGIN
    UPDATE backup_Notas SET
        Nota = NEW.Nota,
        ID_Quiz = NEW.ID_Quiz,
        ID_Usuario = NEW.ID_Usuario,
        ID_Professor = NEW.ID_Professor
    WHERE ID_Nota = NEW.ID_Nota;
END $$

CREATE TRIGGER trg_notas_delete AFTER DELETE ON Notas
FOR EACH ROW
BEGIN
    DELETE FROM backup_Notas WHERE ID_Nota = OLD.ID_Nota;
END $$

DELIMITER ;

-- backup Quiz

DELIMITER $$

CREATE TRIGGER trg_quiz_insert AFTER INSERT ON Quiz
FOR EACH ROW
BEGIN
    INSERT INTO backup_Quiz VALUES (
        NEW.ID_Quiz, NEW.Nome_Quiz
    );
END $$

CREATE TRIGGER trg_quiz_update AFTER UPDATE ON Quiz
FOR EACH ROW
BEGIN
    UPDATE backup_Quiz SET
        Nome_Quiz = NEW.Nome_Quiz
    WHERE ID_Quiz = NEW.ID_Quiz;
END $$

CREATE TRIGGER trg_quiz_delete AFTER DELETE ON Quiz
FOR EACH ROW
BEGIN
    DELETE FROM backup_Quiz WHERE ID_Quiz = OLD.ID_Quiz;
END $$

DELIMITER ;

-- backup estado

DELIMITER $$

CREATE TRIGGER trg_estado_insert AFTER INSERT ON Estado
FOR EACH ROW BEGIN
INSERT INTO backup_Estado VALUES (NEW.ID_Estado, NEW.Nome_Estado, NEW.Sigla, NEW.ID_Regiao);
END $$

CREATE TRIGGER trg_estado_update AFTER UPDATE ON Estado
FOR EACH ROW BEGIN
UPDATE backup_Estado SET Nome_Estado=NEW.Nome_Estado, Sigla=NEW.Sigla, ID_Regiao=NEW.ID_Regiao
WHERE ID_Estado=NEW.ID_Estado;
END $$

CREATE TRIGGER trg_estado_delete AFTER DELETE ON Estado
FOR EACH ROW BEGIN
DELETE FROM backup_Estado WHERE ID_Estado=OLD.ID_Estado;
END $$

DELIMITER ;

-- backup pergunta 

DELIMITER $$

CREATE TRIGGER trg_pergunta_insert AFTER INSERT ON Pergunta
FOR EACH ROW BEGIN
INSERT INTO backup_Pergunta VALUES (NEW.ID_Pergunta, NEW.Enunciado, NEW.ID_Quiz, NEW.ID_Estado);
END $$

CREATE TRIGGER trg_pergunta_update AFTER UPDATE ON Pergunta
FOR EACH ROW BEGIN
UPDATE backup_Pergunta SET Enunciado=NEW.Enunciado, ID_Quiz=NEW.ID_Quiz, ID_Estado=NEW.ID_Estado
WHERE ID_Pergunta=NEW.ID_Pergunta;
END $$

CREATE TRIGGER trg_pergunta_delete AFTER DELETE ON Pergunta
FOR EACH ROW BEGIN
DELETE FROM backup_Pergunta WHERE ID_Pergunta=OLD.ID_Pergunta;
END $$

DELIMITER ;

-- backup alternativa

DELIMITER $$

CREATE TRIGGER trg_alt_insert AFTER INSERT ON Alternativa
FOR EACH ROW BEGIN
INSERT INTO backup_Alternativa VALUES (NEW.ID_Alternativa, NEW.Descricao, NEW.Alternativa_Correta, NEW.ID_Pergunta);
END $$

CREATE TRIGGER trg_alt_update AFTER UPDATE ON Alternativa
FOR EACH ROW BEGIN
UPDATE backup_Alternativa SET Descricao=NEW.Descricao,
Alternativa_Correta=NEW.Alternativa_Correta, ID_Pergunta=NEW.ID_Pergunta
WHERE ID_Alternativa=NEW.ID_Alternativa;
END $$

CREATE TRIGGER trg_alt_delete AFTER DELETE ON Alternativa
FOR EACH ROW BEGIN
DELETE FROM backup_Alternativa WHERE ID_Alternativa=OLD.ID_Alternativa;
END $$

DELIMITER ;

-- backup perfil usuario

DELIMITER $$

CREATE TRIGGER trg_perfil_insert AFTER INSERT ON Perfil_Usuario
FOR EACH ROW BEGIN
INSERT INTO backup_Perfil_Usuario VALUES (NEW.Id_Perfil, NEW.Nome, NEW.Foto, NEW.ID_Usuario);
END $$

CREATE TRIGGER trg_perfil_update AFTER UPDATE ON Perfil_Usuario
FOR EACH ROW BEGIN
UPDATE backup_Perfil_Usuario SET Nome=NEW.Nome, Foto=NEW.Foto, ID_Usuario=NEW.ID_Usuario
WHERE Id_Perfil=NEW.Id_Perfil;
END $$

CREATE TRIGGER trg_perfil_delete AFTER DELETE ON Perfil_Usuario
FOR EACH ROW BEGIN
DELETE FROM backup_Perfil_Usuario WHERE Id_Perfil=OLD.Id_Perfil;
END $$

DELIMITER ;

-- backup info regiao

DELIMITER $$

CREATE TRIGGER trg_perfil_insert AFTER INSERT ON Perfil_Usuario
FOR EACH ROW BEGIN
INSERT INTO backup_Perfil_Usuario VALUES (NEW.Id_Perfil, NEW.Nome, NEW.Foto, NEW.ID_Usuario);
END $$

CREATE TRIGGER trg_perfil_update AFTER UPDATE ON Perfil_Usuario
FOR EACH ROW BEGIN
UPDATE backup_Perfil_Usuario SET Nome=NEW.Nome, Foto=NEW.Foto, ID_Usuario=NEW.ID_Usuario
WHERE Id_Perfil=NEW.Id_Perfil;
END $$

CREATE TRIGGER trg_perfil_delete AFTER DELETE ON Perfil_Usuario
FOR EACH ROW BEGIN
DELETE FROM backup_Perfil_Usuario WHERE Id_Perfil=OLD.Id_Perfil;
END $$

DELIMITER ;

-- backup minijogo

DELIMITER $$

CREATE TRIGGER trg_mini_insert AFTER INSERT ON MiniJogo
FOR EACH ROW BEGIN
INSERT INTO backup_MiniJogo VALUES (NEW.ID_MiniJogo, NEW.Nome_Jogo, NEW.Tipo_Jogo, NEW.Descricao, NEW.ID_Regiao);
END $$

CREATE TRIGGER trg_mini_update AFTER UPDATE ON MiniJogo
FOR EACH ROW BEGIN
UPDATE backup_MiniJogo SET Nome_Jogo=NEW.Nome_Jogo, Tipo_Jogo=NEW.Tipo_Jogo,
Descricao=NEW.Descricao, ID_Regiao=NEW.ID_Regiao
WHERE ID_MiniJogo=NEW.ID_MiniJogo;
END $$

CREATE TRIGGER trg_mini_delete AFTER DELETE ON MiniJogo
FOR EACH ROW BEGIN
DELETE FROM backup_MiniJogo WHERE ID_MiniJogo=OLD.ID_MiniJogo;
END $$

DELIMITER ;

-- Select com Junção de Tabelas usando Inner Join
 
-- Consultar a nota de cada usuário:
SELECT u.nome, n.nota
FROM Usuario_Padrao U
INNER JOIN Notas N
ON U.ID_Usuario = N.ID_Usuario;
 
-- Consultar a nota, o usuario e o professor que lançou a nota:
SELECT U.Nome as Usuario, 
P.Nome as Professor, 
N.Nota
FROM Notas N
INNER JOIN Usuario_Padrao U 
ON N.ID_Usuario = U.ID_Usuario
INNER JOIN Professor P 
ON N.ID_Professor = P.ID_Professor;
 
-- Consultar estados com suas siglas e suas respectivas regiões:
SELECT E.Nome_Estado,
E.Sigla,
R.Nome_Regiao
FROM Estado E
INNER JOIN Regiao R 
ON E.ID_Regiao = R.ID_Regiao;
 
-- Consultar perguntas e o quiz ao qual pertencem:
SELECT Q.Nome_Quiz,
P.Enunciado
FROM Pergunta P 
INNER JOIN Quiz Q
ON P.ID_Quiz = Q.ID_Quiz;
 
-- Para buscar a pergunta referente a um quiz específico pelo ID: 
SELECT Q.Nome_Quiz,
P.Enunciado
FROM Pergunta P 
INNER JOIN Quiz Q
ON P.ID_Quiz = Q.ID_Quiz
WHERE P.ID_Pergunta = 5;
 
-- Consultar perguntas e alternativas corretas
SELECT P.Enunciado,
A.Descricao,
A.Alternativa_Correta
FROM Pergunta P 
INNER JOIN Alternativa A 
ON P.ID_Pergunta = A.ID_Pergunta;
 
-- Consultar Notas e Quiz Realizado:
SELECT Q.Nome_Quiz,
N.Nota
FROM Notas N 
INNER JOIN Quiz Q
ON N.ID_Quiz = Q.ID_Quiz;  
 
 
-- PROCEDIMENTOS COM ESTRUTURA CONDICIONAL PARA EXECUTAR COMMIT E ROLLBACK
 
-- Inserir usuario:
DROP PROCEDURE IF EXISTS Inserir_Usuario
DELIMITER //
CREATE PROCEDURE Inserir_Usuario(
	IN p_Email VARCHAR (100),
    IN p_Senha VARCHAR(255),
    IN p_Nome VARCHAR(100)
)
BEGIN
	START TRANSACTION;
    IF NOT EXISTS (
    SELECT 1 FROM Usuario_Padrao
    WHERE Email = p_Email
    )THEN
    INSERT INTO Usuario_padrao(Email, Senha, Nome)
    VALUES (p_Email, p_Senha, p_Nome);
	COMMIT; 
    ELSE ROLLBACK;
    END IF;
END//
DELIMITER ;
 
-- Inserção de Dados
CALL Inserir_Usuario(
'joana@email.com',
SHA2('Senha123', 256),
'Joana Silva');
 
-- Consulta
SELECT * FROM Usuario_Padrao;
 
-- Deletar uma linha
DELETE FROM Usuario_Padrao
WHERE Email = 'prof@email.com'
 
-- Inserir professor:
DROP PROCEDURE IF EXISTS Inserir_Professor
DELIMITER //
CREATE PROCEDURE Inserir_Professor(
	IN p_Email VARCHAR (100),
    IN p_Senha VARCHAR(255),
    IN p_Nome VARCHAR(100)
)
BEGIN
	START TRANSACTION;
    IF NOT EXISTS (
    SELECT 1 FROM PROFESSOR
    WHERE Email = p_Email
    )THEN
    INSERT INTO Professor(Email, Senha, Nome)
    VALUES (p_Email, p_Senha, p_Nome);
	COMMIT; 
    ELSE ROLLBACK;
    END IF;
END//
DELIMITER ;
 
-- Inserção de Dados
CALL Inserir_Professor(
'prof@email.com',
SHA2('Prof123', 256),
'Marcos Souza');
 
-- Consulta
SELECT * FROM PROFESSOR;
 
-- Inserir perguntas:
DROP PROCEDURE IF EXISTS Inserir_Perguntas
DELIMITER //
CREATE PROCEDURE Inserir_Perguntas(
	IN p_Enunciado TEXT,
    IN p_ID_Quiz SMALLINT,
    IN p_ID_Estado SMALLINT
)
BEGIN
	START TRANSACTION;
    IF EXISTS (
    SELECT 1 FROM Quiz
    WHERE ID_Quiz = p_ID_Quiz
    )
    AND EXISTS (
    SELECT 1 FROM Estado
    WHERE ID_Estado = p_ID_Estado
    )THEN
    INSERT INTO Pergunta (Enunciado, ID_Quiz, ID_Estado)
    VALUES (p_Enunciado, p_ID_Quiz, p_ID_Estado);
	COMMIT; 
    ELSE ROLLBACK;
    END IF;
END//
DELIMITER ;
 
-- Inserção de Dados
CALL  Inserir_Perguntas(
'Qual é a capital do estado de São Paulo?',
25,
25
);
 
-- Consulta
SELECT * FROM Pergunta;
 
-- Validar se a nota está entre 0 e 10 e se o usuário, quiz e professor ja existem:
DROP PROCEDURE IF EXISTS Inserir_Nota_Validada
DELIMITER //
CREATE PROCEDURE Inserir_Nota_Validada(
	IN p_Nota TEXT,
    IN p_ID_Quiz SMALLINT,
    IN p_ID_Usuario SMALLINT,
    IN p_ID_Professor SMALLINT
)
BEGIN
	START TRANSACTION;
    IF p_Nota BETWEEN 0 AND 10
    AND EXISTS(
    SELECT 1 FROM Usuario_Padrao
    WHERE ID_Usuario = p_ID_Usuario
    )
    AND EXISTS (
    SELECT 1 FROM Quiz
    WHERE ID_Quiz = p_ID_Quiz
    )
    AND EXISTS (
    SELECT 1 FROM Professor 
    WHERE ID_Professor = p_ID_Professor
    )THEN
    INSERT INTO Notas (Nota, ID_Quiz, ID_Usuario, ID_Professor)
    VALUES (p_Nota, p_ID_Quiz, p_ID_Usuario, p_ID_Professor);
	COMMIT; 
    ELSE ROLLBACK;
    END IF;
END//
DELIMITER ;
 
-- Inserção de Dados
CALL  Inserir_Nota_Validada(
8.5,1,1,1
);
 
-- Consulta
SELECT * FROM Notas;
 
 
-- Atualizar Nota:
DROP PROCEDURE IF EXISTS Atualizar_Nota
DELIMITER //
CREATE PROCEDURE Atualizar_Nota(
	IN p_ID_Nota SMALLINT,
    IN p_Nova_Nota DECIMAL(4,2)
)
BEGIN
	START TRANSACTION;
    IF EXISTS(
    SELECT 1 FROM Notas
    WHERE ID_Nota = p_ID_Nota
    )
    AND p_Nova_Nota BETWEEN 0 AND 10
    THEN
    UPDATE Notas 
    SET Nota = p_Nova_Nota
    WHERE ID_Nota = p_ID_Nota;
	COMMIT; 
    ELSE ROLLBACK;
    END IF;
END//
DELIMITER ;
 
-- Inserção de Dados
CALL  Atualizar_Nota(
1,9.5
);
 
 
-- Consulta
SELECT * FROM Notas WHERE ID_Nota = 1;

-- Procedures e função 

-- Listar os 10 melhores desempenhos (Top 10 Notas)
DELIMITER $$
CREATE PROCEDURE Listar_Top_10_Notas()
BEGIN
    SELECT 
        U.Nome AS Usuario,
        Q.Nome_Quiz,
        N.Nota
    FROM Notas N
    INNER JOIN Usuario_Padrao U ON N.ID_Usuario = U.ID_Usuario
    INNER JOIN Quiz Q ON N.ID_Quiz = Q.ID_Quiz
    ORDER BY N.Nota DESC
    LIMIT 10;
END $$
DELIMITER ;

-- Relatório de Usuários sem interação (Sem Notas)
DELIMITER $$
CREATE PROCEDURE Relatorio_Usuarios_Sem_Notas()
BEGIN
    SELECT 
        U.ID_Usuario,
        U.Nome,
        U.Email
    FROM Usuario_Padrao U
    LEFT JOIN Notas N ON U.ID_Usuario = N.ID_Usuario
    WHERE N.ID_Nota IS NULL;
END $$
DELIMITER ;

-- Buscar Perguntas e Respostas por Quiz
DELIMITER $$
CREATE PROCEDURE Buscar_Perguntas_Por_Quiz(IN p_ID_Quiz SMALLINT)
BEGIN
    SELECT 
        P.ID_Pergunta,
        P.Enunciado,
        A.Descricao AS Resposta_Correta
    FROM Pergunta P
    INNER JOIN Alternativa A ON P.ID_Pergunta = A.ID_Pergunta
    WHERE P.ID_Quiz = p_ID_Quiz AND A.Alternativa_Correta = TRUE;
END $$
DELIMITER ;

-- Registrar Interação do Usuário na Região
DELIMITER $$
CREATE PROCEDURE Registrar_Interacao(
    IN p_ID_Usuario SMALLINT,
    IN p_ID_Regiao SMALLINT
)
BEGIN
    START TRANSACTION;
    IF EXISTS (SELECT 1 FROM Usuario_Padrao WHERE ID_Usuario = p_ID_Usuario) 
       AND EXISTS (SELECT 1 FROM Regiao WHERE ID_Regiao = p_ID_Regiao) 
       AND NOT EXISTS (SELECT 1 FROM Interacao WHERE ID_Usuario = p_ID_Usuario AND ID_Regiao = p_ID_Regiao)
    THEN
        INSERT INTO Interacao (ID_Usuario, ID_Regiao) VALUES (p_ID_Usuario, p_ID_Regiao);
        COMMIT;
    ELSE 
        ROLLBACK;
    END IF;
END $$
DELIMITER ;

-- Excluir Usuário e Seus Dados
DELIMITER $$
CREATE PROCEDURE Excluir_Usuario_Seguro(IN p_ID_Usuario SMALLINT)
BEGIN
    START TRANSACTION;
    IF EXISTS (SELECT 1 FROM Usuario_Padrao WHERE ID_Usuario = p_ID_Usuario) THEN
        -- Deleta as notas do usuario primeiro
        DELETE FROM Notas WHERE ID_Usuario = p_ID_Usuario;
        -- Deleta o usuario
        DELETE FROM Usuario_Padrao WHERE ID_Usuario = p_ID_Usuario;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END $$
DELIMITER ;

-- Total de Usuários Cadastrados
DELIMITER $$
CREATE FUNCTION Total_Usuarios_Cadastrados() 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Usuario_Padrao;
    RETURN total;
END $$
DELIMITER ;

-- Média Geral de Todas as Notas
DELIMITER $$
CREATE FUNCTION Media_Geral_Notas() 
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE media DECIMAL(4,2);
    SELECT IFNULL(AVG(Nota), 0) INTO media FROM Notas;
    RETURN media;
END $$
DELIMITER ;

-- Média de Notas por Usuário
DELIMITER $$
CREATE FUNCTION Media_Notas_Usuario(p_ID_Usuario SMALLINT) 
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE media_usuario DECIMAL(4,2);
    SELECT IFNULL(AVG(Nota), 0) INTO media_usuario 
    FROM Notas 
    WHERE ID_Usuario = p_ID_Usuario;
    
    RETURN media_usuario;
END $$
DELIMITER ;

-- Verificar Status de Aprovação no Quiz
DELIMITER $$
CREATE FUNCTION Verificar_Aprovacao(p_ID_Usuario SMALLINT, p_ID_Quiz SMALLINT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE nota_obtida DECIMAL(4,2);
    DECLARE status_resultado VARCHAR(20);
    
    SELECT Nota INTO nota_obtida 
    FROM Notas 
    WHERE ID_Usuario = p_ID_Usuario AND ID_Quiz = p_ID_Quiz 
    LIMIT 1;
    
    IF nota_obtida IS NULL THEN
        SET status_resultado = 'Pendente';
    ELSEIF nota_obtida >= 7.00 THEN
        SET status_resultado = 'Aprovado';
    ELSE
        SET status_resultado = 'Reprovado';
    END IF;
    
    RETURN status_resultado;
END $$
DELIMITER ;

-- Contar Minijogos por Região
DELIMITER $$
CREATE FUNCTION Contar_Minijogos_Regiao(p_ID_Regiao SMALLINT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE qtd_jogos INT;
    
    SELECT COUNT(*) INTO qtd_jogos 
    FROM MiniJogo 
    WHERE ID_Regiao = p_ID_Regiao;
    
    RETURN qtd_jogos;
END $$
DELIMITER ;

-- INDEX

-- 1. TABELA: ADM
CREATE INDEX idx_adm_nome
ON ADM (Nome);

-- 2. TABELA: USUARIO_PADRAO
CREATE INDEX idx_usuario_nome
ON Usuario_Padrao (Nome);

-- 3. TABELA: PROFESSOR
CREATE INDEX idx_professor_nome
ON Professor (Nome);

-- 4. TABELA: REGIAO
CREATE INDEX idx_regiao_nome
ON Regiao (Nome_Regiao);

-- 5. TABELA: QUIZ
CREATE INDEX idx_quiz_nome
ON Quiz (Nome_Quiz);

-- 6. TABELA: ESTADO
CREATE INDEX idx_estado_nome 
ON Estado (Nome_Estado);

CREATE INDEX idx_estado_regiao 
ON Estado (ID_Regiao);

-- 7. TABELA: PERFIL_USUARIO
CREATE INDEX idx_perfil_nome 
ON Perfil_Usuario (Nome);

CREATE INDEX idx_perfil_usuario 
ON Perfil_Usuario (ID_Usuario);

-- 8. TABELA: INFO_REGIAO
CREATE INDEX idx_inforegiao_texto 
ON Info_Regiao (Info_Regiao(255));

CREATE INDEX idx_inforegiao_regiao 
ON Info_Regiao (ID_Regiao);

-- 9. TABELA: NOTAS
CREATE INDEX idx_notas_usuario 
ON Notas (ID_Usuario);

CREATE INDEX idx_notas_quiz 
ON Notas (ID_Quiz);

CREATE INDEX idx_notas_professor 
ON Notas (ID_Professor);

-- 10. TABELA: PERGUNTA
CREATE INDEX idx_pergunta_enunciado 
ON Pergunta (Enunciado(255));

CREATE INDEX idx_pergunta_quiz 
ON Pergunta (ID_Quiz);

CREATE INDEX idx_pergunta_estado 
ON Pergunta (ID_Estado);

-- 11. TABELA: MINIJOGO
CREATE INDEX idx_minijogo_nome 
ON MiniJogo (Nome_Jogo);

CREATE INDEX idx_minijogo_regiao 
ON MiniJogo (ID_Regiao);

-- 12. TABELA: ALTERNATIVA
CREATE INDEX idx_alternativa_descricao 
ON Alternativa (Descricao(255));

CREATE INDEX idx_alternativa_pergunta 
ON Alternativa (ID_Pergunta);


-- ====================================================================
-- COMANDOS PARA VISUALIZAR OS ÍNDICES NO CONSOLE/PAINEL
-- ====================================================================

SHOW INDEX FROM ADM;
SHOW INDEX FROM Usuario_Padrao;
SHOW INDEX FROM Professor;
SHOW INDEX FROM Regiao;
SHOW INDEX FROM Quiz;
SHOW INDEX FROM Estado;
SHOW INDEX FROM Perfil_Usuario;
SHOW INDEX FROM Info_Regiao;
SHOW INDEX FROM Notas;
SHOW INDEX FROM Pergunta;
SHOW INDEX FROM MiniJogo;
SHOW INDEX FROM Alternativa;
