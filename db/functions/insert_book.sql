create or replace function insert_book(title text, pub_year text, author text)
returns numeric
language plpgsql
as
$$
declare
    new_book book;
begin
    new_book.author_id := get_author_id(insert_book.author);
    if new_book.author_id is null then
        raise exception 'Author: % not found', insert_book.author;
        return null;
    end if;

    new_book.id := nextval('book_seq');
    new_book.title := insert_book.title;
    new_book.pub_year := insert_book.pub_year;

    insert into book values (new_book.*);

    return new_book.id;
end
$$;

comment on function insert_book is 'insert a new book into the database';

