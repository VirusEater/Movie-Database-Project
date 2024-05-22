drop table if exists userRatings;
create table userRatings(userID int,
                         tmdbID int,
                         rating float,
                         primary key (userID, tmdbID),
                         foreign key (userID) references Users(userID) on delete cascade,
                         foreign key (tmdbID) references Movies(tmdbID) on delete cascade,
                         check (rating > 0 and rating <= 10)
                        );