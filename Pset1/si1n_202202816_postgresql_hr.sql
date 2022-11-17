-- Aluno:Eric Andrade Eller.  Turma:si1n.  Profº: Abrantes Araújo silva FIlho.

-- Script para implementação do banco de dados hr ao SGBD Postgresql


-- String para a criação do usuário e suas respectivas permissões
create role eric with 
createdb 
createrole;

-- String para criar o banco de dados 'UVV'
CREATE DATABASE UVV
    WITH
    OWNER = eric
    TEMPLATE = TEMPLATE0 
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true
    ;
   
-- String para comentar o banco de dados criado
COMMENT ON DATABASE UVV
    IS 'Banco de dados utilizado para a implementação do banco de dados HR proposto no Pset1 ';
   
-- Conecta ao banco de dados
\c "dbname=uvv user=eric password=computacao@raiz"

-- String para criar o esquema 'hr' e dar autorização para o usuario 'eric'
CREATE SCHEMA IF NOT EXISTS hr AUTHORIZATION eric;

-- String para alterar o search_patch, padrão para meu schema hr (De forma provisória)
SET SEARCH_PATH TO hr, "$user", public;

-- String para alterar o search_patch, padrão para meu schema hr (De forma permanente)
ALTER USER eric
SET SEARCH_PATH TO hr, "$user", public;

-- String para criar a tabela de cargos
CREATE TABLE cargos (
                id_cargo VARCHAR(10) NOT NULL,
                cargo VARCHAR(35) NOT NULL,
                salario_minimo NUMERIC(8,2),
                salario_maximo NUMERIC(8,2),
                CONSTRAINT id_cargo_pk PRIMARY KEY (id_cargo)
);

-- String para adicionar comentários na tabela CARGOS e suas respectivas colunas
COMMENT ON TABLE cargos IS 'Tabela que armazena os cargos existentes na empresa, e seus respectivos salários (Minimo) e (Máximo).';
COMMENT ON COLUMN cargos.id_cargo IS 'Primary key(PK) que identifica um cargo.';
COMMENT ON COLUMN cargos.cargo IS 'Nome do cargo';
COMMENT ON COLUMN cargos.salario_minimo IS 'Menor salário de um cargo';
COMMENT ON COLUMN cargos.salario_maximo IS 'Maior salário de um cargo.';

-- String para criar um índice exclusivo para a tabela CARGOS
CREATE UNIQUE INDEX cargos_idx
 ON cargos
 ( cargo );

-- String para criar a tabela de regioes
CREATE TABLE regioes (
                Id_regiao INTEGER NOT NULL,
                nome VARCHAR(25) NOT NULL,
                CONSTRAINT id_regiao_pk PRIMARY KEY (Id_regiao)
);

-- String para adicionar comentários na tabela de REGIOES e suas respectivas colunas
COMMENT ON TABLE regioes IS 'Tabela de regiões. Dentro desta tabela você encontra o nome da região e seu respectivo identificador(id).';
COMMENT ON COLUMN regioes.Id_regiao IS 'Primary key(PK) que identifica uma região especifica dentro dessa tabela.';
COMMENT ON COLUMN regioes.nome IS 'Indice único que identifica o nome da região';

-- String para criar um índice exclusivo para a tabela REGIOES
CREATE UNIQUE INDEX regioes_idx
 ON regioes
 ( nome );

-- String para criar a tabela paises
CREATE TABLE paises (
                id_pais CHAR(2) NOT NULL,
                nome VARCHAR(50) NOT NULL,
                Id_regiao INTEGER NOT NULL,       
                CONSTRAINT id_pais_pk PRIMARY KEY (id_pais)
);

-- String para adicionar comentários na tabela de PAISES e suas respectivas colunas
COMMENT ON TABLE paises IS 'Tabela que armazena dados sobre os paises, como por exemplo a regiao em que ele se encontra, seu respectivo nome e seu pŕoprio identificador(id)';
COMMENT ON COLUMN paises.id_pais IS 'Primary key(PK) que identifica um país especifico dentro dessa tabela.';
COMMENT ON COLUMN paises.Id_regiao IS 'Chave estrangeira (FK), que faz referência à tabela regioes';
COMMENT ON COLUMN paises.nome IS 'ndice único que identifica o nome do país';

-- String para criar um índice exclusivo para a tabela PAISES
CREATE UNIQUE INDEX paises_idx
 ON paises
 ( nome );

-- String para criar a tabela de localizacoes
CREATE TABLE localizacoes (
                id_localizacao INTEGER NOT NULL,
                endereco VARCHAR(50),
                cep VARCHAR(12),
                cidade VARCHAR(50),
                uf VARCHAR(25),
                id_pais CHAR(2) NOT NULL,
                CONSTRAINT id_localizacao_pk PRIMARY KEY (id_localizacao)
);

-- String para adiconar comentários na tabela de LOCALIZACOES e suas respectivas colunas
COMMENT ON TABLE localizacoes IS 'Tabela de localições armazena dados sobre a localização dos diversos departamentos. Como por exemplo seu endereço, cidade e estado.';
COMMENT ON COLUMN localizacoes.id_localizacao IS 'Primary key(PK) que identifica uma localização dentro da tabela.';
COMMENT ON COLUMN localizacoes.endereco IS 'identifica o endereço de um departamento ou escritório da empresa.';
COMMENT ON COLUMN localizacoes.cep IS 'Identifica o CEP localizador de um departamento ou escritório da empresa.';
COMMENT ON COLUMN localizacoes.cidade IS 'Identifica a cidade em que está localizado um departamento ou escritório da empresa.';
COMMENT ON COLUMN localizacoes.uf IS 'Identifica o estado onde é localizado um departamento ou escritório da empresa.';
COMMENT ON COLUMN localizacoes.id_pais IS 'Chave estrangeira (FK), que faz referência à tabela de paises.';

-- String para criar a tabela de departamentos
CREATE TABLE departamentos (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR(50),
                id_localizacao INTEGER NOT NULL,
                id_gerente INTEGER NULL,
                CONSTRAINT id_departamento_pk PRIMARY KEY (id_departamento)
);

-- String para adicionar comentários na tabela de DEPARTAMENTOS e sua respectivas colunas
COMMENT ON TABLE departamentos IS 'Tabela departamento. Reponsável por identificar os departamentos da empresa, informando sua localização e qual o seu supervisor';
COMMENT ON COLUMN departamentos.id_departamento IS 'Primary key(PK) que identifica um departamento dentro da tabela.';
COMMENT ON COLUMN departamentos.nome IS 'Identifica o nome de um departamento.';
COMMENT ON COLUMN departamentos.id_localizacao IS 'Chave estrangeira (FK), que faz referência à tabela de localização. E identifica onde é a localização do departamento.';
COMMENT ON COLUMN departamentos.id_gerente IS 'Chave estrangeira (FK), que faz referência à tabela de empregados. E identifica o gerente responsável pelo departamento.';

-- String para criar a tabela de empregados
CREATE TABLE empregados (
                id_empregado INTEGER NOT NULL,
                nome VARCHAR(75) NOT NULL,
                email VARCHAR(35) NOT NULL,
                telefone VARCHAR(20),
                data_contratacao DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                salario NUMERIC(8,2),
                comissao NUMERIC(4,2),
                id_departamento INTEGER NULL,
                id_supervisor INTEGER NULL,
                CONSTRAINT id_empregado_pk PRIMARY KEY (id_empregado)
);

-- String para adicionar comentários na tabela de EMPREGADOS e suas respectivas colunas
COMMENT ON TABLE empregados IS 'Tabela responável por informar todos os dados de um empregado da empresa.';
COMMENT ON COLUMN empregados.id_empregado IS 'Primary key(PK) que identifica um empregado dentro da tabela.';
COMMENT ON COLUMN empregados.nome IS 'Referente ao nome completo do empregado';
COMMENT ON COLUMN empregados.email IS 'Referente ao email inicial (Antes do @) do empregado.';
COMMENT ON COLUMN empregados.telefone IS 'Referente ao telefone completo do empregado, incluindo o código do seu respectivo pais e estado.';
COMMENT ON COLUMN empregados.data_contratacao IS 'Referente a data em que o empregado iniciou no cargo em que ele está.';
COMMENT ON COLUMN empregados.id_cargo IS 'Chave estrangeira (FK), que faz referência à tabela de cargos. E identifica qual o cargo que esta sendo oculpado pelo empregado.';
COMMENT ON COLUMN empregados.salario IS 'Referente ao salário mensal do empregado.';
COMMENT ON COLUMN empregados.comissao IS 'Referente a porcentagem de comissão de um empregado. no entanto, apenas empregados alocados no departamento de vendas recebem comissões.';
COMMENT ON COLUMN empregados.id_departamento IS 'Chave estrangeira (FK), que faz referência à tabela de departamentos. E identifica em qual departamento aquele empregado está alocado.';
COMMENT ON COLUMN empregados.id_supervisor IS 'Chave estrangeira (FK), que faz referência à própria tabela de empregados, e identifica o supervisor direto de um empregado.';

-- String para criar um índice exclusivo para a tabela empregados na coluna de EMAIL
CREATE UNIQUE INDEX empregados_idx
 ON empregados
 ( email );

-- String para criar um índice exclusivo para a tabela empregados na coluna de id_supervisor
CREATE INDEX empregados_idx1
 ON empregados
 ( id_supervisor );

-- String para agrupar a tabela especificada
CLUSTER empregados_idx1 ON empregados;

-- String para criar um índice exclusivo para a tabela empregados na coluna de id_supervisor 2
CREATE INDEX empregados_idx2
 ON empregados
 ( id_supervisor ASC );

-- String para criar um índice exclusivo para a tabela empregados na coluna de id_supervisor 3
CREATE INDEX empregados_idx3
 ON empregados
 ( id_supervisor ASC );

-- String para criar a tabela de historico de cargos
CREATE TABLE historico_cargos (
                id_empregado INTEGER NOT NULL,
                data_inicial DATE NOT NULL,
                data_final DATE NOT NULL,
                id_cargo VARCHAR(10) NOT NULL,
                id_departamento INTEGER NOT NULL,
                CONSTRAINT id_empregado_pfk PRIMARY KEY (id_empregado, data_inicial)
);

-- String para adicionar comentários na tabela HISTORICO_CARGOS e suas respectivas colunas
COMMENT ON TABLE historico_cargos IS 'Tabela que armazena todo o histórico dos cargos pelo qual um empregado já passou. Observa-se que, se um empregado mudar de cargo dentro de um departamento ou vice-versa, as informações antigas teram que ficar guardadas dentro desta tabela.';
COMMENT ON COLUMN historico_cargos.id_empregado IS 'Primary key(PK) que identifica um empregado dentro da tabela. Mas que também é uma Foreign Key(Fk) que faz referência à Primary Key(PK) da tabela empregados.';
COMMENT ON COLUMN historico_cargos.data_inicial IS 'Primary key(PK) que identifica a data que um empregado engressou em um novo cargo dentro da empresa.';
COMMENT ON COLUMN historico_cargos.data_final IS 'Identifica a data em que um empregado deixou de fazer parte de um cargo.';
COMMENT ON COLUMN historico_cargos.id_cargo IS 'Chave estrangeira (FK), que faz referência à tabela de cargos. E identifica qual o cargo que estava sendo oculpado por um empregado, antes deste deixar de fazer parte.';
COMMENT ON COLUMN historico_cargos.id_departamento IS 'Chave estrangeira (FK), que faz referência à tabela de departamentos. E identifica qual o departamento que o empregado estava alocado, antes deste deixar de fazer parte.';


-- Dados da tabela cargos
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('AD_PRES', 'President', 20080, 40000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('AD_VP', 'Administration Vice President', 15000, 30000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('AD_ASST', 'Administration Assistant', 3000, 6000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('FI_MGR', 'Finance Manager', 8200, 16000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('FI_ACCOUNT', 'Accountant', 4200, 9000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('AC_MGR', 'Accounting Manager', 8200, 16000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('AC_ACCOUNT', 'Public Accountant', 4200, 9000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('SA_MAN', 'Sales Manager', 10000, 20080);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('SA_REP', 'Sales Representative', 6000, 12008);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('PU_MAN', 'Purchasing Manager', 8000, 15000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('PU_CLERK', 'Purchasing Clerk', 2500, 5500);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('ST_CLERK', 'Stock Clerk', 2008, 5000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('SH_CLERK', 'Shipping Clerk', 2500, 5500);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('MK_MAN', 'Marketing Manager', 9000, 15000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('MK_REP', 'Marketing Representative', 4000, 9000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('HR_REP', 'Human Resources Representative', 4000, 9000);
INSERT INTO cargos (id_cargo, cargo, salario_minimo, salario_maximo)
VALUES ('PR_REP', 'Public Relations Representative', 4500, 10500);


-- Dados da tabela regiões
INSERT INTO regioes (id_regiao, nome) 
VALUES (1, 'Europe' );
INSERT INTO regioes (id_regiao, nome) 
VALUES (2, 'Americas' );
INSERT INTO regioes (id_regiao, nome) 
VALUES (3, 'Asia' );
INSERT INTO regioes (id_regiao, nome) 
VALUES (4, 'Middle East and Africa' );


-- Dados da tabela de paises
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('AR', 'Argentina', 2 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('AU', 'Australia', 3 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('BE', 'Belgium', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('BR', 'Brazil', 2 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('CA', 'Canada', 2 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('CH', 'Switzerland', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('CN', 'China', 3 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('DE', 'Germany', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('DK', 'Denmark', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('EG', 'Egypt', 4 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('FR', 'France', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('IL', 'Israel', 4 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('IN', 'India', 3 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('IT', 'Italy', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('JP', 'Japan', 3 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('KW', 'Kuwait', 4 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('ML', 'Malaysia', 3 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('MX', 'Mexico', 2 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('NG', 'Nigeria', 4 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('NL', 'Netherlands', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('SG', 'Singapore', 3 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('UK', 'United Kingdom', 1 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('US', 'United States of America', 2 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('ZM', 'Zambia', 4 );
INSERT INTO paises (id_pais, nome, id_regiao)
VAlues ('ZW', 'Zimbabwe', 4 );


-- Dados da tabela de localizações
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1000, '1297 Via Cola di Rie', '00989', 'Roma', 'null', 'IT' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1100, '93091 Calle della Testa', '10934', 'Venice', 'null', 'IT' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1300, '9450 Kamiya-cho', '6823', 'Hiroshima', 'null', 'JP' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2000, '40-5-12 Laogianggen', '190518', 'Beijing', 'null', 'CN' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2300, '198 Clementi North', '540198', 'Singapore', 'null', 'SG' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2400, '8204 Arthur St', '', 'London', 'null', 'UK' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2600, '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2800, 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL' );
INSERT INTO localizacoes (id_localizacao, endereco, cep, cidade, uf, id_pais)
VALUES (3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX' );


-- Dados da tabela de departamentos;
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (10, 'Administration',
 1700,
 200);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (20, 'Marketing',
 1800,
 201);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (30, 'Purchasing',
 1700,
 114);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (40, 'Human Resources',
 2400,
 203);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (50, 'Shipping',
 1500,
 121);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (60, 'IT',
 1400,
 103);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (70, 'Public Relations',
 2700,
 204);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (80, 'Sales',
 2500,
 145);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (90, 'Executive',
 1700,
 100);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (100, 'Finance',
 1700,
 108);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (110, 'Accounting',
 1700,
 205);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (120, 'Treasury',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (130, 'Corporate Tax',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (140, 'Control And Credit',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (150, 'Shareholder Services',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (160, 'Benefits',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (170, 'Manufacturing',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (180, 'Construction',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (190, 'Contracting',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (200, 'Operations',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (210, 'IT Support',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (220, 'NOC',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (230, 'IT Helpdesk',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (240, 'Government Sales',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (250, 'Retail Sales',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (260, 'Recruiting',
 1700,
 null);
INSERT INTO departamentos (id_departamento, nome, id_localizacao, id_gerente)
VALUES (270, 'Payroll',
 1700,
 null);


-- Dados para a tabela de empregados

INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(100, 'Steven King', 'SKING', '515.123.4567', '2003-06-17', 'AD_PRES', 24000, null, 90, null);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(101, 'Neena Kochhar', 'NKOCHHAR', '515.123.4568', '2005-09-21', 'AD_VP', 17000, null, 90, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(102, 'Lex De Haan', 'LDEHAAN', '515.123.4569', '2001-01-13', 'AD_VP', 17000, null, 90, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(103, 'Alexander Hunold', 'AHUNOLD', '590.423.4567', '2006-01-03', 'IT_PROG', 9000, null, 60, 102);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(104, 'Bruce Ernst', 'BERNST', '590.423.4568', '2007-05-21', 'IT_PROG', 6000, null, 60, 103);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(105, 'David Austin', 'DAUSTIN', '590.423.4569', '2005-06-25', 'IT_PROG', 4800, null, 60, 103);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(106, 'Valli Pataballa', 'VPATABAL', '590.423.4560', '2006-02-05', 'IT_PROG', 4800, null, 60, 103);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(107, 'Diana Lorentz', 'DLORENTZ', '590.423.5567', '2007-02-07', 'IT_PROG', 4200, null, 60, 103);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(108, 'Nancy Greenberg', 'NGREENBE', '515.124.4569', '2002-08-17', 'FI_MGR', 12008, null, 100, 101);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(109, 'Daniel Faviet', 'DFAVIET', '515.124.4169', '2002-08-16', 'FI_ACCOUNT', 9000, null, 100, 108);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(110, 'John Chen', 'JCHEN', '515.124.4269', '2005-09-28', 'FI_ACCOUNT', 8200, null, 100, 108);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(111, 'Ismael Sciarra', 'ISCIARRA', '515.124.4369', '2005-09-30', 'FI_ACCOUNT', 7700, null, 100, 108);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(112, 'Jose Manuel Urman', 'JMURMAN', '515.124.4469', '2006-03-07', 'FI_ACCOUNT', 7800, null, 100, 108);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(113, 'Luis Popp', 'LPOPP', '515.124.4567', '2007-12-07', 'FI_ACCOUNT', 6900, null, 100, 108);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(114, 'Den Raphaely', 'DRAPHEAL', '515.127.4561', '2002-12-07', 'PU_MAN', 11000, null, 30, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(115, 'Alexander Khoo', 'AKHOO', '515.127.4562', '2003-05-18', 'PU_CLERK', 3100, null, 30, 114);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(116, 'Shelli Baida', 'SBAIDA', '515.127.4563', '2005-12-24', 'PU_CLERK', 2900, null, 30, 114);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(117, 'Sigal Tobias', 'STOBIAS', '515.127.4564', '2005-07-24', 'PU_CLERK', 2800, null, 30, 114);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(118, 'Guy Himuro', 'GHIMURO', '515.127.4565', '2006-11-15', 'PU_CLERK', 2600, null, 30, 114);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(119, 'Karen Colmenares', 'KCOLMENA', '515.127.4566', '2007-08-10', 'PU_CLERK', 2500, null, 30, 114);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(120, 'Matthew Weiss', 'MWEISS', '650.123.1234', '2004-07-18', 'ST_MAN', 8000, null, 50, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(121, 'Adam Fripp', 'AFRIPP', '650.123.2234', '2005-04-10', 'ST_MAN', 8200, null, 50, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(122, 'Payam Kaufling', 'PKAUFLIN', '650.123.3234', '2003-05-01', 'ST_MAN', 7900, null, 50, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(123, 'Shanta Vollman', 'SVOLLMAN', '650.123.4234', '2005-10-10', 'ST_MAN', 6500, null, 50, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(124, 'Kevin Mourgos', 'KMOURGOS', '650.123.5234', '2007-11-16', 'ST_MAN', 5800, null, 50, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(125, 'Julia Nayer', 'JNAYER', '650.124.1214', '2005-07-16', 'ST_CLERK', 3200, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(126, 'Irene Mikkilineni', 'IMIKKILI', '650.124.1224', '2006-09-28', 'ST_CLERK', 2700, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(127, 'James Landry', 'JLANDRY', '650.124.1334', '2007-01-14', 'ST_CLERK', 2400, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(128, 'Steven Markle', 'SMARKLE', '650.124.1434', '2008-03-08', 'ST_CLERK', 2200, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(129, 'Laura Bissot', 'LBISSOT', '650.124.5234', '2005-08-20', 'ST_CLERK', 3300, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(130, 'Mozhe Atkinson', 'MATKINSO', '650.124.6234', '2005-10-30', 'ST_CLERK', 2800, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(131, 'James Marlow', 'JAMRLOW', '650.124.7234', '2005-02-16', 'ST_CLERK', 2500, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(132, 'TJ Olson', 'TJOLSON', '650.124.8234', '2007-04-10', 'ST_CLERK', 2100, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(133, 'Jason Mallin', 'JMALLIN', '650.127.1934', '2004-06-14', 'ST_CLERK', 3300, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(134, 'Michael Rogers', 'MROGERS', '650.127.1834', '2006-08-26', 'ST_CLERK', 2900, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(135, 'Ki Gee', 'KGEE', '650.127.1734', '2007-12-12', 'ST_CLERK', 2400, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(136, 'Hazel Philtanker', 'HPHILTAN', '650.127.1634', '2008-02-06', 'ST_CLERK', 2200, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(137, 'Renske Ladwig', 'RLADWIG', '650.121.1234', '2003-07-14', 'ST_CLERK', 3600, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(138, 'Stephen Stiles', 'SSTILES', '650.121.2034', '2005-10-26', 'ST_CLERK', 3200, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(139, 'John Seo', 'JSEO', '650.121.2019', '2006-02-12', 'ST_CLERK', 2700, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(140, 'Joshua Patel', 'JPATEL', '650.121.1834', '2006-04-06', 'ST_CLERK', 2500, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(141, 'Trenna Rajs', 'TRAJS', '650.121.8009', '2003-10-17', 'ST_CLERK', 3500, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(142, 'Curtis Davies', 'CDAVIES', '650.121.2994', '2005-01-29', 'ST_CLERK', 3100, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(143, 'Randall Matos', 'RMATOS', '650.121.2874', '2006-03-15', 'ST_CLERK', 2600, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(144, 'Peter Vargas', 'PVARGAS', '650.121.2004', '2006-07-09', 'ST_CLERK', 2500, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(145, 'John Russell', 'JRUSSEL', '011.44.1344.429268', '2004-10-01', 'SA_MAN', 14000, .4, 80, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(146, 'Karen Partners', 'KPARTNER', '011.44.1344.467268', '2005-01-05', 'SA_MAN', 13500, .3, 80, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(147, 'Alberto Errazuriz', 'AERRAZUR', '011.44.1344.429278', '2005-03-10', 'SA_MAN', 12000, .3, 80, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(148, 'Gerald Cambrault', 'GCAMBRAU', '011.44.1344.619268', '2007-10-15', 'SA_MAN', 11000, .3, 80, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(149, 'Eleni Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2008-01-29', 'SA_MAN', 10500, .2, 80, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(150, 'Peter Tucker', 'PTUCKER', '011.44.1344.129268', '2005-01-30', 'SA_REP', 10000, .3, 80, 145);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(151, 'David Bernstein', 'DBERNSTE', '011.44.1344.345268', '2005-03-24', 'SA_REP', 9500, .25, 80, 145);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(152, 'Peter Hall', 'PHALL', '011.44.1344.478968', '2005-08-20', 'SA_REP', 9000, .25, 80, 145);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(153, 'Christopher Olsen', 'COLSEN', '011.44.1344.498718', '2006-03-30', 'SA_REP', 8000, .2, 80, 145);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(154, 'Nanette Cambrault', 'NCAMBRAU', '011.44.1344.987668', '2006-12-09', 'SA_REP', 7500, .2, 80, 145);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(155, 'Oliver Tuvault', 'OTUVAULT', '011.44.1344.486508', '2007-11-23', 'SA_REP', 7000, .15, 80, 145);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(156, 'Janette King', 'JKING', '011.44.1345.429268', '2004-01-30', 'SA_REP', 10000, .35, 80, 146);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(157, 'Patrick Sully', 'PSULLY', '011.44.1345.929268', '2004-03-04', 'SA_REP', 9500, .35, 80, 146);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(158, 'Allan McEwen', 'AMCEWEN', '011.44.1345.829268', '2004-08-01', 'SA_REP', 9000, .35, 80, 146);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(159, 'Lindsey Smith', 'LSMITH', '011.44.1345.729268', '2005-03-10', 'SA_REP', 8000, .3, 80, 146);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(160, 'Louise Doran', 'LDORAN', '011.44.1345.629268', '2005-12-15', 'SA_REP', 7500, .3, 80, 146);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(161, 'Sarath Sewall', 'SSEWALL', '011.44.1345.529268', '2006-11-03', 'SA_REP', 7000, .25, 80, 146);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(162, 'Clara Vishney', 'CVISHNEY', '011.44.1346.129268', '2005-11-11', 'SA_REP', 10500, .25, 80, 147);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(163, 'Danielle Greene', 'DGREENE', '011.44.1346.229268', '2007-03-19', 'SA_REP', 9500, .15, 80, 147);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(164, 'Mattea Marvins', 'MMARVINS', '011.44.1346.329268', '2008-01-24', 'SA_REP', 7200, .1, 80, 147);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(165, 'David Lee', 'DLEE', '011.44.1346.529268', '2008-02-23', 'SA_REP', 6800, .1, 80, 147);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(166, 'Sundar Ande', 'SANDE', '011.44.1346.629268', '2008-03-24', 'SA_REP', 6400, .1, 80, 147);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(167, 'Amit Banda', 'ABANDA', '011.44.1346.729268', '2008-04-21', 'SA_REP', 6200, .1, 80, 147);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(168, 'Lisa Ozer', 'LOZER', '011.44.1343.929268', '2005-03-11', 'SA_REP', 11500, .25, 80, 148);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(169, 'Harrison Bloom', 'HBLOOM', '011.44.1343.829268', '2006-03-23', 'SA_REP', 10000, .2, 80, 148);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(170, 'Tayler Fox', 'TFOX', '011.44.1343.729268', '2006-01-24', 'SA_REP', 9600, .2, 80, 148);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(171, 'William Smith', 'WSMITH', '011.44.1343.629268', '2007-02-23', 'SA_REP', 7400, .15, 80, 148);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(172, 'Elizabeth Bates', 'EBATES', '011.44.1343.529268', '2007-03-24', 'SA_REP', 7300, .15, 80, 148);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(173, 'Sundita Kumar', 'SKUMAR', '011.44.1343.329268', '2008-04-21', 'SA_REP', 6100, .1, 80, 148);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(174, 'Ellen Abel', 'EABEL', '011.44.1644.429267', '2004-05-11', 'SA_REP', 11000, .3, 80, 149);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(175, 'Alyssa Hutton', 'AHUTTON', '011.44.1644.429266', '2005-03-19', 'SA_REP', 8800, .25, 80, 149);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(176, 'Jonathon Taylor', 'JTAYLOR', '011.44.1644.429265', '2006-03-24', 'SA_REP', 8600, .2, 80, 149);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(177, 'Jack Livingston', 'JLIVINGS', '011.44.1644.429264', '2006-04-23', 'SA_REP', 8400, .2, 80, 149);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(178, 'Kimberely Grant', 'KGRANT', '011.44.1644.429263', '2007-05-24', 'SA_REP', 7000, .15, null, 149);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(179, 'Charles Johnson', 'CJOHNSON', '011.44.1644.429262', '2008-01-04', 'SA_REP', 6200, .1, 80, 149);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(180, 'Winston Taylor', 'WTAYLOR', '650.507.9876', '2006-01-24', 'SH_CLERK', 3200, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(181, 'Jean Fleaur', 'JFLEAUR', '650.507.9877', '2006-02-23', 'SH_CLERK', 3100, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(182, 'Martha Sullivan', 'MSULLIVA', '650.507.9878', '2007-06-21', 'SH_CLERK', 2500, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(183, 'Girard Geoni', 'GGEONI', '650.507.9879', '2008-02-03', 'SH_CLERK', 2800, null, 50, 120);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(184, 'Nandita Sarchand', 'NSARCHAN', '650.509.1876', '2004-01-27', 'SH_CLERK', 4200, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(185, 'Alexis Bull', 'ABULL', '650.509.2876', '2005-02-20', 'SH_CLERK', 4100, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(186, 'Julia Dellinger', 'JDELLING', '650.509.3876', '2006-06-24', 'SH_CLERK', 3400, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(187, 'Anthony Cabrio', 'ACABRIO', '650.509.4876', '2007-02-07', 'SH_CLERK', 3000, null, 50, 121);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(188, 'Kelly Chung', 'KCHUNG', '650.505.1876', '2005-06-14', 'SH_CLERK', 3800, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(189, 'Jennifer Dilly', 'JDILLY', '650.505.2876', '2005-08-13', 'SH_CLERK', 3600, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(190, 'Timothy Gates', 'TGATES', '650.505.3876', '2006-07-11', 'SH_CLERK', 2900, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(191, 'Randall Perkins', 'RPERKINS', '650.505.4876', '2007-12-19', 'SH_CLERK', 2500, null, 50, 122);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(192, 'Sarah Bell', 'SBELL', '650.501.1876', '2004-02-04', 'SH_CLERK', 4000, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(193, 'Britney Everett', 'BEVERETT', '650.501.2876', '2005-03-03', 'SH_CLERK', 3900, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(194, 'Samuel McCain', 'SMCCAIN', '650.501.3876', '2006-07-01', 'SH_CLERK', 3200, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(195, 'Vance Jones', 'VJONES', '650.501.4876', '2007-03-17', 'SH_CLERK', 2800, null, 50, 123);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(196, 'Alana Walsh', 'AWALSH', '650.507.9811', '2006-04-24', 'SH_CLERK', 3100, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(197, 'Kevin Feeney', 'KFEENEY', '650.507.9822', '2006-05-23', 'SH_CLERK', 3000, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(198, 'Donald OConnell', 'DOCONNEL', '650.507.9833', '2007-06-21', 'SH_CLERK', 2600, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(199, 'Douglas Grant', 'DGRANT', '650.507.9844', '2008-01-13', 'SH_CLERK', 2600, null, 50, 124);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(200, 'Jennifer Whalen', 'JWHALEN', '515.123.4444', '2003-09-17', 'AD_ASST', 4400, null, 10, 101);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(201, 'Michael Hartstein', 'MHARTSTE', '515.123.5555', '2004-02-17', 'MK_MAN', 13000, null, 20, 100);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(202, 'Pat Fay', 'PFAY', '603.123.6666', '2005-08-17', 'MK_REP', 6000, null, 20, 201);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(203, 'Susan Mavris', 'SMAVRIS', '515.123.7777', '2002-06-07', 'HR_REP', 6500, null, 40, 101);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(204, 'Hermann Baer', 'HBAER', '515.123.8888', '2002-06-07', 'PR_REP', 10000, null, 70, 101);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(205, 'Shelley Higgins', 'SHIGGINS', '515.123.8080', '2002-06-07', 'AC_MGR', 12008, null, 110, 101);
INSERT INTO empregados (id_empregado, nome, email, 
telefone, data_contratacao, id_cargo, salario, 
comissao, id_departamento, id_supervisor) VALUES 
(206, 'William Gietz', 'WGIETZ', '515.123.8181', '2002-06-07', 'AC_ACCOUNT', 8300, null, 110, 205);


-- Dados da tabela de Historico_cargos
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (102, '2001-01-13', '2006-07-24',
 'IT_PROG',
 60 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (101, '1997-09-21', '2001-10-27',
 'AC_ACCOUNT',
 110 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (101, '2001-10-28', '2005-03-15',
 'AC_MGR',
 110 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (201, '2004-02-17', '2007-12-19',
 'MK_REP',
 20 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (114, '2006-03-24', '2007-12-31',
 'ST_CLERK',
 50 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (122, '2007-01-01', '2007-12-31',
 'ST_CLERK',
 50 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (200, '1995-09-17', '2001-06-17',
 'AD_ASST',
 90 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (176, '2006-03-24', '2006-12-31',
 'SA_REP',
 80 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (176, '2007-01-01', '2007-12-31',
 'SA_MAN',
 80 );
INSERT INTO historico_cargos (Id_empregado, data_inicial, data_final, id_cargo, id_departamento)
VALUES (200, '2002-07-01', '2006-12-31',
 'AC_ACCOUNT',
 90 );



-- String para adicionar uma chave estrangeira na tabela HISTORICO_CARGOS referênciando a tabela CARGOS e sua chave primária na coluna id_cargo
ALTER TABLE historico_cargos ADD CONSTRAINT cargos_historico_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

-- String para adicionar uma chave estrangeira na tabela EMPREGADOS referênciando a tabela CARGOS e sua chave primária na coluna id_cargo
ALTER TABLE empregados ADD CONSTRAINT cargos_empregados_fk
FOREIGN KEY (id_cargo)
REFERENCES cargos (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- String para adicionar uma chave estrangeira na tabela PAISES referênciando a tabela REGIOES e sua chave primária na coluna id_regiao
ALTER TABLE paises ADD CONSTRAINT regioes_paises_fk
FOREIGN KEY (Id_regiao)
REFERENCES regioes (Id_regiao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- String para adicionar uma chave estrangeira na tabela LOCALIZACOES referênciando a tabela PAISES e sua chave primária na coluna id_pais
ALTER TABLE localizacoes ADD CONSTRAINT paises_localizacoes_fk
FOREIGN KEY (id_pais)
REFERENCES paises (id_pais)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- String para adicionar uma chave estrangeira na tabela DEPARTAMENTOS referênciando a tabela LOCALIZACOES e sua chave primária na coluna id_localizacao
ALTER TABLE departamentos ADD CONSTRAINT localizacoes_departamentos_fk
FOREIGN KEY (id_localizacao)
REFERENCES localizacoes (id_localizacao)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- String para adicionar uma chave estrangeira na tabela EMPREGADOS referênciando a própria tabela EMPREGADOS e sua chave primária na coluna id_empregado, criando um auto-relacionamento
ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (id_supervisor)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
DEFERRABLE INITIALLY DEFERRED;

-- String para adicionar uma chave estrangeira na tabela HISTORICO_CARGOS referênciando a tabela DEPARTAMENTOS e sua chave primária na coluna id_departamento
ALTER TABLE historico_cargos ADD CONSTRAINT departamentos_historico_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- String para adicionar uma chave estrangeira na tabela EMPREGADOS referênciando a tabela DEPARTAMENTOS e sua chave primária na coluna id_departamento
ALTER TABLE empregados ADD CONSTRAINT departamentos_empregados_fk
FOREIGN KEY (id_departamento)
REFERENCES departamentos (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- String para adicionar uma chave estrangeira na tabela HISTORICO_CARGOS referênciando a tabela EMPREGADOS e sua chave primária na coluna id_empregado
ALTER TABLE historico_cargos ADD CONSTRAINT empregados_historico_cargos_fk
FOREIGN KEY (id_empregado)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- String para adicionar uma chave estrangeira na tabela DEPARTAMENTOS referênciando a tabela EMPREGADOS e sua chave primária na coluna id_empregado
ALTER TABLE departamentos ADD CONSTRAINT empregados_departamentos_fk
FOREIGN KEY (id_gerente)
REFERENCES empregados (id_empregado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
