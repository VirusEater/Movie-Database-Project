drop table if exists Mojo_budget_update;

create table Mojo_budget_update(
    movie_id        char(10),
    title           varchar(255),
    year            int,
    trivia          varchar(2000),
    mpaa            char(5),
    release_date    char(50),
    run_time        char(20),
    distributor     varchar(50),
    director        varchar(50),
    writer          varchar(50),
    producer        varchar(50),
    composer        varchar(50),
    cinematographer varchar(50),
    main_actor_1    varchar(50),
    main_actor_2    varchar(50),
    main_actor_3    varchar(50),
    main_actor_4    varchar(50),
    budget          bigint,
    domestic        bigint,
    international   bigint,
    worldwide       bigint,
    genre_1         varchar(15),
    genre_2         varchar(15),
    genre_3         varchar(15),
    genre_4         varchar(15),
    html            varchar(255),
    primary key(movie_id)
    );

load data infile 
        '/var/lib/mysql-files/03-Movies/Mojo_budget_update.csv'
        into table Mojo_budget_update
    fields terminated by ','
    enclosed by '"'
    lines terminated by '\n'
    ignore 1 lines
    (movie_id, title, year, trivia, mpaa, release_date,
    run_time, distributor, director, writer, producer,
    composer, cinematographer, main_actor_1, main_actor_2,
    main_actor_3, main_actor_4, budget, @domestic, @international,
    @worldwide, genre_1, genre_2, genre_3, genre_4, html)
    set domestic = if(@domestic = '', null, @domestic),
        international = if(@international = '', null, @international),
        worldwide = if(@worldwide = '', null, @worldwide);