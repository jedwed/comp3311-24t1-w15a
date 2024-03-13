/*
 * Q12
 * Find the names of suppliers who supply some red part.
 */

-- select sname 
-- from   Suppliers
-- where  sid in (
--     select sid 
--     from   Catalog AS C
--     join   Parts AS P on C.pid = P.pid 
--     where  P.colour = 'red'
-- );
-- I stupidly wrote redundant outer queries like the above during the tutoral :/

select S.sname 
from   Suppliers as S
from   Catalog as C
join   Parts as P on C.pid = P.pid 
where  P.colour = 'red';

/*
 * Q13
 * Find the sids of suppliers who supply some red or green part.
 */

select sid 
from   Catalog as C
join   Parts as P on C.pid = P.pid 
where  P.colour = 'red' or P.colour = 'green';


/*
 * Q15
 * Find the sids of suppliers who supply some red part and some green part.
 */

-- select sid 
-- from   Catalog AS C
-- join   Parts AS P on C.pid = P.pid 
-- where  P.colour = 'red' and P.colour = 'green';

-- The above query fails. 
-- It's not possible for a record (or a tuple) to have a colour that is simultaneously red and green
-- To solve: use set operation INTERSECT

select C.sid
from Parts as P
join Catalog as C on P.pid = C.pid
where P.color='red'
intersect
select C.sid
from Parts as P
join Catalog as C on P.pid = C.pid
where P.color='green'
;


/*
 * Q16
 * Find the sids of suppliers who supply every part.
 */

-- Helpful to rephrase the question:
-- Find sids of suppliers for whomst there doesn't exist a part they don't supply
select S.sid
from Suppliers as S
where not exists (
    -- parts not supplied by sid = (set difference between) all parts supplied - all parts supplied by sid
    select pid
    from Parts
    except -- set difference
    select C.pid
    from Catalog AS C
    where C.sid = S.sid
);

/*
 * Q22
 * Find the pids of the most expensive part(s) supplied by suppliers named "Yosemite Sham".
 */
-- Find the pids supplied by Yosemite Sham
create view YosemiteSupplies (pid, cost)
as
select *
from Catalog as C
join Parts as P on C.pid = P.pid
where P.pname = 'Yosemite Sham'
;
-- Out of those parts, find the most expernsive one
-- select pid
-- from YosemiteSupllies
-- order by cost desc
-- limit 1;
-- BAD: assumes only one most expensive part

select pid
from YosemiteSupplies
where cost = (
    select max(cost) from YosemiteSupplies
)
