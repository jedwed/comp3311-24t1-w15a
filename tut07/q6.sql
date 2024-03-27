create table R(
    a int, 
    b int, 
    c text, 
    -- we want primary key (a, b)
);

create or replace function check_primary_key() returns trigger
as $$
begin
    -- primary key being inserted is not null
    if new.a is null or new.b is null then
        raise exception 'Error: primary key cannot be null';
    end if;

    if TG_OP = 'update' and old.a = new.a = old.b = new.b then
        return new;
    end if;
    perform from R where a = new.a and b = new.b
    if found then 
        raise exception 'Error: primary key already exists in R';
    end if;
    return new;
end
$$ language plpsql;

create trigger PrimaryKeyConstraint
before insert or update
on R
execute check_primary_key()

