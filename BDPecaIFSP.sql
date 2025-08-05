/* Lógico_2: */

CREATE TABLE TBFuncao (
    IDFuncao int PRIMARY KEY,
    DescricaoFuncao varchar(100),
    Observacao varchar(max)
);

CREATE TABLE TBSituacao (
    IDSituacao int PRIMARY KEY,
    DescricaoSituacao Varchar(200),
    Observacao varchar(max)
);

CREATE TABLE TBFuncionario (
    COdFuncionario int PRIMARY KEY,
    DataNascimento Date,
    DataAdmissao DAte,
    Sexo varchar(1),
    CodFuncao int,
    CodSituacao int
);

CREATE TABLE TBProducaoPeca (
    CodFuncionario int,
    CodFabricante int,
    CodProjeto int,
    CodPeca int,
    DataInicio Date,
    DataFim date,
    CustoDiario decimal(10,2),
    TempoUsado Time,
    Quantidade int,
    PRIMARY KEY (CodFuncionario, CodFabricante, CodProjeto, CodPeca)
);

CREATE TABLE TBFabricantePeca (
    CodFabricante int,
    CodProjeto int,
    CodPeca int,
    DataInicio Date,
    DataFim Date,
    TempoGastoFabricacao time,
    CustoFabricacao decimal(10,2),
    PRIMARY KEY (CodFabricante, CodProjeto, CodPeca)
);

CREATE TABLE TBFabricante (
    CodFabricante int PRIMARY KEY,
    CNPJ varchar(15),
    InscricaoEstadual varchar(12),
    Observacao varchar(max),
    CodCidade int
);

CREATE TABLE TBPessoa (
    IDPessoa int PRIMARY KEY,
    NomePessoa varchar(50),
    Endereco varchar(50),
    Bairro varchar(50),
    Numero int,
    Cep varchar(12),
    CodCidade int
);

CREATE TABLE TBCidade (
    IDCidade int PRIMARY KEY,
    NomeCidade Varchar(50),
    CodUF varchar(2)
);

CREATE TABLE TBPeca (
    IDPeca int PRIMARY KEY,
    DescricaoPeca Varchar(max),
    ComposicaoPeca varchar(max),
    CustoPeca decimal,
    TempoProducao time,
    Observacao varchar(max),
    CodSituacao int
);

CREATE TABLE TBSituacaoPeca (
    IdSituacao int PRIMARY KEY,
    Descricao varchar(max),
    DataSituacao Date,
    Observacao varchar(max)
);

CREATE TABLE TBEstado (
    IDUF varchar(2) PRIMARY KEY,
    NomeEstado varchar(50)
);

CREATE TABLE TBEngenheiro (
    CodEngenheiro int PRIMARY KEY,
    NumeroCrea int,
    CPF bigint,
    RG varchar(12),
    DataNascimento Date,
    DataFormacao Date,
    Sexo varchar(1),
    CodCidade int
);

CREATE TABLE TBProjeto (
    IdProjeto int PRIMARY KEY,
    DescricaoProjeto varchar(max),
    DataProjeto Date,
    CustoProjeto decimal(10,2),
    Observacao varchar(max),
    CodEngenheiro int
);

CREATE TABLE TBProjetoPeca (
    CodProjeto int,
    CodPeca int,
    DataInicio Date,
    DataFim Date,
    CustoProjeto decimal(10,20,
    Observacao Varchar(max),
    PRIMARY KEY (CodProjeto, CodPeca)
);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_2
    FOREIGN KEY (CodFuncao)
    REFERENCES TBFuncao (IDFuncao);
 
ALTER TABLE TBFuncionario ADD CONSTRAINT FK_TBFuncionario_3
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacao (IDSituacao);
 
ALTER TABLE TBProducaoPeca ADD CONSTRAINT FK_TBProducaoPeca_2
    FOREIGN KEY (CodFuncionario)
    REFERENCES TBFuncionario (COdFuncionario);
 
ALTER TABLE TBProducaoPeca ADD CONSTRAINT FK_TBProducaoPeca_3
    FOREIGN KEY (CodFabricante, CodProjeto, CodPeca)
    REFERENCES TBFabricantePeca (CodFabricante, CodProjeto, CodPeca);
 
ALTER TABLE TBFabricantePeca ADD CONSTRAINT FK_TBFabricantePeca_2
    FOREIGN KEY (CodFabricante)
    REFERENCES TBFabricante (CodFabricante);
 
ALTER TABLE TBFabricantePeca ADD CONSTRAINT FK_TBFabricantePeca_3
    FOREIGN KEY (CodProjeto, ???)
    REFERENCES TBProjetoPeca (CodProjeto, ???);
 
ALTER TABLE TBFabricante ADD CONSTRAINT FK_TBFabricante_2
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBPessoa ADD CONSTRAINT FK_TBPessoa_2
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBPessoa ADD CONSTRAINT FK_TBPessoa_3
    FOREIGN KEY (IDPessoa)
    REFERENCES TBFabricante (CodFabricante);
 
ALTER TABLE TBCidade ADD CONSTRAINT FK_TBCidade_2
    FOREIGN KEY (CodUF)
    REFERENCES TBEstado (IDUF);
 
ALTER TABLE TBPeca ADD CONSTRAINT FK_TBPeca_2
    FOREIGN KEY (CodSituacao)
    REFERENCES TBSituacaoPeca (IdSituacao);
 
ALTER TABLE TBEngenheiro ADD CONSTRAINT FK_TBEngenheiro_2
    FOREIGN KEY (CodCidade)
    REFERENCES TBCidade (IDCidade);
 
ALTER TABLE TBProjeto ADD CONSTRAINT FK_TBProjeto_2
    FOREIGN KEY (CodEngenheiro)
    REFERENCES TBEngenheiro (CodEngenheiro);
 
ALTER TABLE TBProjetoPeca ADD CONSTRAINT FK_TBProjetoPeca_2
    FOREIGN KEY (CodPeca)
    REFERENCES TBPeca (IDPeca);
 
ALTER TABLE TBProjetoPeca ADD CONSTRAINT FK_TBProjetoPeca_3
    FOREIGN KEY (CodProjeto)
    REFERENCES TBProjeto (IdProjeto);