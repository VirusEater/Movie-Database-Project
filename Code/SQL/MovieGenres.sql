drop table if exists MovieGenres;

create table MovieGenres(imdbID     char(10),
                         genres     varchar(255),
                         primary key(imdbID)
                         );

insert ignore into MovieGenres
    select imdb_title_identifier, genres
    from boxofficemojo_releases;