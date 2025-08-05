/* Lógico_2: */

-- Table for Functions
CREATE TABLE TBFuncao (
    IDFuncao INT PRIMARY KEY,
    DescricaoFuncao VARCHAR(100),
    Observacao VARCHAR(MAX)
);

-- Table for Situations (General)
CREATE TABLE TBSituacao (
    IDSituacao INT PRIMARY KEY,
    DescricaoSituacao VARCHAR(200),
    Observacao VARCHAR(MAX)
);

-- Table for Employees
CREATE TABLE TBFuncionario (
    COdFuncionario INT PRIMARY KEY,
    DataNascimento DATE,
    DataAdmissao DATE,
    Sexo VARCHAR(1),
    CodFuncao INT,
    CodSituacao INT
);

-- Table for Production of Pieces
CREATE TABLE TBProducaoPeca (
    CodFuncionario INT,
    CodFabricante INT,
    CodProjeto INT,
    CodPeca INT,
    DataInicio DATE,
    DataFim DATE,
    CustoDiario DECIMAL(10,2),
    TempoUsado TIME,
    Quantidade INT,
    PRIMARY KEY (CodFuncionario, CodFabricante, CodProjeto, CodPeca)
);

-- Table for Manufacturer's Piece Production
CREATE TABLE TBFabricantePeca (
    CodFabricante INT,
    CodProjeto INT,
    CodPeca INT,
    DataInicio DATE,
    DataFim DATE,
    TempoGastoFabricacao TIME,
    CustoFabricacao DECIMAL(10,2),
    PRIMARY KEY (CodFabricante, CodProjeto, CodPeca)
);

-- Table for Manufacturers
CREATE TABLE TBFabricante (
    CodFabricante INT PRIMARY KEY,
    CNPJ VARCHAR(15),
    InscricaoEstadual VARCHAR(12),
    Observacao VARCHAR(MAX),
    CodCidade INT,
    IDPessoa INT -- Added to link to TBPessoa if a manufacturer is also a person
);

-- Table for Persons
CREATE TABLE TBPessoa (
    IDPessoa INT PRIMARY KEY,
    NomePessoa VARCHAR(50),
    Endereco VARCHAR(50),
    Bairro VARCHAR(50),
    Numero INT,
    Cep VARCHAR(12),
    CodCidade INT
);

-- Table for Cities
CREATE TABLE TBCidade (
    IDCidade INT PRIMARY KEY,
    NomeCidade VARCHAR(50),
    CodUF VARCHAR(2)
);

-- Table for Pieces
CREATE TABLE TBPeca (
    IDPeca INT PRIMARY KEY,
    DescricaoPeca VARCHAR(MAX),
    ComposicaoPeca VARCHAR(MAX),
    CustoPeca DECIMAL(10,2), -- Assuming a standard decimal format
    TempoProducao TIME,
    Observacao VARCHAR(MAX),
    CodSituacao INT
);

-- Table for Piece Situations
CREATE TABLE TBSituacaoPeca (
    IdSituacao INT PRIMARY KEY,
    Descricao VARCHAR(MAX),
    DataSituacao DATE,
    Observacao VARCHAR(MAX)
);

-- Table for States
CREATE TABLE TBEstado (
    IDUF VARCHAR(2) PRIMARY KEY,
    NomeEstado VARCHAR(50)
);

-- Table for Engineers
CREATE TABLE TBEngenheiro (
    CodEngenheiro INT PRIMARY KEY,
    NumeroCrea INT,
    CPF BIGINT,
    RG VARCHAR(12),
    DataNascimento DATE,
    DataFormacao DATE,
    Sexo VARCHAR(1),
    CodCidade INT
);

-- Table for Projects
CREATE TABLE TBProjeto (
    IdProjeto INT PRIMARY KEY,
    DescricaoProjeto VARCHAR(MAX),
    DataProjeto DATE,
    CustoProjeto DECIMAL(10,2),
    Observacao VARCHAR(MAX),
    CodEngenheiro INT
);

-- Table for Project Pieces (linking projects to pieces)
CREATE TABLE TBProjetoPeca (
    CodProjeto INT,
    CodPeca INT,
    DataInicio DATE,
    DataFim DATE,
    CustoProjeto DECIMAL(10,2), -- Corrected decimal precision and scale
    Observacao VARCHAR(MAX),
    PRIMARY KEY (CodProjeto, CodPeca)
);

-- Foreign Key Constraints

-- TBFuncionario
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_Funcao
    FOREIGN KEY (CodFuncao)
    REFERENCES TBFuncao (IDFuncao);

ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_Situacao
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacao (IDSituacao);

-- TBProducaoPeca
ALTER TABLE TBProducaoPeca ADD CONSTRAINT FK_TBProducaoPeca_Funcionario
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (COdFuncionario);

ALTER TABLE TBProducaoPeca ADD CONSTRAINT FK_TBProducaoPeca_FabricantePeca
    FOREIGN KEY (CodFabricante, CodProjeto, CodPeca)
    REFERENCES TBFabricantePeca (CodFabricante, CodProjeto, CodPeca);

-- TBFabricantePeca
ALTER TABLE TBFabricantePeca ADD CONSTRAINT FK_TBFabricantePeca_Fabricante
    FOREIGN KEY (CodFabricante)
    REFERENCES TBFabricante (CodFabricante);

ALTER TABLE TBFabricantePeca ADD CONSTRAINT FK_TBFabricantePeca_ProjetoPeca
    FOREIGN KEY (CodProjeto, CodPeca) -- Corrected missing column
    REFERENCES TBProjetoPeca (CodProjeto, CodPeca);

-- TBFabricante
ALTER TABLE TBFabricante ADD CONSTRAINT FK_TBFabricante_Cidade
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);

ALTER TABLE TBFabricante ADD CONSTRAINT FK_TBFabricante_Pessoa -- New FK for linking to TBPessoa
    FOREIGN KEY (IDPessoa)
    REFERENCES TBPessoa (IDPessoa);

-- TBPessoa
ALTER TABLE TBPessoa ADD CONSTRAINT FK_TBPessoa_Cidade
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);

-- TBCidade
ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_Estado
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);

-- TBPeca
ALTER TABLE TBPeca ADD CONSTRAINT FK_TBPeca_SituacaoPeca
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacaoPeca (IdSituacao);

-- TBEngenheiro
ALTER TABLE TBEngenheiro ADD CONSTRAINT FK_TBEngenheiro_Cidade
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);

-- TBProjeto
ALTER TABLE TBProjeto ADD CONSTRAINT FK_TBProjeto_Engenheiro
    FOREIGN KEY (CodEngenheiro)
    REFERENCES TBEngenheiro (CodEngenheiro);

-- TBProjetoPeca
ALTER TABLE TBProjetoPeca ADD CONSTRAINT FK_TBProjetoPeca_Peca
    FOREIGN KEY (CodPeca)
    REFERENCES TBPeca (IDPeca);

ALTER TABLE TBProjetoPeca ADD CONSTRAINT FK_TBProjetoPeca_Projeto
    FOREIGN KEY (CodProjeto)
    REFERENCES TBProjeto (IdProjeto);

