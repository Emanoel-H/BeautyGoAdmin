CREATE EXTENSION IF NOT EXISTS postgis;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TYPE status_pedido as ENUM(
'pendente',
'aceito',
'em_andamento',
'concluido',
'cancelado'
);

create table categorias_servico (
	id BIGSERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	descricao TEXT
);

insert into categorias_servico (nome, descricao)
values('corte masculino', 'desfarce, VO, degradê, americano, mullet...');

insert into categorias_servico (nome, descricao)
values('corte feminino', 'pixie, chanel, escova, long bob...');

insert into categorias_servico (nome, descricao)
values('design sobrancelha', 'reta, curvado, arqueado...');

insert into categorias_servico (nome, descricao)
values('barba', 'aparar, desenhar, bigode, cavanhaque...');

insert into categorias_servico (nome, descricao)
values('manicure', 'nail design, lichar, completo...');

insert into categorias_servico (nome, descricao)
values('pedicure', 'nail design, desencravar, lichar, completo...');

create table clientes (
	id BIGSERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(200) UNIQUE NOT NULL,
	telefone VARCHAR(20) NOT NULL,
	senha TEXT NOT NULL,
	localizacao GEOGRAPHY(POINT, 4326),
	data_cadastro TIMESTAMP DEFAULT NOW(),
	data_alteracao timestamp(6) NULL
);

create table profissionais (
	id BIGSERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	bio TEXT,
	email VARCHAR(200) UNIQUE NOT NULL,
	telefone VARCHAR(20) NOT NULL,
	senha TEXT NOT NULL,
	raio_atendimento_km DECIMAL(5,2) NOT NULL,
	localizacao GEOGRAPHY(POINT, 4326),
	data_cadastro TIMESTAMP DEFAULT NOW(),
	data_alteracao timestamp(6) NULL
);

create table servicos_oferecidos(
	id BIGSERIAL PRIMARY KEY,
	profissional_id BIGINT NOT NULL,
	categoria_id BIGINT NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	data_cadastro TIMESTAMP DEFAULT NOW(),
	
	CONSTRAINT fk_servicos_profissionais FOREIGN KEY (profissional_id) 
	REFERENCES profissionais(id) 
	ON DELETE CASCADE,

	CONSTRAINT fk_servicos_categorias FOREIGN KEY (categoria_id) 
	REFERENCES categorias_servico(id) 
	ON DELETE CASCADE,

	CONSTRAINT uq_profissional_categoria 
	UNIQUE (profissional_id, categoria_id)
);

create table pedidos(
	id BIGSERIAL PRIMARY KEY,
	cliente_id BIGINT NOT NULL,
	servico_id BIGINT NOT NULL,
	status status_pedido DEFAULT 'pendente' NOT NULL,
	data_agendamento TIMESTAMP NOT NULL,
	data_cadastro TIMESTAMP DEFAULT NOW(),
	
	CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente_id) 
	REFERENCES clientes(id) 
	ON DELETE RESTRICT,

	CONSTRAINT fk_pedidos_servicos FOREIGN KEY (servico_id) 
	REFERENCES servicos_oferecidos(id) 
	ON DELETE RESTRICT
);

create table avaliacoes (
	id BIGSERIAL PRIMARY KEY,
	pedido_id BIGINT UNIQUE NOT NULL,
	nota INT NOT NULL,
	comentario TEXT,
	data_cadastro TIMESTAMP DEFAULT NOW(),

	CONSTRAINT fk_avaliacoes_pedidos FOREIGN KEY (pedido_id) 
	REFERENCES pedidos(id) 
	ON DELETE CASCADE,

	CONSTRAINT chk_nota_escala CHECK (nota >= 1 AND nota <= 5)
);

CREATE INDEX idx_profissionais_localizacao 
ON profissionais 
USING GIST(localizacao);

CREATE INDEX idx_clientes_localizacao 
ON clientes 
USING GIST(localizacao);