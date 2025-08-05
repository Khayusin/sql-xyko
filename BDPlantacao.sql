/* Lógico_1: */

CREATE TABLE TBFabricante (
    IDFabricante int PRIMARY KEY,
    NomeFabricante: varchar(50),
    Telefone bigint,
    email varchar(30),
    site varchar(50)
);

CREATE TABLE TBSemente (
    IDSemente int PRIMARY KEY,
    NomeSemente varchar(50),
    DataFabricacao date,
    DataValidade date,
    CustoSemente decimal(10,2),
    UnidadeSemente varchar(40),
    Observacao varchar(max),
    CodFabricante int
);

CREATE TABLE TBCanteiro (
    IDCanteiro int PRIMARY KEY,
    NomeCanteiro varchar(50),
    LuzDiaria decimal(5,2),
    AguaDiaria decimal(5,2),
    Observacao int,
    CodResponsavel int
);

CREATE TABLE TBFuncionario (
    IDFuncionario int PRIMARY KEY,
    NomeFuncionario Varchar(50),
    DataNascimento Date,
    Sexo Varchar(1),
    observacao varchar(max)
);

CREATE TABLE TBPlanta (
    IDPlanta int PRIMARY KEY,
    NomePlanta varchar(50),
    Caracteristica varchar(max),
    LuzDiaria decimal(5,2),
    Agua decimal(5,2),
    Peso decimal(5,2),
    Observacao varchar(max)
);

CREATE TABLE TBColheita (
    IDColheita int PRIMARY KEY,
    DataColheita date,
    Quantidade int,
    Peso decimal(6,2),
    CodFuncionario int,
    CodPlantio int
);

CREATE TABLE TBPlantio (
    IDPlantio int PRIMARY KEY,
    CodPlanta int,
    CodFuncionario int,
    CodCanteiro int,
    Data date,
    CodSemente int
);
 
ALTER TABLE TBSemente ADD CONSTRAINT FK_TBSemente_2
    FOREIGN KEY (CodFabricante)
    REFERENCES TBFabricante (IDFabricante);
 
ALTER TABLE TBCanteiro ADD CONSTRAINT FK_TBCanteiro_2
    FOREIGN KEY (CodResponsavel)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBColheita ADD CONSTRAINT FK_TBColheita_2
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBColheita ADD CONSTRAINT FK_TBColheita_3
    FOREIGN KEY (CodPlantio)
    REFERENCES TBPlantio (IDPlantio);
 
ALTER TABLE TBPlantio ADD CONSTRAINT FK_TBPlantio_2
    FOREIGN KEY (CodPlanta)
    REFERENCES TBPlanta (IDPlanta);
 
ALTER TABLE TBPlantio ADD CONSTRAINT FK_TBPlantio_3
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (IDFuncionario);
 
ALTER TABLE TBPlantio ADD CONSTRAINT FK_TBPlantio_4
    FOREIGN KEY (CodCanteiro)
    REFERENCES TBCanteiro (IDCanteiro);
 
ALTER TABLE TBPlantio ADD CONSTRAINT FK_TBPlantio_5
    FOREIGN KEY (CodSemente)
    REFERENCES TBSemente (IDSemente);