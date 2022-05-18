-- Projeto Feito para o CMD do Linux

-- Logando no Linux SuperUser:

psql -U postgres

-- Criando Script PostgreSQL:

-- Criando usuario diogo:

create user diogo with
NOSUPERUSER
CREATEDB
CREATEROLE
inherit
LOGIN
encrypted password '123'
;


-- Criando o banco uvv:

create database uvv with
owner = 'diogo'
encoding ='UTF8'
template =template0
lc_collate ='pt_BR.UTF-8'
lc_ctype ='pt_BR.UTF-8'
allow_connections = true
;


-- Desogando no Linux Superuser:

\q


-- logando no diogo:

psql -U diogo uvv;


-- Criando o esquema elmasri:

CREATE SCHEMA elmasri AUTHORIZATION diogo;


-- Criando Tabelas


-- criando tabela funcionario


CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(60),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_funcionario PRIMARY KEY (cpf)
);
COMMENT ON TABLE elmasri.funcionario IS 'tabela que armazena as informacoes dos funcionarios';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'cpf do funcionario';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'primeiro nome do funcionario';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'inicial do nome do meio';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'sobrenome do funcionario';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'data de nascimento do funcionario';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'endereco do funcionario';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'sexo do funcionario';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'salario do funcionario';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'cpf do supervisor';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'numero do departamento do funcionario';


-- criando tabela departamento

CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT pk_departamento PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE elmasri.departamento IS 'tabela que armazena as informacoes dos departamentos';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'numero do departamento';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'nome do departamento';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'cpf do gerente do departamento';
COMMENT ON COLUMN elmasri.departamento.data_inicio_gerente IS 'data do inicio do gerente no departamento';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );


-- criando tabela projeto


CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT pk_projeto PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE elmasri.projeto IS 'tabela que armazena as informacoes sobre os projetos dos departamentos';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'numero do projeto';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'nome do projeto';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'localizacao do projeto';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'numero do departamento';


CREATE UNIQUE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );


-- criando trabalha_em


CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1),
                CONSTRAINT pk_trabalha_em PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE elmasri.trabalha_em IS 'tabela para armazenar quais funcionarios trabalham em quais projetos';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'cpf do funcionario';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'numero do projeto';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'horas trabalhadas pelo funcionario nesse projeto';

-- criando tabela localizacoes_departamento

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT pk_localizacoes_departamento PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'tabela que armazena as possiveis localizacoes dos depatamentos';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'numero do departamento';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'localizacao do departamento';

-- criando tabela dependente


CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT pk_dependente PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE elmasri.dependente IS 'tabela que armazena as informacoes dos dependentes dos funcionarios';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'cpf do funcionario';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'nome do dependente';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'sexo do dependente';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'data de nascimento do dependente';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'descricao do parentesco do dependente com o funcionario';

-- alterando as tabelas e adicionando as constraints de funcionario_funcionario_fk


ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- alterando as tabelas e adicionando as constraints de funcionario_dependente_fk


ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- alterando as tabelas e adicionando as constraints de funcionario_departamento_fk


ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- alterando as tabelas e adicionando as constraints de funcionario_trabalha_em_fk


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- alterando as tabelas e adicionando as constraints de departamento_localizacoes_departamento_fk


ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- alterando as tabelas e adicionando as constraints de departamento_projeto_fk


ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- alterando as tabelas e adicionando as constraints de projeto_trabalha_em_fk


ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



-- Inserindo Dados nas tabelas



-- inserindo dados funcionario:

INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto,35,São Paulo,SP', 'M', 55000, '88866555576' , '1');


INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa,34,São Paulo,SP', 'M', 40000, '88866555576', '5');

INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av.Arthur de Lima,54,Santo Andre,SP', 'F', 43000, '88866555576', '4'),
('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores,751,São Paulo,SP', 'M', 30000, '33344555587', '5');


INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima,35,Curitiba,PR', 'F', 25000, '98765432168', '4'),
('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira,35,São Paulo,SP', 'M', 25000, '98765432168', '4'),
('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças,65,Piracicaba,SP', 'M', 38000, '33344555587', '5'),
('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av.Lucas Obes,74,São Paulo,SP', 'F', 25000, '33344555587', '5');


-- inserindo dados departamento

INSERT INTO departamento
VALUES (5, 'Pesquisa', '33344555587', '1998-05-22');

INSERT INTO departamento
VALUES (4, 'Administração', '98765432168', '1995-01-01'),
(1, 'Matriz', '88866555576', '1981-06-19');


-- inserindo localizacoes do departamento

INSERT INTO localizacoes_departamento
VALUES (1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');


-- inserindo tabela de projetos

INSERT INTO projeto
VALUES (1,'ProdutoX', 'Santo André', 5),
(2, 'ProdutoY', 'Itu', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10, 'Informatização', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'NovosBeneficios', 'Mauá',4);


-- inserindo tabela de dependentes

INSERT INTO dependente 
VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');


-- inserindo dados da tabela trabalha_em

INSERT INTO trabalha_em
VALUES ('12345678966', 1, 32.5);

INSERT INTO trabalha_em
VALUES ('12345678966', 2, 7.5),
('66688444476', 3, 40),
('45345345376', 1, 20),
('45345345376', 2, 20),
('33344555587', 2, 10),
('33344555587', 3, 10),
('33344555587', 10, 10),
('33344555587', 20, 10),
('99988777767', 30, 30),
('99988777767', 10, 10),
('98798798733', 10, 35),
('98798798733', 30, 5),
('98765432168', 30, 20),
('98765432168', 20, 15),
('88866555576', 20, NULL);


