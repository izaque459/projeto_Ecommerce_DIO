CREATE DATABASE projetoEcommerce;

use projetoEcommerce;


CREATE TABLE cliente (
  idCliente INT UNSIGNED  AUTO_INCREMENT PRIMARY KEY,
  CPF VARCHAR(11)  NULL,
  CNPJ VARCHAR(15)  NULL,
  Nome VARCHAR(45) NULL,
  Razão_Social VARCHAR(45) NULL,
  CEP VARCHAR(45) NOT NULL,
  Email VARCHAR(45) NOT NULL,
  Telefone VARCHAR(45) NOT NULL,
  CONSTRAINT unique_CPF UNIQUE(CPF),
  CONSTRAINT unique_CNPJ UNIQUE(CNPJ)
  );
  
CREATE TABLE produto(
  idProduto INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  Categoria ENUM('ELETRONICOS','VESTIMENTAS','BRINQUEDOS', 'ALIMENTOS', 'MOVEIS') NOT NULL
  );
  

  CREATE TABLE pedido(
  idPedido INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  StatusPedido ENUM('CANCELADO', 'CONFIRMADO', 'EM PROCESSAMENTO') DEFAULT 'EM PROCESSAMENTO',
  Cliente_idCliente INT UNSIGNED NOT NULL,  
  CONSTRAINT fk_Cliente_idCliente FOREIGN KEY (Cliente_idCliente) REFERENCES cliente(idCliente)
    );
    
CREATE TABLE pagamento(
	idPagamento INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TipoPagamento enum('PIX','BOLETO', 'CARTÃO', 'DEPOSITO','CHEQUE'),
    Valor FLOAT DEFAULT 0.0,
	Pagamento BOOLEAN DEFAULT FALSE,
    Pedido_idPedido INT UNSIGNED NOT NULL,
    CONSTRAINT  fk_Pedido_idPedido FOREIGN KEY (Pedido_idPedido) REFERENCES pedido(idPedido)
);

CREATE TABLE estoque(
  idEstoque INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  CEP VARCHAR(45) NULL,
  Telefone VARCHAR(15) NULL,
  Email VARCHAR(20) NULL
 );
 
 CREATE TABLE fornecedor(
  idFornecedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  CNPJ VARCHAR(15) NOT NULL,
  Razão_social  VARCHAR(45) NULL,
  CEP VARCHAR(45) NULL,
  Email VARCHAR(45) NULL,
  Telefone VARCHAR(15) NULL,
  CONSTRAINT unique_CNPJ UNIQUE(CNPJ)
);

CREATE TABLE vendedor(
  idVendedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  Nome VARCHAR(45) NOT NULL,
  CEP VARCHAR(45) NULL,
  Email VARCHAR(45) NULL,
  Telefone VARCHAR(15) NULL,
  CNPJ VARCHAR(15) NULL,
  CPF VARCHAR(11) NULL,
  CONSTRAINT unique_CNPJ UNIQUE(CNPJ),
  CONSTRAINT  unique_CPF UNIQUE(CPF)
  );

CREATE TABLE vendedor_has_produto(
	Vendedor_idVendedor INT UNSIGNED,
    Produto_idProduto INT UNSIGNED,
    Quantidade INT DEFAULT 1,
    PRIMARY KEY (Vendedor_idVendedor,Produto_idProduto),
    CONSTRAINT fk_Vendedor_idVendedor FOREIGN KEY (Vendedor_idVendedor) REFERENCES vendedor(idVendedor),
	CONSTRAINT fk_Produto_idProduto FOREIGN KEY (Produto_idProduto) REFERENCES produto(idProduto)
  );

  CREATE TABLE produto_has_pedido(
	Produto_idProduto INT UNSIGNED,
    Pedido_idPedido INT UNSIGNED,
    Quantidade INT DEFAULT 1,
    PRIMARY KEY(Produto_idProduto, Pedido_idPedido),
    produtoStatus ENUM('DISPONIVEL NO ESTOQUE', 'INDISPONÍVEL NO ESTOQUE') DEFAULT 'DISPONIVEL NO ESTOQUE',
    CONSTRAINT  fk2_Produto_idProduto FOREIGN KEY (Produto_idProduto) REFERENCES produto(idProduto),
    CONSTRAINT  fk2_Pedido_idPedido FOREIGN KEY (Pedido_idPedido) REFERENCES pedido(idPedido)
  );
  
 CREATE TABLE produto_has_fornecedor(
	Fornecedor_idFornecedor INT UNSIGNED ,
    Produto_idProduto INT UNSIGNED,
    Quantidade INT NOT NULL,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    CONSTRAINT fk_Fornecedor_idFornecedor FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES fornecedor(idFornecedor),
    CONSTRAINT fk3_Produto_idProduto FOREIGN KEY (Produto_idProduto) REFERENCES produto(idProduto)
  );
  
  CREATE TABLE Produto_has_Estoque(
		Produto_idProduto INT UNSIGNED,
        Estoque_idEstoque INT UNSIGNED,
        Quantidade INT UNSIGNED,
        PRIMARY KEY(Produto_idProduto , Estoque_idEstoque) ,
        CONSTRAINT fk4_Produto_idProduto FOREIGN KEY (Produto_idProduto) REFERENCES produto(idProduto),
        CONSTRAINT fk_Estoque_idEstoque FOREIGN KEY (Estoque_idEstoque) REFERENCES estoque(idEstoque)
  );