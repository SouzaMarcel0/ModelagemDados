

CREATE TABLE tbl_book (
    COD_BOOK serial constraint pk_id_book PRIMARY KEY,
    TITLE VARCHAR (500) not null ,
    LANGUAGES VARCHAR (20) not null ,
    WRITTEN_YEAR INTEGER not null ,
    GENRE INTEGER not null,
    fk_Genre_ID_GENRE INTEGER
    );

CREATE TABLE tbl_author (
    COD_AUTHOR serial constraint pk_id_author PRIMARY KEY,
    FULL_NAME VARCHAR (100) not null,
    BORN_DATE DATE,
    BIO VARCHAR (1200),
    SEX VARCHAR (20),
    COUNTRY VARCHAR (100)
);

CREATE TABLE tbl_publishing (
    COD_PUBLISHING serial constraint pk_id_publishing PRIMARY KEY,
    NAME VARCHAR (100) not null,
    TELEPHONE INTEGER unique not null
);

CREATE TABLE tbl_country (
    COD_COUNTRY serial  constraint pk_id_country PRIMARY KEY,
    NAME_COUNTRY VARCHAR (100) not null
);

CREATE TABLE tbl_state (
    COD_STATE serial constraint pk_id_state PRIMARY KEY,
    NAME_STATE VARCHAR (40) not null,
    fk_Country_COD_COUNTRY INTEGER
);

CREATE TABLE tbl_city (
    COD_CITY serial  constraint pk_id_city PRIMARY KEY,
    NAME_CITY VARCHAR (100),
    fk_State_COD_STATE INTEGER
);

CREATE TABLE tbl_genre (
    ID_GENRE INTEGER constraint pk_id_genre PRIMARY KEY,
    NAME_GENRE VARCHAR (50)
);

CREATE TABLE tbl_register (
    fk_Author_COD_AUTHOR INTEGER,
    fk_Book_COD_BOOK INTEGER,
    ID_REGISTER INTEGER PRIMARY key,
    REGISTER_DATE date not null default current_date,
    CURRENT_AMOUNT INTEGER not null
        
);

CREATE TABLE tbl_edition (
    fk_Publishing_COD_PUBLISHING INTEGER,
    fk_Book_COD_BOOK INTEGER,
    PUBLICATION_YEAR INTEGER,
    ISBN INTEGER PRIMARY key,
    PAGES INTEGER,
    PRICE MONEY,
    AMOUNT INTEGER
    
);

CREATE TABLE tbl_address (
    fk_Country_COD_COUNTRY INTEGER,
    fk_Publishing_COD_PUBLISHING INTEGER,
    COD_ADDRESS INTEGER PRIMARY KEY
);

ALTER TABLE tbl_book ADD CONSTRAINT FK_Book_2
    FOREIGN KEY (fk_Genre_ID_GENRE)
    REFERENCES tbl_genre (ID_GENRE);
 
ALTER TABLE tbl_state ADD CONSTRAINT FK_State_2
    FOREIGN KEY (fk_Country_COD_COUNTRY)
    REFERENCES tbl_country (COD_COUNTRY);
 
ALTER TABLE tbl_city ADD CONSTRAINT FK_City_2
    FOREIGN KEY (fk_State_COD_STATE)
    REFERENCES tbl_state (COD_STATE);
 
ALTER TABLE tbl_register ADD CONSTRAINT FK_Register_1
    FOREIGN KEY (fk_Author_COD_AUTHOR)
    REFERENCES tbl_author (COD_AUTHOR);
 
ALTER TABLE tbl_register ADD CONSTRAINT FK_Register_2
    FOREIGN KEY (fk_Book_COD_BOOK)
    REFERENCES tbl_book (COD_BOOK);
 
ALTER TABLE tbl_edition ADD CONSTRAINT FK_Edition_2
    FOREIGN KEY (fk_Publishing_COD_PUBLISHING)
    REFERENCES tbl_publishing (COD_PUBLISHING);
 
ALTER TABLE tbl_edition ADD CONSTRAINT FK_Edition_3
    FOREIGN KEY (fk_Book_COD_BOOK)
    REFERENCES tbl_book (COD_BOOK);
 
ALTER TABLE tbl_address ADD CONSTRAINT FK_Address_1
    FOREIGN KEY (fk_Country_COD_COUNTRY)
    REFERENCES tbl_country (COD_COUNTRY);
 
ALTER TABLE tbl_address ADD CONSTRAINT FK_Address_2
    FOREIGN KEY (fk_Publishing_COD_PUBLISHING)
    REFERENCES tbl_publishing (COD_PUBLISHING);