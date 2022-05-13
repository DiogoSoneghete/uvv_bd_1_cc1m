-- Exercicio 1

SELECT   numero_departamento, AVG (salario) AS "media_salarial"
FROM     funcionario
GROUP BY numero_departamento;

-- Exercicio 2

SELECT   sexo, AVG (salario) AS media_salario_genero
FROM     funcionario
GROUP BY sexo;

-- Exercicio 3

SELECT     departamento.nome_departamento, 
CONCAT     (primeiro_nome," ",nome_meio,".",ultimo_nome) AS nome_completo, 
   funcionario.data_nascimento, 
   YEAR(CURDATE()) - YEAR(data_nascimento) AS idade, 
   funcionario.salario AS salario
FROM       departamento
INNER JOIN funcionario ON departamento.numero_departamento=funcionario.numero_departamento;

-- Exercicio 4

SELECT CONCAT(primeiro_nome," ",nome_meio,".",ultimo_nome) AS nome_completo, YEAR(CURDATE()) - YEAR(data_nascimento) AS idade, salario, salario * 1.2 AS salario_reajuste
FROM          funcionario
WHERE         salario <35000
UNION 
SELECT CONCAT(primeiro_nome," ",nome_meio,".",ultimo_nome) AS nome_completo, YEAR(CURDATE()) - YEAR(data_nascimento) AS idade, salario, salario * 1.15 AS salario_reajuste
FROM          funcionario
WHERE         salario >=35000;