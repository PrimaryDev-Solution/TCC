create database if not exists armazem;
use armazem;

CREATE TABLE empresas (
    id_empresa INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(100) NOT NULL UNIQUE,
    cnpj_empresa CHAR(14) NOT NULL UNIQUE,
    email_empresa VARCHAR(100) NOT NULL UNIQUE,
    senha_empresa VARCHAR(10) NOT NULL,
    setor_empresa VARCHAR(100) NOT NULL
);

CREATE TABLE enderecos (
    id_endereco INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    cep_endereco CHAR(8),
    rua_endereco VARCHAR(100) NOT NULL,
    numero_endereco INT NOT NULL,
    complemento_endereco VARCHAR(150) NOT NULL,
    bairro_endereco VARCHAR(100) NOT NULL,
    cidade_endereco VARCHAR(100) NOT NULL,
    uf_endereco CHAR(2) NOT NULL,
    pais_endereco VARCHAR(100) NOT NULL,
    empresa_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (empresa_id)
        REFERENCES empresas (id_empresa)
);

CREATE TABLE funcionarios (
    id_funcionario INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome_funcionario VARCHAR(100) NOT NULL,
    cpf_funcionario CHAR(11) NOT NULL UNIQUE,
    email_funcionario VARCHAR(100) NOT NULL UNIQUE,
    senha_funcionario VARCHAR(10) NOT NULL,
    tipo_funcionario ENUM('adm', 'usuario'),
    setor_funcionario VARCHAR(100) NOT NULL,
    empresa_id INT UNSIGNED NOT NULL,
    endereco_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (empresa_id)
        REFERENCES empresas (id_empresa),
    FOREIGN KEY (endereco_id)
        REFERENCES enderecos (id_endereco)
);

create table estoques(
id_estoque int unsigned primary key auto_increment,
codigo_estoque varchar(5) not null unique,
capacidade_estoque int unsigned not null,
status_estoque enum("livre", "ocupado") not null default("livre"),
descricao_estoque varchar(200) not null,
empresa_id int unsigned not null,
foreign key (empresa_id) references empresas(id_empresa)
);

CREATE TABLE produtos (
    id_produto INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL UNIQUE,
    tipo_produto VARCHAR(100) NOT NULL,
    ca_produto VARCHAR(20) NOT NULL,
    validade_ca DATE NOT NULL,
    tamanho_produto INT UNSIGNED NOT NULL,
    empresa_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (empresa_id)
        REFERENCES empresas (id_empresa)
);

CREATE TABLE lotes (
    id_lote INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    quantidade_lote INT UNSIGNED NOT NULL,
    entrada_lote TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fabricacao DATE NOT NULL,
    validade_lote DATE NOT NULL,
    estoque_id INT UNSIGNED NOT NULL,
    produto_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (estoque_id)
        REFERENCES estoques (id_estoque),
    FOREIGN KEY (produto_id)
        REFERENCES produtos (id_produto)
);

CREATE TABLE movimentacoes (
    id_movimentacao INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tipo_movimentacao ENUM('entrada', 'saida'),
    quantidade_movimentacao INT UNSIGNED NOT NULL,
    data_movimentacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lote_id INT UNSIGNED NOT NULL,
    estoque_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (lote_id)
        REFERENCES lotes (id_lote),
    FOREIGN KEY (estoque_id)
        REFERENCES estoques (id_estoque)
);
