/*
 * Q1
 */
create or replace function sqr(input integer) returns integer 
as $$
begin
    return input * input;
end
$$ language plpgsql;

/*
 * Q2
 */
create or replace function spread(input text) returns text
as $$
declare
    i integer := 1;
    res text := '';
begin
    while i <= length(input)
    loop
        res := res || substring(input from i for 1) || ' ';
        i := i + 1; 
    end loop;
    return res;
    -- define result string
    -- loop through all the characters 
end
$$ language plpgsql;

/*
 * Q3
 */
create or replace function seq(n integer) returns setof integer
as $$
begin
    for i in 1..n
    loop
        return next i;
    end loop;
end
$$ language plpgsql;

/*
 * Q4
 */
create or replace function seq(lo int, hi int, inc int) returns setof integer
as $$
begin
    if inc = 0 then
        return;
    elsif inc > 0 then
        for i in lo..hi by 2
        loop
            return next i;
        end loop;
        
    else    
    end if;
end
$$ language plpgsql;
