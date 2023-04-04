-- Banco de Dados Clínica Médica - Modelo Físico --

-- comando que cria o banco da clinica
create database clinica_medica;

-- comando que seleciona a database criada
use clinica_medica;

-- Criação das tabelas
CREATE TABLE paciente (
    cpf varchar(14) PRIMARY KEY,
    nome_paciente varchar(40),
    telefone varchar(14),
    numero_plano int,
    nome_plano varchar(20),
    tipo_plano varchar(10)
);

CREATE TABLE medico (
    crm int PRIMARY KEY,
    nome_medico varchar(30),
    especialidade varchar(20)
);

-- auto incremento --
-- identity (valor inicial, incremento) --
CREATE TABLE pedido_exame (
    numero_pedido int identity(300,1) PRIMARY KEY,
    resultado varchar(40), 
    data_exame date,
    valor_pagar money,
    fk_consulta_numero_consulta int,
    fk_exame_codigo int
);


-- auto incremento --
-- identity (valor inicial, incremento) --
CREATE TABLE consulta (
    numero_consulta int identity(3000,1) PRIMARY KEY,
    data_consulta date,
    horario_consulta time,
    fk_paciente_cpf varchar(14),
    fk_medico_crm int
);

CREATE TABLE exame (
    codigo int PRIMARY KEY,
	especificacao varchar(20),
    preco money
);
 
ALTER TABLE pedido_exame ADD CONSTRAINT FK_pedido_exame_2
    FOREIGN KEY (fk_consulta_numero_consulta)
    REFERENCES consulta (numero_consulta)
    ON DELETE CASCADE;
 
ALTER TABLE pedido_exame ADD CONSTRAINT FK_pedido_exame_3
    FOREIGN KEY (fk_exame_codigo)
    REFERENCES exame (codigo);
  
ALTER TABLE consulta ADD CONSTRAINT FK_consulta_2
    FOREIGN KEY (fk_paciente_cpf)
    REFERENCES paciente (cpf)
    ON DELETE CASCADE;
 
ALTER TABLE consulta ADD CONSTRAINT FK_consulta_3
    FOREIGN KEY (fk_medico_crm)
    REFERENCES medico (crm)
    ON DELETE CASCADE;

-- inclusão e seleção de dados ---------------------------------------------

-- tabela paciente
insert into paciente values ('111.222.333-44', 'Amanda Silva', '(21)99999-1111', 987654, 'PlanHealth', 'Premium');
insert into paciente values ('222.333.444-55', 'Luiz Santos', '(31)98888-2222', 765432, 'MedPlano', 'Básico');
insert into paciente values ('333.444.555-66', 'Julia Oliveira', '(11)97777-3333', 543219, 'Saudix', 'Especial');
insert into paciente values ('444.555.666-77', 'Gabriel Ferreira', '(41)96666-4444', 321456, 'Salus', 'Padrão');
insert into paciente values ('555.666.777-88', 'Mariana Costa', '(51)95555-5555', 234567, 'Saúde Fácil', 'Especial');


select * from paciente;

-- tabela medico
insert into medico values (123456, 'Carlos Ferreira', 'Dermatologia');
insert into medico values (234567, 'Fernanda Santos', 'Psiquiatria');
insert into medico values (345678, 'Pedro Henrique', 'Oftalmologia');
insert into medico values (456789, 'Isabela Gomes', 'Endocrinologia');
insert into medico values (567890, 'Joana Oliveira', 'Urologia');
insert into medico values (678901, 'Rafaela Silva', 'Pneumologia');
insert into medico values (789012, 'Lucas Mendes', 'Ginecologia');


select * from medico;

-- tabela exame
insert into exame values(10130,'Hemocultura',85.00);
insert into exame values(10140,'Urina Tipo I',70.00);
insert into exame values(10150,'Dosagem de PSA',150.00);
insert into exame values(10160,'Dosagem de TSH',80.00);
insert into exame values(10170,'Eletroencefalograma',180.00);
insert into exame values(10180,'Teste Ergométrico',250.00);
insert into exame values(10190,'Holter',350.00);
insert into exame values(10200,'Ultrassonografia',500.00);
insert into exame values(10210,'Densitometria Óssea',200.00);
insert into exame values(10220,'Exame de Fezes',90.00);
insert into exame values(10230,'Retossigmoidoscopia',320.00);

select * from exame;

-- campos 'auto incremento' não devem aparecer no insert
-- tabela consulta
insert into consulta values('2022/12/12','14:30','111.222.333-44',123456);
insert into consulta values('2022/12/13','08:30','222.333.444-55',234567);
insert into consulta values('2022/12/13','11:00','333.444.555-66',456789);
insert into consulta values('2022/12/14','10:00','444.555.666-77',345678);
insert into consulta values('2022/12/15','15:00','555.666.777-88',567890);
insert into consulta values('2022/12/16','10:00','111.222.333-44',678901);
insert into consulta values('2022/12/19','16:45','222.333.444-55',789012);
insert into consulta values('2022/12/19','18:00','333.444.555-66',123456);
insert into consulta values('2022/12/20','09:00','444.555.666-77',234567);
insert into consulta values('2022/12/20','14:20','555.666.777-88',456789);

select * from consulta;

-- campo 'auto incremento' não deve aparecer no insert
-- resultados possíveis: (normal, inconsistente, indeterminado, negativo, positivo)
insert into pedido_exame values('Normal','2022/12/15',0.00,3000,10130);
insert into pedido_exame values('','2022/12/19',0.00,3001,10140);
insert into pedido_exame values('','2022/12/16',0.00,3002,10150);
insert into pedido_exame values('Normal','2022/12/15',0.00,3003,10160);
insert into pedido_exame values('Inconsistente','2022/12/16',0.00,3004,10170);
insert into pedido_exame values('','2022/12/17',0.00,3005,10180);
insert into pedido_exame values('Normal','2022/12/21',0.00,3006,10190);
insert into pedido_exame values('','2022/12/22',0.00,3007,10200);
insert into pedido_exame values('','2022/12/22',0.00,3008,10210);

select * from pedido_exame;

use clinica_medica;

-- Deleta uma tabela no caso "pedido_exame".
delete from pedido_exame;

-- reinicia campo numero_pedido --> próximo 2200
-- DBCC CHECKIDENT('pedido_exame', RESEED, 2199)



-- Alteração de dados de tabelas -----------------------------------
select * from paciente;
update paciente set nome_paciente = 'Julio leão' where cpf = '222.333.444-55';
select * from paciente;

select * from medico;
update medico set especialidade = 'Ginecologia' where crm = 234567;
select * from medico;

select * from exame;
update exame set preco = 135.00 where codigo = 10140;
select * from exame;

-- Exclusão de registros de tabelas --------------------------

select * from paciente;
delete from paciente where cpf = '222.333.444-55';
select * from paciente;

select * from medico;
delete from medico where crm = 234567;
select * from medico;
