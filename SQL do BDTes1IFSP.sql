/*
SQL do BDTeste1IFSP
Data: 06/08/2025
*/
--------------------------------------
-- tabela estado
CREATE TABLE "TBEstado" (
	"IDUF"	varchar(2) NOT NULL,
	"NomeEstado"	varchar(50) NOT NULL,
	PRIMARY KEY("IDUF")
);
-----------------------------------
-- cadastrar registros
iNSERT INTO TBEstado VALUES 
('SP','São Paulo'),
('MG','Minas Gerais');
---------------------------
-- mostrasr os registros
Select  *  from TBEstado;
------------------------------

--------------------------------
--  tabela cidade
CREATE TABLE "TBCidade" (
	"IDCidade"	INT NOT NULL,
	"NomeCidade"	varchar(50) NOT NULL,
	"CodUF"	varchar(2) NOT NULL,
	PRIMARY KEY("IDCidade"),
	FOREIGN KEY("CodUF") REFERENCES "TBEstado"("IDUF")
);
------------------
-- cadastro de cidades
INSERT INTO  TBCidade VALUES 
(1, 'Barretos', 'SP'),
(2, 'Fronteira', 'MG');
------------------------------------
-- mostrar os registros
Select  *  from TBCidade ;
-----------------------------------
-- tabela motoristas
CREATE TABLE "TBMotorista" (
	"IDMotorista"	int NOT NULL,
	"NomeMotorista"	varchar(50) NOT NULL,
	"Endereco"	varchar(50) NOT NULL,
	"Numero"	int NOT NULL,
	"Bairro"	int NOT NULL,
	"CEP"	int NOT NULL,
	"CodCidade"	int NOT NULL,
	PRIMARY KEY("IDMotorista"),
	FOREIGN KEY("CodCidade") REFERENCES "TBCidade"("IDCidade")
);
-------------------------------------
-- Cadastrar motorista
INSERT INTO  TBMotorista VALUES 
(1, 'José Maria', 'Rua Capivara', 17, 31, 12030530, 1 ),
(2, 'Maria José', 'Rua Anta', 22, 4, 38230000, 2);
-------------------------------------
-- mostrar os registros
Select  *  from TBMotorista;
-------------------------------------
-- tabela empresa
CREATE TABLE "TBEmpresa" (
	"IDEmpresa"	int  NOT NULL,
	"NomeEmpresa"	varchar(50) NOT NULL,
	"Telefone"	int  NOT NULL,
	"CodCidade"	int  NOT NULL,
	PRIMARY KEY("IDEmpresa"),
	FOREIGN KEY("CodCidade") REFERENCES "TBCidade"("IDCidade")
);
--------------------------------------
--Cadastrar empresa
INSERT INTO  TBEmpresa VALUES 
(1, 'Localiza', 17988667755, 1),
(2, 'Agrotrek', 17911332244, 2);
--------------------------------------
-- Mostrar os registros
Select  *  from TBEmpresa;
--------------------------------------
-- tabela carro
CREATE TABLE "TBCarro" (
	"IDPlaca"	varchar(7) NOT NULL,
	"Marca"	varchar(50) NOT NULL,
	"Modelo"	varchar(50) NOT NULL,
	"CodEmpresa"	int ,
	PRIMARY KEY("IDPlaca"),
	FOREIGN KEY("CodEmpresa") REFERENCES "TBEmpresa"("IDEmpresa")
);
--------------------------------------
--Cadastrar empresa
INSERT INTO  TBCarro VALUES 
('BRT7777', 'Volvo', 'XC60', 1),
('AVC6666', 'SCANIA', 'Scania R 730', 2);
--------------------------------------
-- Mostrar os registros
Select  *  from TBCarro;
--------------------------------------
-- tabela MotoristaCarro
CREATE TABLE "TBMotoristaCarro" (
	"CodMotorista"	int NOT NULL,
	"CodPlaca"	int NOT NULL,
	"DataUso"	datetime NOT NULL,
	"KMInicial"	int NOT NULL,
	"KMFinal"	int NOT NULL,
	"AtividadesRealizadas"	varchar(300) NOT NULL,
	PRIMARY KEY("CodMotorista","CodPlaca"),
	FOREIGN KEY("CodMotorista") REFERENCES "TBMotorista"("IDMotorista"),
	FOREIGN KEY("CodPlaca") REFERENCES "TBCarro"("IDPlaca")
);
--------------------------------------
--Cadastrar MotoristaCarro
-- data: 'dd/mm/aaaa'
-- '15/11/2024'
INSERT INTO TBMotoristaCarro VALUES 
(1,'BRT7777','15/11/2024', 2, 3, 'Levou madeira até em Tupi' ),
(2,'AVC6666','15/11/2024', 3, 2, 'Levou ferro até em Juá' );
--------------------------------------
-- Mostrar os registros
Select  *  from TBMotoristaCarro;
