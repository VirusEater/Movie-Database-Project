drop table if exists MovieLanguages;

create table MovieLanguages(
    tmdbID              int,
    originalLanguage    char(10),
    languages           text,
    primary key(tmdbID),
    foreign key(tmdbID) references Movies(tmdbID)
);

insert into MovieLanguages
    select id, original_language, spoken_languages
    from movies_metadata;