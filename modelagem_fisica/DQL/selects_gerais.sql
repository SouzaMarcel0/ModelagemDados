

## Projetar a quantidade de livros cadastrados distintos na base de dados:
select distinct count(*) title from book b ;

## Projetando livros que foram escritos por mulheres com genero ficção

select g.name_genre , b.title , a.sex from book b inner join author a on
b.cod_book = a.cod_author 
inner join genre g on
b.genre = g.id_genre 
where g.name_genre = 'fiction' and a.sex = 'woman';

## Porjetando livros que foram escritos entre anos espcíficos:

select title from book b 
where written_year between 2018 and 2019;

## Projetando lista de Livros e seus respectivos autores com códigos de ambos, ordenado em ordem alfabetica

select b.cod_book , b.title, r.fk_cod_author as cod_author, a.full_name from book b 
inner join register r on
b.cod_book = r.fk_cod_book 
inner join author a  on
r.fk_cod_author = a.cod_author 
order by b.title ;

## Projetar lista de autores cadastrados que tem seu nome começando com a letra “L”:
select full_name from author a 
where full_name like 'L%';

## Projetar lista de livros com preços entre um valor minimo e maximo, ordenando do mais barato ao mais caro:

select b.title , e.price from edition e inner join book b on
e.fk_cod_book = b.cod_book 
where e.price between '34.00' and '60.00'
order by e.price ;

## Projetar valore Minimo, Maximo e a soma dos preços dos livros

select sum (price * amount) as Valor_Total from edition e ;

select min(e.price) as Mais_Barato from edition e ;

select  max(price) as Mais_Caro from edition e ;

## Projetando livros que foram escritos em anos específicos:
select * from book b 
where written_year in (2017, 2019);

## Projetando o genero sexual dos autores que não se identificaram como Homem ou Mulher:
select * from author a 
where sex != 'man' and sex != 'woman';

## Projetando a idade dos Authores (VIEW)
select full_name , (current_date - born_date)/365 as idade from author a 
order by idade;

## Consultando lista de livros que não são comuns entre as tabelas
select e.fk_cod_book , r.fk_cod_book  from edition e
full outer join register r on 
e.fk_cod_book = r.fk_cod_book ;

## View para consultar o total de Livros na tabela de registro e na tabela de edição

CREATE OR REPLACE VIEW public.qtde_total_livros
AS SELECT sum(r.current_amount) AS soma_register,
    sum(e.amount) AS soma_edition
   FROM register r
     JOIN edition e ON r.fk_cod_book = e.fk_cod_book;
    
select * from qtde_total_livros qtl ;

## Função para consultar média de 2 valores.

CREATE OR REPLACE FUNCTION public.fn_media(valor1 double precision, valor2 double precision)
 RETURNS double precision
 LANGUAGE plpgsql
AS $function$
declare 
	soma float;
	resultado float;
begin
	soma = (valor1 + valor2);
	resultado = (soma/2);
return
	resultado;
end; 
$function$
;

## Função para consultar preço por página de livro consultando pelo código do book

CREATE OR REPLACE FUNCTION public.fn_price_by_page(cod1 integer)
 RETURNS money
 LANGUAGE plpgsql
AS $function$
declare 
	cod int;
	resultado money;
begin
	cod = cod1;
	resultado = (select (price/pages) as price_by_page from edition e where fk_cod_book = cod);
return
resultado;
end; 
$function$
;

## Função/Select que consome dados de uma VIEW -------------

SELECT full_name, idade,
       CASE
           WHEN idade>= 0
                AND idade <= 10 THEN 'Novo'
           WHEN idade >= 11
                AND idade <= 30 THEN 'Adulto'
           WHEN idade >= 31 THEN 'Experiente'
       END Tempo_Vida
FROM age_author aa 
ORDER BY idade desc ;

###### Union ####

select fk_cod_book, current_amount from register r 
union all 
select fk_cod_book, amount from edition e 
order by fk_cod_book ;

## Tabela criada para guardar registros da Trigger ##

create table update_edition (
cod_isbn varchar (15),
price_b money,
amount_a integer
)

##--Trigger-----##

create or replace procedure insert_author (varchar, varchar, date, varchar, varchar) language 'plpgsql'
as $$
begin 
	insert into author (full_name, sex, born_date, country, bio) 
	values ($1, $2, $3, $4, $5);
commit;
end;
$$;

##Testando Trigger:
call insert_author ('Marcelo Souza', 'Man', '1988-12-09', 'Brazil', 'Simples e objetivo');
select * from author a 
where full_name like '%Marce%';








