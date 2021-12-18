drop table if exists title_format cascade;

create table title_format (
    rule text not null,
    word text not null,
    primary key (rule, word)
);

insert into title_format
values
('lower_case', 'a'),
('lower_case', 'an'),
('lower_case', 'and'),
('lower_case', 'but'),
('lower_case', 'or'),
('lower_case', 'the'),
('lower_case', 'of'),
('lower_case', 'in'),
('lower_case', 'for'),
('lower_case', 'nor'),
('lower_case', 'no'),
('lower_case', 'on'),
('lower_case', 'at'),
('lower_case', 'to'),
('lower_case', 'from'),
('lower_case', 'by');
