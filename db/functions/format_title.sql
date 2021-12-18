create or replace function format_title(title text)
returns text
language plpgsql
as
$$
declare
    _title_array text[];
    _word text;
    _formatted_title text;
begin
    -- only capitalize words not marked as 'lower_case' in the title_format table
    foreach _word in array string_to_array(title, ' ') loop
        _word := lower(_word);
        if _word not in (select word from title_format where rule = 'lower_case') then
            -- special case for titles with an apostrophe
            if strpos(_word, '''') > 0 then
                _word := upper(substr(_word, 1, 1)) || substr(_word, 2);
            else
                _word = initcap(_word);
            end if;
        end if;
        _title_array := array_append(_title_array, _word);
    end loop;

    -- trim any extra space
    _formatted_title := trim((array_to_string(_title_array, ' ')));

    -- make sure the first word is capitalized
    _formatted_title := upper(substr(_formatted_title, 1, 1)) || substr(_formatted_title, 2);

    return _formatted_title;
end
$$;

comment on function format_title is 'Returns a formatted book title string';

