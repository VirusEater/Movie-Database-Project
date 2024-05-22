drop table if exists Users;
create table Users(userID int auto_increment,
                   username varchar(255),
                   password varchar(255),
                   primary key (userID),
                   unique (username)
                  );