
CREATE TABLE genre (
    ID_GENRE serial primary key ,
    NAME_GENRE VARCHAR (30) not null
) ;

CREATE TABLE book (
    COD_BOOK serial primary key,
    FK_COD_AUTHOR smallint not null,
	TITLE VARCHAR (300) not null,
	LANGUAGES VARCHAR (20),
	GENRE smallint not null,
    WRITTEN_YEAR INTEGER,
    constraint fk_id_genre foreign key (genre) references Genre (ID_GENRE),
    constraint fk_cod_book foreign key (fk_cod_author) references author (cod_author)
);

-- Coluna deleta, pois não havia necessidade, pois o registro de relação se dará na tabela REGISTER
alter table book drop column fk_cod_author;

-- Limpeza da tabela para inserção dos registros de livros, respeitando o registro único para cada obra
truncate table book cascade;

CREATE TABLE Address (
    ZIP_CODE INTEGER not null primary key,
    STATE VARCHAR(30),
    CITY VARCHAR(50)
);

CREATE TABLE Publishing (
    COD_PUBLISHING serial primary key,
    FK_ADDRESS INTEGER not null,
	NAME VARCHAR(120) not null,
    TELEPHONE varchar (30),
    constraint fk_address_zip_code foreign key (fk_address) references address (zip_code)
);

CREATE TABLE Author (
    COD_AUTHOR serial PRIMARY KEY,
	FULL_NAME VARCHAR (100) not null,
	SEX VARCHAR (15),
	BORN_DATE DATE,
	COUNTRY VARCHAR (40),
    BIO VARCHAR (500)            
);

CREATE TABLE Edition (
    ISBN char (13) PRIMARY key,
	FK_COD_PUBLISHING smallint not null,
    FK_COD_BOOK smallint not null,
    PAGES smallint not null,
    PUBLICATION_YEAR char (4) not null,
    PRICE money not null,
    AMOUNT smallint not null,
    constraint fk_cod_publishing foreign key (fk_cod_publishing) references publishing (cod_publishing),
    constraint fk_cod_book foreign key (fk_cod_book) references book (cod_book)    
);

CREATE TABLE Register (
    FK_COD_AUTHOR smallint,
    FK_COD_BOOK smallint,
    --COD_REGISTER smallint generated always as (concat(fk_cod_author, fk_cod_book)) stored,
    CURRENT_AMOUNT smallint not null,
    REGISTER_DATE date not null default current_date,
    constraint PK_ID_REGISTER primary key (FK_COD_AUTHOR, FK_COD_BOOK),
    constraint fk_cod_author foreign key (fk_cod_author) references author (cod_author),
    constraint fk_cod_book foreign key (fk_cod_book) references book (cod_book)
);
