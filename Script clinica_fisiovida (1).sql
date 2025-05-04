CREATE DATABASE clinica_fisiovida;
USE clinica_fisiovida;
SET SQL_SAFE_UPDATES = 0;

/* CRIAÇÃO DA TABELA 1 */
CREATE TABLE Paciente(
idPaciente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR (45) NOT NULL,
data_nascimento DATE NOT NULL,
email VARCHAR (45) NOT NULL,
documento VARCHAR (45) NOT NULL UNIQUE,
convenio VARCHAR (45),
numero_carteirinha VARCHAR (45) UNIQUE,
problema_enfrentado VARCHAR (200) NOT NULL
);

/* INSERÇÃO DE DADOS DA TABELA 1 */
INSERT INTO Paciente (nome, data_nascimento, email, documento, convenio, numero_carteirinha, problema_enfrentado) VALUES 
('Maria', '2000-09-18', 'maria@hotmail.com', '65787989000', 'Porto Saude', '19980X', 'reabilitacao pos cirurgia na regiao pelvica'),
('Jose Alberto', '1978-10-10', 'albertojose@gmail.com', '54799989745','Amil', '45680T', 'reabilitacao pos cirurgia patelar'),
('Sergio Pioto', '1956-08-05', 'pioto@gmail.com', '65788989130','Notredame', '56789C', 'hernia de disco'),
('Micael Teixeira', '1980-07-15', 'Micael@gmail.com', '66885071060','Amil', '78915U', 'Lombalgia'),
('Alex Ribeiro', '1990-03-03', 'ribeiro@gmail.com', '53969182395','Notredame', '35612Y', 'Bico de Papagaio.');

/* CRIAÇÃO DA TABELA 2 */
CREATE TABLE Endereco(
idEndereco INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
logradouro VARCHAR (45) NOT NULL,
bairro VARCHAR (45) NOT NULL,
numero INT NOT NULL,
cidade VARCHAR (45) NOT NULL,
CEP VARCHAR (9) NOT NULL,
UF VARCHAR (2) NOT NULL,
idPaciente INT NOT NULL,
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente) ON DELETE CASCADE
);

/* INSERÇÃO DE DADOS DA TABELA 2 */
INSERT INTO Endereco (logradouro, bairro, numero, cidade, CEP, UF, idPaciente) VALUES 
('Rua Estocolmo', 'MACA', 191, 'Sao Paulo', '09780190', 'SP', 1),
('Rua Espanha', 'ZECADA', 175, 'Sao Paulo','09810001', 'SP', 2),
('Rua Madeira', 'TABUINA', 75, 'Rio de Janeiro','03276000', 'RJ', 3),
('Rua Italia', 'PIZZA', 81, 'Sao Paulo', '03157900', 'SP', 4), 
('Rua Brasil', 'JACA', 176, 'Sao Paulo', '04560150', 'SP', 5); 

/* CRIAÇÃO DA TABELA 3 */
CREATE TABLE Telefone(
idTelefone INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
numero VARCHAR (45) NOT NULL UNIQUE,
idPaciente INT NOT NULL,
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente) ON DELETE CASCADE
);

/* INSERÇÃO DE DADOS DA TABELA 3 */
INSERT INTO Telefone (numero, idPaciente) VALUES 
('5511978907645', 1), 
('5511965476781', 2),
('5511981103212', 3),
('5511958803755', 4),
('5511957703338', 5);

/* CRIAÇÃO DA TABELA 4 */
CREATE TABLE Fisioterapeuta(
idFisioterapeuta INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR (45) NOT NULL,
CRF VARCHAR (15) NOT NULL UNIQUE
);

/* INSERÇÃO DE DADOS DA TABELA 4 */
INSERT INTO Fisioterapeuta (nome, CRF) VALUES 
('Giovanna Costa', '088990.G'), 
('Caroliny Lex', '178900.C'),
('Andreia Oliveira', '656788.O'),
('Joao Pedro', '765900.Y'),
('Lucas Santos', '543210.R');

/* CRIAÇÃO DA TABELA 5 */
CREATE TABLE Atendente(
idAtendente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nome VARCHAR (45) NOT NULL
);

/* INSERÇÃO DE DADOS DA TABELA 5 */
INSERT INTO Atendente (nome) VALUES 
('Isabel Lourenco'),
('Gabriel Alves'), 
('Davi Silva'),
('Jose Matteus'),
('Aline Pinheiro');

/* CRIAÇÃO DA TABELA 6 */
CREATE TABLE Consultas(
idConsultas INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
data_consulta date not null,
hora TIME not null,
status_consulta VARCHAR(30) NOT NULL,
idPaciente INT NOT NULL,
idFisioterapeuta INT NOT NULL,
idAtendente INT NOT NULL,
FOREIGN KEY (idPaciente) REFERENCES Paciente(idPaciente) ON DELETE CASCADE,
FOREIGN KEY (idFisioterapeuta) REFERENCES Fisioterapeuta(idFisioterapeuta) ON DELETE CASCADE,
FOREIGN KEY (idAtendente) REFERENCES Atendente(idAtendente) ON DELETE CASCADE
);

/* INSERÇÃO DE DADOS DA TABELA 6 */
INSERT INTO Consultas (data_consulta, hora, status_consulta, idPaciente, idFisioterapeuta, idAtendente) VALUES 
('2025-05-05', '14:00:00', 'Agendado', 1, 1, 1),
('2025-09-15', '10:30:00', 'Cancelado', 2, 2, 2), 
('2025-04-10', '11:45:00', 'Concluido', 3, 3, 3),
('2025-05-05', '09:30:00', 'Cancelado', 4, 4, 4),
('2025-05-07', '09:30:00', 'Concluido', 5, 5, 5);

/* CRIAÇÃO DA TABELA 7 */
CREATE TABLE Vendas(
idVendas INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
meio_pagamento VARCHAR(45) NOT NULL,
valor DECIMAL (10,2) NOT NULL,
data_pagamento DATE NOT NULL,
idConsultas INT NOT NULL,
idAtendente INT NOT NULL,
FOREIGN KEY (idConsultas) REFERENCES Consultas(idConsultas) ON DELETE CASCADE,
FOREIGN KEY (idAtendente) REFERENCES Atendente(idAtendente) ON DELETE CASCADE
);

/* INSERÇÃO DE DADOS DA TABELA 7 */
INSERT INTO Vendas (meio_pagamento, valor, data_pagamento, idConsultas, idAtendente) VALUES
 ('CONVENIO', '350.00', '2025-05-04', 1, 1),
 ('CONVENIO',  '300.00', '2025-08-14', 2, 2),
 ('CONVENIO', '800.00', '2025-03-10', 3, 3),
 ('CONVENIO', '4500.00', '2025-07-08', 4, 4),
 ('CONVENIO',  '8000.00', '2025-09-14', 5, 5);

/* BUSCA E UPDATES DE DADOS TABELA 1*/
/*Update de email de paciente*/
UPDATE clinica_fisiovida.Paciente
SET email = 'Alex@gmail.com'
WHERE email = 'ribeiro@gmail.com';

SELECT * FROM Paciente;

SELECT * FROM Paciente WHERE data_nascimento < '2000-09-18';

/* BUSCA E UPDATES DE DADOS TABELA 2*/
/*Update de bairro de endereco*/
UPDATE clinica_fisiovida.Endereco
SET bairro = 'IANA'
WHERE bairro = 'ZECADA';

SELECT * FROM Endereco;

SELECT * FROM Endereco WHERE UF = 'SP';

/* BUSCA E UPDATES DE DADOS TABELA 3*/
/*Update de numero de telefone*/
UPDATE clinica_fisiovida.Telefone
SET numero = '5511960633737'
WHERE numero = '5511965476781';

SELECT * FROM Telefone;

SELECT * FROM Telefone WHERE numero = '5511957703338';

/* BUSCA E UPDATES DE DADOS TABELA 4*/
/*Update de CRF de Fisioterapeuta*/
UPDATE clinica_fisiovida.Fisioterapeuta
SET CRF = '55231.T'
WHERE CRF = '543210.R';

SELECT * FROM Fisioterapeuta;

SELECT * FROM Fisioterapeuta WHERE CRF = '765900.Y';

/* BUSCA E UPDATES DE DADOS TABELA 5*/
/*Update de nome de Atendente*/
UPDATE clinica_fisiovida.Atendente
SET nome = 'Nubia Silva'
WHERE nome = 'Gabriel Alves';

SELECT * FROM Atendente;

SELECT * FROM Atendente WHERE idAtendente = 2;

/* BUSCA E UPDATES DE DADOS TABELA 6*/
/*Update de nome de Atendente*/
UPDATE clinica_fisiovida.Consultas
SET hora = '10:00:00'
WHERE hora = '11:45:00';

SELECT * FROM Consultas;

SELECT * FROM Consultas WHERE status_consulta = 'Cancelado';

/* BUSCA E UPDATES DE DADOS TABELA 7*/
/*Update de data de pagamento da tabela venda*/
UPDATE clinica_fisiovida.Vendas
SET data_pagamento = '2025-08-17'
WHERE data_pagamento = '2025-09-14';

SELECT * FROM Vendas;
 
SELECT * FROM Vendas WHERE valor < '800.00';

/* EXCLUSÃO DE DADOS TABELA 2/*
/*EXCLUSÃO DE PACIENTE*/
DELETE FROM clinica_fisiovida.Paciente
WHERE idPaciente = 1;

/* EXCLUSÃO DE DADOS TABELA 2/*
/*Exclusão de endereco*/
DELETE FROM clinica_fisiovida.Endereco
WHERE idEndereco = 5;

/* EXCLUSÃO DE DADOS TABELA 3/*
/*Exclusão de numero*/
DELETE FROM clinica_fisiovida.Telefone
WHERE numero = '5511978907645';

/* EXCLUSÃO DE DADOS TABELA 4/*
/*Exclusão de Fisioterapeuta*/
DELETE FROM clinica_fisiovida.Fisioterapeuta
WHERE idFisioterapeuta = 1;

/* EXCLUSÃO DE DADOS TABELA 5 /*
/*Exclusão de atendente*/
DELETE FROM clinica_fisiovida.Atendente
WHERE nome = 'Isabel Lourenco';

/* EXCLUSÃO/BUSCA E UPDATES DE DADOS TABELA 6 /*
/*Exclusão de Consulta*/
DELETE FROM clinica_fisiovida.Consultas
WHERE idConsultas = 5;

/* EXCLUSÃO/BUSCA E UPDATES DE DADOS TABELA 6 /*
/*Exclusão de venda*/
DELETE FROM clinica_fisiovida.Vendas
WHERE valor = '4500.00';