--- Innocence
-- Conclusion and Recap
select
    1.0 * count(
        CASE
            WHEN last_statement LIKE '%innocent%' THEN 1
            ELSE NULL
        END
    ) / COUNT(*)
from
    executions --- LongTail
SELECT
    county,
    COUNT(*) AS county_executions
FROM
    executions
GROUP BY
    county
ORDER BY
    county_executions desc
SELECT
    county,
    last_statement is not null as l,
    COUNT(*) AS county_executions
FROM
    executions
group by
    county,
    l -- Where before, having after
SELECT
    county
FROM
    executions
where
    ex_age >= 50
group by
    county
having
    count(*) > 2 -- The grouping columns don't necessarily have to be in the SELECT block.
    -- Even though it would be valid (in SQLite) for the reasons set forth in A Strange Query, it is poor form to have non-aggregate, non-grouping columns in the SELECT block.
SELECT
    county,
    ex_age / 10 AS decade_age,
    COUNT(*)
FROM
    executions
GROUP BY
    county,
    decade_age --- Subquery under ( ) 
SELECT
    first_name,
    last_name
FROM
    executions
WHERE
    LENGTH(last_statement) = (
        SELECT
            MAX(LENGTH(last_statement))
        from
            executions
    )