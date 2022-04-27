-- criando o banco uvv
CREATE DATABASE uvv;
-- selecionando o banco uvv
USE uvv;

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(60),
                sexo CHAR(1),
                salario DECIMAL(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INT NOT NULL,
                PRIMARY KEY (cpf)
);

ALTER TABLE funcionario COMMENT 'tabela que armazena as informacoes dos funcionarios';

ALTER TABLE funcionario MODIFY COLUMN cpf CHAR(11) NOT NULL COMMENT 'cpf do funcionario';

ALTER TABLE funcionario MODIFY COLUMN primeiro_nome VARCHAR(15) NOT NULL COMMENT 'primeiro nome do funcionario';

ALTER TABLE funcionario MODIFY COLUMN nome_meio CHAR(1) COMMENT 'inicial do nome do meio';

ALTER TABLE funcionario MODIFY COLUMN ultimo_nome VARCHAR(15) NOT NULL COMMENT 'sobrenome do funcionario';

ALTER TABLE funcionario MODIFY COLUMN data_nascimento DATE COMMENT 'data de nascimento do funcionario';

ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(60) COMMENT 'endereco do funcionario';

ALTER TABLE funcionario MODIFY COLUMN sexo CHAR(1) COMMENT 'sexo do funcionario';

ALTER TABLE funcionario MODIFY COLUMN salario DECIMAL(10, 2) COMMENT 'salario do funcionario';

ALTER TABLE funcionario MODIFY COLUMN cpf_supervisor CHAR(11) NOT NULL COMMENT 'cpf do supervisor';

ALTER TABLE funcionario MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'numero do departamento do funcionario';


CREATE TABLE departamento (
                numero_departamento INT NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                PRIMARY KEY (numero_departamento)
);

ALTER TABLE departamento COMMENT 'tabela que armazena as informacoes dos departamentos';

ALTER TABLE departamento MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'numero do departamento';

ALTER TABLE departamento MODIFY COLUMN nome_departamento VARCHAR(15) NOT NULL COMMENT 'nome do departamento';

ALTER TABLE departamento MODIFY COLUMN cpf_gerente CHAR(11) NOT NULL COMMENT 'cpf do gerente do departamento';

ALTER TABLE departamento MODIFY COLUMN data_inicio_gerente DATE COMMENT 'data do inicio do gerente no departamento';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INT NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INT NOT NULL,
                PRIMARY KEY (numero_projeto)
);

ALTER TABLE projeto COMMENT 'tabela que armazena as informacoes sobre os projetos dos departamentos';

ALTER TABLE projeto MODIFY COLUMN numero_projeto INTEGER NOT NULL COMMENT 'numero do projeto';

ALTER TABLE projeto MODIFY COLUMN nome_projeto VARCHAR(15) NOT NULL COMMENT 'nome do projeto';

ALTER TABLE projeto MODIFY COLUMN local_projeto VARCHAR(15) COMMENT 'localizacao do projeto';

ALTER TABLE projeto MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'numero do departamento';


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INT NOT NULL,
                horas DECIMAL(3,1) NOT NULL,
                PRIMARY KEY (cpf_funcionario, numero_projeto)
);

ALTER TABLE trabalha_em COMMENT 'tabela para armazenar quais funcionarios trabalham em quais projetos';

ALTER TABLE trabalha_em MODIFY COLUMN cpf_funcionario CHAR(11) NOT NULL COMMENT 'cpf do funcionario';

ALTER TABLE trabalha_em MODIFY COLUMN numero_projeto INTEGER NOT NULL COMMENT 'numero do projeto';

ALTER TABLE trabalha_em MODIFY COLUMN horas DECIMAL(3, 1) NOT NULL COMMENT 'horas trabalhadas pelo funcionario nesse projeto';


CREATE TABLE localizacoes_departamento (
                numero_departamento INT NOT NULL,
                local VARCHAR(15) NOT NULL,
                PRIMARY KEY (numero_departamento, local)
);

ALTER TABLE localizacoes_departamento COMMENT 'tabela que armazena as possiveis localizacoes dos depatamentos';

ALTER TABLE localizacoes_departamento MODIFY COLUMN numero_departamento INTEGER NOT NULL COMMENT 'numero do departamento';

ALTER TABLE localizacoes_departamento MODIFY COLUMN local VARCHAR(15) NOT NULL COMMENT 'localizacao do departamento';


CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                PRIMARY KEY (cpf_funcionario, nome_dependente)
);

ALTER TABLE dependente COMMENT 'tabela que armazena as informacoes dos dependentes dos funcionarios';

ALTER TABLE dependente MODIFY COLUMN cpf_funcionario CHAR(11) NOT NULL COMMENT 'cpf do funcionario';

ALTER TABLE dependente MODIFY COLUMN nome_dependente VARCHAR(15) NOT NULL COMMENT 'nome do dependente';

ALTER TABLE dependente MODIFY COLUMN sexo CHAR(1) COMMENT 'sexo do dependente';

ALTER TABLE dependente MODIFY COLUMN data_nascimento DATE COMMENT 'data de nascimento do dependente';

ALTER TABLE dependente MODIFY COLUMN parentesco VARCHAR(15) COMMENT 'descricao do parentesco do dependente com o funcionario';


ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

DESC departamento;
DESC dependente;
DESC trabalha_em;
DESC projeto;
DESC localizacoes_departamento;
DESC funcionario;



-- inserindo dados funcionario

SELECT * FROM funcionario;

INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('88866555576', 'Jorge', 'E', 'Brito', '1937-11-10', 'Rua do Horto,35,São Paulo,SP', 'M', 55000, '88866555576', '1');


INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('33344555587', 'Fernando', 'T', 'Wong', '1955-12-08', 'Rua da Lapa,34,São Paulo,SP', 'M', 40000, '88866555576', '5');

INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('98765432168', 'Jennifer', 'S', 'Souza', '1941-06-20', 'Av.Arthur de Lima,54,Santo Andre,SP', 'F', 43000, '88866555576', '4'),
('12345678966', 'João', 'B', 'Silva', '1965-01-09', 'Rua das Flores,751,São Paulo,SP', 'M', 30000, '33344555587', '5')
;

INSERT INTO funcionario(cpf, primeiro_nome, nome_meio, ultimo_nome, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES ('99988777767', 'Alice', 'J', 'Zelaya', '1968-01-19', 'Rua Souza Lima,35,Curitiba,PR', 'F', 25000, '98765432168', '4'),
('98798798733', 'André', 'V', 'Pereira', '1969-03-29', 'Rua Timbira,35,São Paulo,SP', 'M', 25000, '98765432168', '4'),
('66688444476', 'Ronaldo', 'K', 'Lima', '1962-09-15', 'Rua Rebouças,65,Piracicaba,SP', 'M', 38000, '33344555587', '5'),
('45345345376', 'Joice', 'A', 'Leite', '1972-07-31', 'Av.Lucas Obes,74,São Paulo,SP', 'F', 25000, '33344555587', '5');


-- inserindo dados departamento

SELECT * FROM departamento;

INSERT INTO departamento
VALUES (5, 'Pesquisa', '33344555587', '1998-05-22');

INSERT INTO departamento
VALUES (4, 'Administração', '98765432168', '1995-01-01'),
(1, 'Matriz', '88866555576', '1981-06-19');


-- inserindo localizacoes do departamento

SELECT * FROM localizacoes_departamento;

INSERT INTO localizacoes_departamento
VALUES (1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');


-- inserindo tabela de projetos

SELECT * FROM projeto;

INSERT INTO projeto
VALUES (1,'ProdutoX', 'Santo André', 5),
(2, 'ProdutoY', 'Itu', 5),
(3, 'ProdutoZ', 'São Paulo', 5),
(10, 'Informatização', 'Mauá', 4),
(20, 'Reorganização', 'São Paulo', 1),
(30, 'NovosBeneficios', 'Mauá',4);


-- inserindo tabela de dependentes

SELECT * FROM dependente;

INSERT INTO dependente 
VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
('33344555587', 'Janaina', 'F', '1958-05-03', 'Esposa'),
('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');


-- inserindo dados da tabela trabalha_em

SELECT * FROM trabalha_em;

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
('88866555576', 20, 0);
