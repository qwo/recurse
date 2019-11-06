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
    executions 

--- LongTail
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
    l 
-- Where before, having after
SELECT
    county
FROM
    executions
where
    ex_age >= 50
group by
    county
having
    count(*) > 2 
    
    -- The grouping columns don't necessarily have to be in the SELECT block.
    -- Even though it would be valid (in SQLite) for the reasons set forth in A Strange Query, it is poor form to have non-aggregate, non-grouping columns in the SELECT block.
SELECT
    county,
    ex_age / 10 AS decade_age,
    COUNT(*)
FROM
    executions
GROUP BY
    county,
    decade_age
    
 --- Subquery under ( ) 
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

--- executions need to introspect 
SELECT
  county,
  100.0 * COUNT(*) / (select count(*) from executions)
    AS percentage
FROM executions
GROUP BY county
ORDER BY percentage DESC

--- Execution Hiatuses
--- The JOIN command defaults to performing what is called an “inner join” in which unmatched rows are dropped.

SELECT
  last_ex_date AS start,
  ex_date AS end,
  JULIANDAY(ex_date) - JULIANDAY(last_ex_date)
    AS day_difference
FROM executions
JOIN (select 
	ex_number + 1 as ex_number,
	ex_date  as last_ex_date
from executions
) previous
  ON executions.ex_number = previous.ex_number
ORDER BY day_difference DESC
LIMIT 10