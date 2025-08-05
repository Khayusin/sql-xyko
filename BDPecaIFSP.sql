/* Lógico_2: */

CREATE TABLE TBFuncao (
    IDFuncao INT PRIMARY KEY,
    DescricaoFuncao VARCHAR(100),
    Observacao VARCHAR(MAX)
);

CREATE TABLE TBSituacao (
    IDSituacao INT PRIMARY KEY,
    DescricaoSituacao VARCHAR(200),
    Observacao VARCHAR(MAX)
);

CREATE TABLE TBFuncionario (
    COdFuncionario INT PRIMARY KEY,
    DataNascimento DATE,
    DataAdmissao DATE,
    Sexo VARCHAR(1),
    CodFuncao INT,
    CodSituacao INT
);

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

CREATE TABLE TBFabricante (
    CodFabricante INT PRIMARY KEY,
    CNPJ VARCHAR(15),
    InscricaoEstadual VARCHAR(12),
    Observacao VARCHAR(MAX),
    CodCidade INT,
    IDPessoa INT
);

CREATE TABLE TBPessoa (
    IDPessoa INT PRIMARY KEY,
    NomePessoa VARCHAR(50),
    Endereco VARCHAR(50),
    Bairro VARCHAR(50),
    Numero INT,
    Cep VARCHAR(12),
    CodCidade INT
);

CREATE TABLE TBCidade (
    IDCidade INT PRIMARY KEY,
    NomeCidade VARCHAR(50),
    CodUF VARCHAR(2)
);

CREATE TABLE TBPeca (
    IDPeca INT PRIMARY KEY,
    DescricaoPeca VARCHAR(MAX),
    ComposicaoPeca VARCHAR(MAX),
    CustoPeca DECIMAL(10,2),
    TempoProducao TIME,
    Observacao VARCHAR(MAX),
    CodSituacao INT
);

CREATE TABLE TBSituacaoPeca (
    IdSituacao INT PRIMARY KEY,
    Descricao VARCHAR(MAX),
    DataSituacao DATE,
    Observacao VARCHAR(MAX)
);

CREATE TABLE TBEstado (
    IDUF VARCHAR(2) PRIMARY KEY,
    NomeEstado VARCHAR(50)
);

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

CREATE TABLE TBProjeto (
    IdProjeto INT PRIMARY KEY,
    DescricaoProjeto VARCHAR(MAX),
    DataProjeto DATE,
    CustoProjeto DECIMAL(10,2),
    Observacao VARCHAR(MAX),
    CodEngenheiro INT
);

CREATE TABLE TBProjetoPeca (
    CodProjeto INT,
    CodPeca INT,
    DataInicio DATE,
    DataFim DATE,
    CustoProjeto DECIMAL(10,2),
    Observacao VARCHAR(MAX),
    PRIMARY KEY (CodProjeto, CodPeca)
);

ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_Funcao
    FOREIGN KEY (CodFuncao)
    REFERENCES TBFuncao (IDFuncao);

ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_Situacao
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacao (IDSituacao);

ALTER TABLE TBProducaoPeca ADD CONSTRAINT FK_TBProducaoPeca_Funcionario
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (COdFuncionario);

ALTER TABLE TBProducaoPeca ADD CONSTRAINT FK_TBProducaoPeca_FabricantePeca
    FOREIGN KEY (CodFabricante, CodProjeto, CodPeca)
    REFERENCES TBFabricantePeca (CodFabricante, CodProjeto, CodPeca);

ALTER TABLE TBFabricantePeca ADD CONSTRAINT FK_TBFabricantePeca_Fabricante
    FOREIGN KEY (CodFabricante)
    REFERENCES TBFabricante (CodFabricante);

ALTER TABLE TBFabricantePeca ADD CONSTRAINT FK_TBFabricantePeca_ProjetoPeca
    FOREIGN KEY (CodProjeto, CodPeca) -- Corrected missing column
    REFERENCES TBProjetoPeca (CodProjeto, CodPeca);

ALTER TABLE TBFabricante ADD CONSTRAINT FK_TBFabricante_Cidade
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);

ALTER TABLE TBFabricante ADD CONSTRAINT FK_TBFabricante_Pessoa -- New FK for linking to TBPessoa
    FOREIGN KEY (IDPessoa)
    REFERENCES TBPessoa (IDPessoa);

ALTER TABLE TBPessoa ADD CONSTRAINT FK_TBPessoa_Cidade
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);

ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_Estado
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);

ALTER TABLE TBPeca ADD CONSTRAINT FK_TBPeca_SituacaoPeca
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacaoPeca (IdSituacao);

ALTER TABLE TBEngenheiro ADD CONSTRAINT FK_TBEngenheiro_Cidade
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);

ALTER TABLE TBProjeto ADD CONSTRAINT FK_TBProjeto_Engenheiro
    FOREIGN KEY (CodEngenheiro)
    REFERENCES TBEngenheiro (CodEngenheiro);

ALTER TABLE TBProjetoPeca ADD CONSTRAINT FK_TBProjetoPeca_Peca
    FOREIGN KEY (CodPeca)
    REFERENCES TBPeca (IDPeca);

ALTER TABLE TBProjetoPeca ADD CONSTRAINT FK_TBProjetoPeca_Projeto
    FOREIGN KEY (CodProjeto)
    REFERENCES TBProjeto (IdProjeto);
