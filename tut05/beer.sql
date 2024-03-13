/*
 * Q7
 * Write a PLpgSQL function called hotelsIn() that takes a single argument 
 * giving the name of a suburb, 
 * and returns a text string containing the names of all hotels in that suburb, one per line.
 */
create or replace function hotelsIn(_addr text) returns text
as $$
declare
    res text := '';
    hotel text;
begin
    for hotel in 
        select name
        from Bars
        where _addr = addr
    loop
        res := res || hotel || e'\n';
    end loop;
    return res;
end
$$ language plpgsql;

/*
 * Q9
 * Write a PLpgSQL procedure happyHourPrice that accepts the name of a hotel, 
 * the name of a beer and the number of dollars to deduct from the price, 
 * and returns a new price.
 */
create or replace function happyHourPrice(_hotel text, _beer text, _discount real) returns text
as $$
declare
    _counter integer;
    _std_price real;
    _new_price real;
begin
    -- non-existent hotel (invalid hotel name)
    perform * from Bars where name = _hotel;
    if not found then
        return 'There is no hotel called ' || _hotel;
    end if;
    -- non-existent beer (invalid beer name)
    select count(*) into _counter from Beers where name = _beer;
    if _counter = 0 then
        return 'There is no beer called '|| _beer;
    end if;
    select price into _std_price
    from Sells
    where bar = _hotel and beer = _beer;

    -- beer not available at the specified hotel
    if not found then
        return 'The '|| _hotel || ' does not serve '||_beer;
    end if;

    _new_price := _std_price - _discount;
    -- invalid price reduction (e.g. making reduced price negative)
    if _new_price < 0 then
        return 'Price reduction is too large; '
               || _beer || ' only costs '
               || to_char(_std_price, '$9.99');
    end if;
    
    return 'Happy hour price for ' || _beer 
           || ' at ' || _hotel 
           || ' is ' || to_char(_new_price,'$9.99');
end
$$ language plpgsql;
