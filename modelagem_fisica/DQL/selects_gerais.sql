

-- Projetando a tabela com todos os dados das tabelas:

select * from register r ;

select * from book b ;

select * from author a ;

select * from genre g ;

select * from address a ;

select * from publishing p ;

select * from edition e ;

-- Projetar a quantidade de livros cadastrados distintos na base de dados:
select distinct count(*) title from book b ;

-- Projetando livros que foram escritos por mulheres com genero ficção

select g.name_genre , b.title , a.sex from book b inner join author a on
b.cod_book = a.cod_author 
inner join genre g on
b.genre = g.id_genre 
where g.name_genre = 'fiction' and a.sex = 'woman';

-- Porjetando livros que foram escritos entre anos espcíficos:

select title from book b 
where written_year between 2018 and 2019;

-- Projetando lista de Livros e seus respectivos autores com códigos de ambos, ordenado em ordem alfabetica

select b.cod_book , b.title, r.fk_cod_author as cod_author, a.full_name from book b 
inner join register r on
b.cod_book = r.fk_cod_book 
inner join author a  on
r.fk_cod_author = a.cod_author 
order by b.title ;

--Projetar lista de autores cadastrados que tem seu nome começando com a letra “L”:
select full_name from author a 
where full_name like 'L%';

--Projetar lista de livros com preços entre um valor minimo e maximo, ordenando do mais barato ao mais caro:

select b.title , e.price from edition e inner join book b on
e.fk_cod_book = b.cod_book 
where e.price between '34.00' and '60.00'
order by e.price ;

--- Projetar valore Minimo, Maximo e a soma dos preços dos livros

select sum (price * amount) as Valor_Total from edition e ;

select min(e.price) as Mais_Barato from edition e ;

select  max(price) as Mais_Caro from edition e ;

-- Projetando livros que foram escritos em anos específicos:
select * from book b 
where written_year in (2017, 2019);

-- Projetando o genero sexual dos autores que não se identificaram como Homem ou Mulher:
select * from author a 
where sex != 'man' and sex != 'woman';

-- Projetando a idade dos Authores
select full_name , (current_date - born_date)/365 as idade from author a 
order by idade;


select title , genre from book b ;
group by title , genre 
having count(*) > 1;





