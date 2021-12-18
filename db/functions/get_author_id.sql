create or replace function get_author_id(author_name text)
returns numeric
language plpgsql
as
$$
declare
    _id numeric;
    _f_name text;
    _l_name text;
begin
    _f_name := split_part(author_name,' ',1);
    _l_name := split_part(author_name,' ',2);

    select id into _id
    from author
    where f_name = _f_name
      and l_name = _l_name;

    return _id;
end
$$;

comment on function get_author_id is 'Returns the id of an author, if found, given their full name';

