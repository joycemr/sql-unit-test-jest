create or replace function throw_exception(input text)
returns text
language plpgsql
as
$$
begin
    if upper(input) != 'PASS' then
        RAISE EXCEPTION 'ERROR: This is a test Exception because you entered: %', throw_exception.input;
    end if;
    -- built in error codes: https://www.postgresql.org/docs/current/errcodes-appendix.html
    RETURN throw_exception.input;
end
$$;

comment on function throw_exception is 'Throws an exception for pytest to evaluate';

