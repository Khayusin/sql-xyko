/*
SQL do BDReservaPassagemIFSP
Data: 06/08/2025
*/

--------------------------------------
-- tabela Estado
CREATE TABLE "TBEstado" (
	"IDUF"	VARCHAR(2) NOT NULL,
	"NomeEstado"	VARCHAR(50),
	PRIMARY KEY("IDUF")
);

-- cadastrar registros
INSERT INTO TBEstado VALUES 
('SP','São Paulo'),
('RJ','Rio de Janeiro'),
('MG','Minas Gerais');

-- mostrar registros
SELECT * FROM TBEstado;

--------------------------------------
-- tabela Cidade
CREATE TABLE "TBCidade" (
	"IDCidade"	INT NOT NULL,
	"NomeCidade"	VARCHAR(50) NOT NULL,
	"CodUF"	VARCHAR(2) NOT NULL,
	FOREIGN KEY("CodUF") REFERENCES "TBEstado"("IDUF"),
	PRIMARY KEY("IDCidade")
);

-- cadastrar registros
INSERT INTO TBCidade VALUES 
(1, 'Barretos', 'SP'),
(2, 'Volta Redonda', 'RJ'),
(3, 'Fronteira', 'MG');

-- mostrar registros
SELECT * FROM TBCidade;

--------------------------------------
-- tabela Aeroporto
CREATE TABLE "TBAeroporto" (
	"IDAeroporto" INT NOT NULL,
	"NomeAeroporto" VARCHAR(50) NOT NULL,
	"CapacidadeDiariaPessoas" INT NOT NULL,
	"CapacidadeDiariaAeronaves" INT NOT NULL,
	"Endereco" VARCHAR(50) NOT NULL,
	"CEP" BIGINT NOT NULL,
	"Telefone" BIGINT NOT NULL,
	"Site" VARCHAR(50),
	"CodCidade" INT NOT NULL,
	PRIMARY KEY("IDAeroporto"),
	FOREIGN KEY("CodCidade") REFERENCES "TBCidade"("IDCidade")
);

-- cadastrar registros
INSERT INTO TBAeroporto VALUES
(1, 'Aeroporto de Barretos', 500, 50, 'Av. Aérea, 100', 14780000, 1733221100, 'www.aerobarretos.com', 1),
(2, 'Aeroporto VR', 1000, 80, 'Rua dos Voos, 200', 27275000, 2433557788, 'www.aerovr.com', 2),
(3, 'Aeroporto Fronteira', 300, 30, 'Praça Central, 50', 38240000, 3433261122, 'www.aerofronteira.com', 3);

-- mostrar registros
SELECT * FROM TBAeroporto;

--------------------------------------
-- tabela Fabricante
CREATE TABLE "TBFabricante" (
	"IDFabricante" INT NOT NULL,
	"NomeFabricante" VARCHAR(50) NOT NULL,
	"Telefone" BIGINT NOT NULL,
	"Email" VARCHAR(40),
	"Site" VARCHAR(50),
	PRIMARY KEY("IDFabricante")
);

-- cadastrar registros
INSERT INTO TBFabricante VALUES
(1, 'Embraer', 1122223344, 'contato@embraer.com', 'www.embraer.com'),
(2, 'Boeing', 1133334455, 'info@boeing.com', 'www.boeing.com'),
(3, 'Airbus', 1144445566, 'support@airbus.com', 'www.airbus.com');

-- mostrar registros
SELECT * FROM TBFabricante;

--------------------------------------
-- tabela TipoAeronave
CREATE TABLE "TBTipoAeronave" (
	"IDAeronave" INT NOT NULL,
	"DescricaoAeronave" VARCHAR(50) NOT NULL,
	"CapacidadePessoa" INT NOT NULL,
	"CapacidadeTripulacao" INT NOT NULL,
	"AutonomiaVoo" TIME NOT NULL,
	"CapacidadeTanque" BIGINT NOT NULL,
	"QtdAssento" INT NOT NULL,
	"Observacao" VARCHAR(100),
	"CodFabricante" INT NOT NULL,
	PRIMARY KEY("IDAeronave"),
	FOREIGN KEY("CodFabricante") REFERENCES "TBFabricante"("IDFabricante")
);

-- cadastrar registros
INSERT INTO TBTipoAeronave VALUES
(1, 'Embraer 195', 120, 6, '05:30:00', 15000, 120, 'Uso regional', 1),
(2, 'Boeing 737', 180, 8, '06:00:00', 20000, 180, 'Curto e médio alcance', 2),
(3, 'Airbus A320', 170, 8, '06:15:00', 21000, 170, 'Curto e médio alcance', 3);

-- mostrar registros
SELECT * FROM TBTipoAeronave;

--------------------------------------
-- tabela Voo
CREATE TABLE "TBVoo" (
	"IDVoo" INT NOT NULL,
	"DescricaoVoo" VARCHAR(50) NOT NULL,
	"ValorPassagem" DECIMAL(10,2) NOT NULL,
	"CondicoesMeteorologicas" VARCHAR(100),
	"Observacao" VARCHAR(100),
	PRIMARY KEY("IDVoo")
);

-- cadastrar registros
INSERT INTO TBVoo VALUES
(1, 'Voo SP-RJ', 350.00, 'Céu limpo', 'Sem atrasos'),
(2, 'Voo RJ-MG', 280.00, 'Parcialmente nublado', 'Possível turbulência'),
(3, 'Voo MG-SP', 300.00, 'Chuva leve', 'Pode atrasar');

-- mostrar registros
SELECT * FROM TBVoo;

--------------------------------------
-- tabela Horario
CREATE TABLE "TBHorario" (
	"IDHorario" INT NOT NULL,
	"Data" DATE NOT NULL,
	"Hora" TIME NOT NULL,
	"CodVoo" INT NOT NULL,
	PRIMARY KEY("IDHorario"),
	FOREIGN KEY("CodVoo") REFERENCES "TBVoo"("IDVoo")
);

-- cadastrar registros
INSERT INTO TBHorario VALUES
(1, '20/08/2025', '08:30:00', 1),
(2, '21/08/2025', '14:00:00', 2),
(3, '22/08/2025', '19:15:00', 3);

-- mostrar registros
SELECT * FROM TBHorario;

--------------------------------------
-- tabela Trecho
CREATE TABLE "TBTrecho" (
	"IDTrecho" INT NOT NULL,
	"NmeTrecho" VARCHAR(50) NOT NULL,
	"Custo" DECIMAL(10,2) NOT NULL,
	"TempoVoo" TIME NOT NULL,
	"Observacao" VARCHAR(100),
	"CodAeroportoDestino" INT NOT NULL,
	"CodAeroportoOrigem" INT NOT NULL,
	"CodVoo" INT NOT NULL,
	"TipoAeronave" INT NOT NULL,
	PRIMARY KEY("IDTrecho"),
	FOREIGN KEY("CodAeroportoDestino") REFERENCES "TBAeroporto"("IDAeroporto"),
	FOREIGN KEY("CodAeroportoOrigem") REFERENCES "TBAeroporto"("IDAeroporto"),
	FOREIGN KEY("CodVoo") REFERENCES "TBVoo"("IDVoo"),
	FOREIGN KEY("TipoAeronave") REFERENCES "TBTipoAeronave"("IDAeronave")
);

-- cadastrar registros
INSERT INTO TBTrecho VALUES
(1, 'SP para RJ', 150.00, '01:00:00', 'Trecho direto', 2, 1, 1, 1),
(2, 'RJ para MG', 120.00, '01:30:00', 'Trecho direto', 3, 2, 2, 2),
(3, 'MG para SP', 130.00, '01:45:00', 'Trecho direto', 1, 3, 3, 3);

-- mostrar registros
SELECT * FROM TBTrecho;

--------------------------------------
-- tabela Passageiro
CREATE TABLE "TBPassageiro" (
	"IDPassageiro" INT NOT NULL,
	"NomePassageiro" VARCHAR(50) NOT NULL,
	"DataNascimento" DATE NOT NULL,
	"Peso" INT NOT NULL,
	"CPF" BIGINT NOT NULL,
	"RG" VARCHAR(13) NOT NULL,
	"CodCidade" INT NOT NULL,
	PRIMARY KEY("IDPassageiro"),
	FOREIGN KEY("CodCidade") REFERENCES "TBCidade"("IDCidade")
);

-- cadastrar registros
INSERT INTO TBPassageiro VALUES
(1, 'Carlos Silva', '10/05/1985', 80, 12345678901, 'MG123456', 3),
(2, 'Maria Oliveira', '15/08/1990', 65, 98765432100, 'RJ654321', 2),
(3, 'João Pereira', '20/11/1978', 90, 45678912377, 'SP789123', 1);

-- mostrar registros
SELECT * FROM TBPassageiro;

--------------------------------------
-- tabela Reserva
CREATE TABLE "TBReserva" (
	"IDReserva" INT NOT NULL,
	"DataHora" DATETIME NOT NULL,
	"DataHoraValidade" DATETIME NOT NULL,
	PRIMARY KEY("IDReserva")
);

-- cadastrar registros
INSERT INTO TBReserva VALUES
(1, '10/08/2025 10:00:00', '15/08/2025 23:59:59'),
(2, '11/08/2025 14:30:00', '16/08/2025 23:59:59'),
(3, '12/08/2025 09:45:00', '17/08/2025 23:59:59');

-- mostrar registros
SELECT * FROM TBReserva;

--------------------------------------
-- tabela Assento
CREATE TABLE "TBAssento" (
	"IDAssento" INT NOT NULL,
	"DescricaoAssento" VARCHAR(50) NOT NULL,
	"ValorAssento" DECIMAL(10,2) NOT NULL,
	"CodTipoAeronave" INT NOT NULL,
	PRIMARY KEY("IDAssento"),
	FOREIGN KEY("CodTipoAeronave") REFERENCES "TBTipoAeronave"("IDAeronave")
);

-- cadastrar registros
INSERT INTO TBAssento VALUES
(1, 'Janela', 50.00, 1),
(2, 'Corredor', 40.00, 2),
(3, 'Saída de emergência', 60.00, 3);

-- mostrar registros
SELECT * FROM TBAssento;

--------------------------------------
-- tabela Passagem
CREATE TABLE "TBPassagem" (
	"CodTrecho" INT NOT NULL,
	"CodReserva" INT NOT NULL,
	"CodPassageiro" INT NOT NULL,
	"CodAssento" INT NOT NULL,
	"DataValidadeReserva" DATE NOT NULL,
	"Valor" DECIMAL(10,2) NOT NULL,
	PRIMARY KEY("CodTrecho", "CodReserva", "CodPassageiro", "CodAssento"),
	FOREIGN KEY("CodTrecho") REFERENCES "TBTrecho"("IDTrecho"),
	FOREIGN KEY("CodReserva") REFERENCES "TBReserva"("IDReserva"),
	FOREIGN KEY("CodPassageiro") REFERENCES "TBPassageiro"("IDPassageiro"),
	FOREIGN KEY("CodAssento") REFERENCES "TBAssento"("IDAssento")
);

-- cadastrar registros
INSERT INTO TBPassagem VALUES
(1, 1, 1, 1, '15/08/2025', 400.00),
(2, 2, 2, 2, '16/08/2025', 320.00),
(3, 3, 3, 3, '17/08/2025', 360.00);

-- mostrar registros
SELECT * FROM TBPassagem;
