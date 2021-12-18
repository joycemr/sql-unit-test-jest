drop table if exists book cascade;

create table book (
    id numeric not null,
    author_id numeric,
    title text,
    pub_year text,
    primary key (id),
    constraint author_fk
        foreign key(author_id)
        references author(id)
);

create sequence book_seq
minvalue 10
owned by book.id;

create function new_book()
returns trigger
language plpgsql
as
$$
begin
    new.title := format_title(new.title);
    return new;
end
$$;

create trigger new_book
before insert
on book
for each row
execute function new_book();

