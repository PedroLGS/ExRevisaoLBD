CREATE DATABASE escola

USE escola

CREATE TABLE aluno(
ra			INT				NOT NULL,
nome		VARCHAR(100)	NOT NULL,
idade		INT				NOT NULL
PRIMARY KEY(ra) 
)

CREATE TABLE disciplina(
codigo			INT				NOT NULL,
nome			VARCHAR(180)	NOT NULL,
carga_horaria	INT				NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE aluno_disciplina(
alunora				INT		NOT NULL,
disciplinacodigo	INT		NOT NULL
PRIMARY KEY (alunora, disciplinacodigo)
FOREIGN KEY (alunora) REFERENCES aluno(ra),
FOREIGN KEY (disciplinacodigo) REFERENCES disciplina(codigo)
)

CREATE TABLE curso(
codigo		INT				NOT NULL,
nome		VARCHAR(50)		NOT NULL,
area		INT				NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE curso_disciplina(
cursocodigo			INT		NOT NULL,
disciplinacodigo	INT		NOT NULL
PRIMARY KEY (cursocodigo, disciplinacodigo)
FOREIGN KEY (cursocodigo) REFERENCES curso(codigo),
FOREIGN KEY (disciplinacodigo) REFERENCES disciplina(codigo)
)

CREATE TABLE titulacao(
codigo		INT				NOT NULL,
titulo		VARCHAR(40)		NOT NULL
PRIMARY KEY (codigo)
)

CREATE TABLE professor(
registro	INT				NOT NULL,
nome		VARCHAR(100)	NOT NULL,
titulacao	INT				NOT NULL
PRIMARY KEY (registro)
FOREIGN KEY (titulacao)	REFERENCES titulacao(codigo)
)

CREATE TABLE disciplina_professor(
disciplinacodigo		INT		NOT NULL,
professorregistro		INT		NOT NULL
PRIMARY KEY(disciplinacodigo, professorregistro)
FOREIGN KEY (disciplinacodigo) REFERENCES disciplina(codigo),
FOREIGN KEY (professorregistro) REFERENCES professor(registro)
)

ALTER TABLE aluno ADD CONSTRAINT ci CHECK (IDADE > 0)

ALTER TABLE disciplina ADD CONSTRAINT do CHECK (carga_horaria > 32)

INSERT INTO aluno VALUES
(3416,'DIEGO PIOVESAN DE RAMOS',18),
(3423,'LEONARDO MAGALHÃES DA ROSA',17),
(3434,'LUIZA CRISTINA DE LIMA MARTINELI',20),
(3440,'IVO ANDRÉ FIGUEIRA DA SILVA',25),
(3443,'BRUNA LUISA SIMIONI',37),
(3448,'THAÍS NICOLINI DE MELLO',17),
(3457,'LÚCIO DANIEL TÂMARA ALVES',29),
(3459,'LEONARDO RODRIGUES',25),
(3465,'ÉDERSON RAFAEL VIEIRA',19),
(3466,'DAIANA ZANROSSO DE OLIVEIRA',21),
(3467,'DANIELA MAURER',23),
(3470,'ALEX SALVADORI PALUDO',42),
(3471,'VINÍCIUS SCHVARTZ',19),
(3472,'MARIANA CHIES ZAMPIERI',18),
(3482,'EDUARDO CAINAN GAVSKI',19),
(3483,'REDNALDO ORTIZ DONEDA',20),
(3499,'MAYELEN ZAMPIERON',22)

INSERT INTO disciplina VALUES
(1,'Laboratório de Banco de Dados',	80),
(2,'Laboratório de Engenharia de Software',	80),
(3,'Programação Linear e Aplicações',	80),
(4,'Redes de Computadores',	80),
(5,'Segurança da informação',	40),
(6,'Teste de Software',	80),
(7,'Custos e Tarifas Logísticas',	80),
(8,'Gestão de Estoques',	40),
(9,'Fundamentos de Marketing',	40),
(10,'Métodos Quantitativos de Gestão',	80),
(11,'Gestão do Tráfego Urbano',	80),
(12,'Sistemas de Movimentação e Transporte', 40)

INSERT INTO titulacao VALUES
(1,'Especialista'),
(2,'Mestre'),
(3,'Doutor')

INSERT INTO professor VALUES
(1111,'Leandro', 2),
(1112,'Antonio', 2),
(1113,'Alexandre', 3),
(1114,'Wellington', 2),
(1115,'Luciano', 1),
(1116,'Edson', 2),
(1117,'Ana', 2),
(1118,'Alfredo', 1),
(1119,'Celio', 2),
(1120,'Dewar', 3),
(1121,'Julio', 1)

INSERT INTO curso VALUES
(1,'ADS','Ciências da Computação'),
(2,'Logística','Engenharia Civil')

ALTER TABLE curso
ALTER COLUMN area VARCHAR(100) NOT NULL

INSERT INTO aluno_disciplina(disciplinacodigo, alunora) VALUES
(1, 3416),
(4,	3416),
(1,	3423),
(2,	3423),
(5,	3423),
(6,	3423),
(2,	3434),
(5,	3434),
(6,	3434),
(1,	3440),
(5,	3443),
(6,	3443),
(4,	3448),
(5,	3448),
(6,	3448),
(2,	3457),
(4,	3457),
(5,	3457),
(6,	3457),
(1,	3459),
(6,	3459),
(7,	3465),
(11, 3465),
(8,	3466),
(11, 3466),
(8,	3467),
(12, 3467),
(8,	3470),
(9,	3470),
(11, 3470),
(12, 3470),
(7,	3471),
(7,	3472),
(12, 3472),
(9,	3482),
(11, 3482),
(8,	3483),
(11, 3483),
(12, 3483),
(8,	3499)

INSERT INTO disciplina_professor VALUES
(1,	1111),
(2,	1112),
(3,	1113),
(4,	1114),
(5,	1115),
(6,	1116),
(7,	1117),
(8,	1118),
(9,	1117),
(10, 1119),
(11, 1120),
(12, 1121)

INSERT INTO curso_disciplina(disciplinacodigo, cursocodigo) VALUES
(1,	1),
(2,	1),
(3,	1),
(4,	1),
(5,	1),
(6,	1),
(7,	2),
(8,	2),
(9,	2),
(10,2),
(11,2),
(12,2)

SELECT al.ra AS RA, al.nome AS Nome_Aluno, di.nome AS Nome_Disciplina
FROM aluno al
INNER JOIN aluno_disciplina ad
ON al.ra = ad.alunora
INNER JOIN disciplina di
ON ad.disciplinacodigo = di.codigo
ORDER BY di.nome

SELECT di.nome AS Nome_Disciplina, pr.nome AS Nome_Professor
FROM disciplina di
INNER JOIN disciplina_professor dp
ON di.codigo = dp.disciplinacodigo
INNER JOIN professor pr
ON dp.professorregistro = pr.registro

SELECT di.nome AS Nome_Disciplina, cr.nome AS Nome_Curso
FROM curso cr 
INNER JOIN curso_disciplina cd
ON cr.codigo = cd.cursocodigo
INNER JOIN disciplina di
ON cd.disciplinacodigo = di.codigo

SELECT di.nome AS Nome_Disciplina, cr.area AS Area_Curso
FROM disciplina di
INNER JOIN curso_disciplina cd
ON di.codigo = cd.disciplinacodigo
INNER JOIN curso cr
ON cr.codigo = cd.cursocodigo

SELECT di.nome AS Nome_Disciplina, ti.titulo
FROM disciplina di
INNER JOIN disciplina_professor dp
ON di.codigo = dp.disciplinacodigo
INNER JOIN professor pr
ON pr.registro = dp.professorregistro
INNER JOIN titulacao ti
ON pr.titulacao = ti.codigo

SELECT di.nome AS Nome_Disciplina, COUNT(ad.disciplinacodigo) AS Qtd_alunos
FROM disciplina di
INNER JOIN aluno_disciplina ad
ON di.codigo = ad.disciplinacodigo
INNER JOIN aluno al
ON al.ra = ad.alunora
GROUP BY di.nome, ad.disciplinacodigo

SELECT di.nome AS Nome_Disciplina, pr.nome AS Nome_Professor
FROM disciplina di
INNER JOIN disciplina_professor dp
ON di.codigo = dp.disciplinacodigo
INNER JOIN professor pr
ON pr.registro = dp.professorregistro
WHERE di.nome IN (
SELECT di.nome 
FROM aluno al
INNER JOIN aluno_disciplina ad
ON al.ra = ad.alunora
INNER JOIN disciplina di
ON di.codigo = ad.disciplinacodigo
GROUP BY di.nome
HAVING COUNT(ad.disciplinacodigo) >= 5
)

SELECT cr.nome AS Nome_Curso, COUNT(pr.registro) AS qtd_professores_cadastrados 
FROM professor pr 
INNER JOIN disciplina_professor dp 
ON pr.registro = dp.professorregistro
INNER JOIN disciplina di 
ON di.codigo = dp.disciplinacodigo 
INNER JOIN curso_disciplina cd 
ON cd.disciplinacodigo = di.codigo 
INNER JOIN curso cr
ON cr.codigo = cd.cursocodigo
GROUP BY cr.nome