create or replace function get_title_from_book(this_book book)
returns text
language plpgsql
as
$$
/*
Notice that this function takes in a book row as the input parameter.
It can be called in the database as follows:
select get_title_from_row(book) from book;
*/
begin
    return this_book.title;
end
$$;

comment on function get_title_from_book is 'Given a book, returns the authors name. 
    This highly contrived example is used to illustrate testing a function that takes a database row as a parameter.';

