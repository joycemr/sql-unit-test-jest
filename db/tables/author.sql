drop table if exists author cascade;

create table author (
    id numeric not null,
    f_name text,
    l_name text,
    email text,
    primary key (id)
);

create sequence author_seq
minvalue 10
owned by author.id;

