create function dbo.COUNT_PULPITS(@faculty varchar(30))
returns int
as
begin
    return (select count(PULPIT) from PULPIT where FACULTY = @faculty);
end;
go

create function dbo.COUNT_GROUPS(@faculty varchar(30))
returns int
as
begin
    return (select count(IDGROUP) from GROUPS where FACULTY = @faculty);
end;
go

create function dbo.COUNT_PROFESSIONS(@faculty varchar(30))
returns int
as
begin
    return (select count(PROFESSION) from PROFESSION where FACULTY = @faculty);
end;
go

create function FACULTY_REPORT(@c int)
returns @fr table
(
    [факультет] varchar(50), [количество кафедр] int, [количество групп]  int, [количество студентов] int, [количество специальностей] int
)
as
begin 
    declare cc cursor static for 
    select FACULTY 
    from FACULTY 
    where dbo.COUNT_STUDENTS(FACULTY, default) > @c;

    declare @f varchar(30);
    open cc;  
    fetch cc into @f;
    while @@fetch_status = 0
    begin
        insert @fr values
        ( 
            @f,  
            dbo.COUNT_PULPITS(@f),
            dbo.COUNT_GROUPS(@f),   
            dbo.COUNT_STUDENTS(@f, default),
            dbo.COUNT_PROFESSIONS(@f)
        ); 
        fetch cc into @f;  
    end;   
    return; 
end;

select * from FACULTY_REPORT(0)



drop function FACULTY_REPORT
drop function dbo.COUNT_PULPITS
drop function dbo.COUNT_GROUPS
drop function dbo.COUNT_PROFESSIONS
drop function dbo.COUNT_PULPITS