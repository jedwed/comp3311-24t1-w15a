-- create or replace function add(state numeric, curr_val numeric) returns numeric
-- as $$
-- begin
--     return state + curr_val;
-- end
-- $$ language plpgsql;
--
-- create aggregate my_sum (numeric) (
--     sfunc = add,
--     stype = numeric,
--     initcond = 0
-- );

create type StateType as (sum numeric, count numeric);

create or replace function compute_state(state StateType, curr_val numeric) returns StateType
as $$
begin
    state.sum := state.sum + curr_val;
    state.count := state.count + 1;
    return state;
end
$$ language plpgsql;

create or replace function compute_average(state StateType) returns numeric
as $$
begin
    return state.sum / state.count;
end
$$ language plpgsql;

create aggregate my_average (numeric) (
    sfunc = compute_state,
    stype = StateType,
    initcond = '(0, 0)',
    finalfunc = compute_average
)
