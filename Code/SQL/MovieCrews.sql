drop table if exists MovieCrews;

create table MovieCrews(
    imdbID              char(10),
    director            varchar(50),
    writer              varchar(50),
    producer            varchar(50),
    composer            varchar(50),
    cinematographer     varchar(50),
    main_actor_1        varchar(50),
    main_actor_2        varchar(50),
    main_actor_3        varchar(50),
    main_actor_4        varchar(50),
    primary key(imdbID)
);

insert into MovieCrews
    select movie_id, director, writer, producer, composer,
            cinematographer, main_actor_1, main_actor_2, 
            main_actor_3, main_actor_4
    from Mojo_budget_update;