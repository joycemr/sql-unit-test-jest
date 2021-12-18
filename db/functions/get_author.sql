create or replace function get_author(title text)
returns text
language plpgsql
as
$$
declare
    _author text;
begin
    select concat(f_name, ' ',l_name) into _author
    from author
    where id = (
        select author_id
        from book
        where lower(book.title) = lower(get_author.title)
    );
    return _author;
end
$$;

comment on function get_author is 'Returns the name of an author, if found, given a book title';

