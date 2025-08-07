/*
Banco de Dados: BDTeste2IFSP
Data: 06/08/2025
*/

--------------------------------------
-- TABELA: Estado
CREATE TABLE "TBEstado" (
	"IDUF" varchar(2) NOT NULL,
	"NomeEstado" varchar(50) NOT NULL,
	PRIMARY KEY("IDUF")
);

-- TB Estados
INSERT INTO TBEstado VALUES 
('SP','São Paulo'),
('MG','Minas Gerais');

-- Verificar estados
SELECT * FROM TBEstado;

--------------------------------------
-- TABELA: Cidade
CREATE TABLE "TBCidade" (
	"IDCidade" int NOT NULL,
	"NomeCidade" varchar(50) NOT NULL,
	"CodUF" varchar(2) NOT NULL,
	PRIMARY KEY("IDCidade"),
	FOREIGN KEY("CodUF") REFERENCES "TBEstado"("IDUF")
);

-- TB Cidades
INSERT INTO TBCidade VALUES 
(1, 'Barretos', 'SP'),
(2, 'Fronteira', 'MG');

-- Verificar cidades
SELECT * FROM TBCidade;

--------------------------------------
-- TABELA: Departamento
CREATE TABLE "TBDepartamento" (
	"IDDepartamento" int NOT NULL,
	"NomeDepartamento" varchar(50) NOT NULL,
	"OrcamentoDepartamento" decimal(10,2) NOT NULL,
	PRIMARY KEY("IDDepartamento")
);

-- TB Departamentos
INSERT INTO TBDepartamento VALUES 
(1, 'Nuclear', 1000000.00),
(2, 'Militar', 1000000.00);

-- Verificar departamentos
SELECT * FROM TBDepartamento;

--------------------------------------
-- TABELA: Funcionario
CREATE TABLE "TBFuncionario" (
	"IDFuncionario"	int NOT NULL,
	"NomeFuncionario"	int NOT NULL,
	"Telefone"	int NOT NULL,
	"CPF"	int NOT NULL,
	"RG"	int NOT NULL,
	"Email"	varchar(30) NOT NULL,
	"DataAdmissao"	TEXT NOT NULL,
	"Endereco"	Vachar NOT NULL,
	"Numero"	int NOT NULL,
	"Bairro"	varchar(50) NOT NULL,
	"CodDepartamento"	int NOT NULL,
	"CodCidade"	IntEGER NOT NULL,
	PRIMARY KEY("IDFuncionario"),
	FOREIGN KEY("CodCidade") REFERENCES "TBCidade"("IDCidade"),
	FOREIGN KEY("CodDepartamento") REFERENCES "TBDepartamento"("IDDepartamento")
);

-- TBFuncionario
INSERT INTO TBFuncionario VALUES 
(1, 'Ana Clara Souza', 179999999, 12345678900, 11223344, 'ana.souza@ifsp.edu.br', '2020-01-15', 'Rua das Rosas', 101, 'Centro', 1, 1),
(2, 'João Marcos Lima', 189888888, 98765432100, 55667788, 'joao.lima@ifsp.edu.br', '2021-03-20', 'Avenida Brasil', 202, 'Vila Nova', 2, 2);
--

-- Verificar funcionários
SELECT * FROM TBFuncionario;

--------------------------------------
-- TABELA: Equipamento
CREATE TABLE "TBEQUIPAMENTO" (
	"IDEquipamento" int NOT NULL,
	"NomeEquipamento" varchar(50) NOT NULL,
	"DataCompra" date NOT NULL,
	"ValorCompra" decimal(10,2) NOT NULL,
	"EstadoEquipamento" varchar(200) NOT NULL,
	"RequisitosSeguranca" varchar(200),
	PRIMARY KEY("IDEquipamento")
);

-- TBEQUIPAMENTO
INSERT INTO TBEQUIPAMENTO VALUES 
(1, 'Computador HP ZBook', '01/05/2022', 15000.00, 'Funcionando', 'Uso exclusivo em laboratório restrito'),
(2, 'Impressora 3D Ender', '01/10/2022', 5000.00, 'Necessita manutenção', 'Manuseio com luvas');

-- Verificar equipamentos
SELECT * FROM TBEQUIPAMENTO;

--------------------------------------
-- TABELA: Projeto
CREATE TABLE "TBProjeto" (
	"IDProjeto" int NOT NULL,
	"DescricaoProjeto" varchar(200) NOT NULL,
	"DataInicioProjeto" date NOT NULL,
	"DataFimProjeto" date NOT NULL,
	"CustoGeralProjeto" decimal(10,2) NOT NULL,
	"CodDeptoResponsavel" int NOT NULL,
	PRIMARY KEY("IDProjeto"),
	FOREIGN KEY("CodDeptoResponsavel") REFERENCES "TBDepartamento"("IDDepartamento")
);

-- TBProjeto
INSERT INTO TBProjeto VALUES 
(1, 'Sistema de Monitoramento Nuclear', '2022-07-01', '2023-07-01', 200000.00, 1),
(2, 'Projeto de Segurança Militar Autônoma', '2023-08-01', '2024-08-01', 300000.00, 2);

-- Verificar projetos
SELECT * FROM TBProjeto;

--------------------------------------
-- TABELA: FuncionarioProjeto 
CREATE TABLE "TBFUNCIONARIOPROJETO" (
	"CodFuncionario" int NOT NULL,
	"CodProjeto" int NOT NULL,
	"CodEquipamento" int NOT NULL,
	"DataInicio" date NOT NULL,
	"DataFim" date NOT NULL,
	"Custo" decimal(10,2),
	PRIMARY KEY("CodFuncionario", "CodProjeto", "CodEquipamento"),
	FOREIGN KEY("CodFuncionario") REFERENCES "TBFuncionario"("IDFuncionario"),
	FOREIGN KEY("CodProjeto") REFERENCES "TBProjeto"("IDProjeto"),
	FOREIGN KEY("CodEquipamento") REFERENCES "TBEQUIPAMENTO"("IDEquipamento")
);

-- TBFUNCIONARIOPROJETO
-- padrao data: ''
INSERT INTO TBFUNCIONARIOPROJETO VALUES 
(1, 1, 1, '07/01/2021', '07/01/2023', 15000.00),
(2, 2, 2, '01/08/2003', '01/08/2023', 5000.00);

-- Verificar os vínculos entre funcionário, projeto e equipamento
SELECT * FROM TBFUNCIONARIOPROJETO;