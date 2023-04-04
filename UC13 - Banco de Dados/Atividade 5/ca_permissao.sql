
create login estagiario with password = 'Abc12345';

use clinica_medica;

create user usuario_consulta for login estagiario;

 grant select to usuario_consulta;

 grant insert to usuario_consulta;


-- consultar permissões de um usuário de uma base de dados
-- utilizando a stored procedure do sistema sp_helprotect
EXEC clinica_medica.dbo.sp_helprotect @username = 'usuario_consulta';


-- Teste de login com controle de acesso - comandos DML do SQL ---------------

use clinica_medica;

select * from paciente;

insert into paciente values('145.564.444.32','jauilo Ramos','(11)91234-5678',678901,'Inovamed','Básico');

 delete from paciente where cpf = '145.564.444.32';

-- insert into paciente values('789.012.345-67','Abílio Sanches','(11)99876-5432',901234,'Ultramed','Padrão');



-- Exclusão de usuário e login

-- drop user usuario_consulta;

-- drop login aluno;


