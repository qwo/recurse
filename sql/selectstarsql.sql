--- Innocence
-- Conclusion and Recap

SELECT
    1.0 * count(
        CASE WHEN last_statement LIKE '%innocent%' THEN
            1
        ELSE
            NULL
        END) / COUNT(*)
FROM
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
    county_executions DESC
    SELECT
        county,
        last_statement IS NOT NULL AS l,
        COUNT(*) AS county_executions
FROM
    executions
GROUP BY
    county,
    l
    -- Where before, having after
    SELECT
        county
    FROM
        executions
    WHERE
        ex_age >= 50
    GROUP BY
        county
    HAVING
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
        FROM
            executions)
    --- executions need to introspect
    SELECT
        county,
        100.0 * COUNT(*) / (
        SELECT
            count(*)
        FROM
            executions) AS percentage
FROM
    executions
GROUP BY
    county
ORDER BY
    percentage DESC
    --- Execution Hiatuses
    --- The JOIN command defaults to performing what is called an “inner join” in which unmatched rows are dropped.
    SELECT
        last_ex_date AS START,
        ex_date AS
END,
JULIANDAY (ex_date) - JULIANDAY (last_ex_date) AS day_difference
FROM
    executions
    JOIN (
        SELECT
            ex_number + 1 AS ex_number,
            ex_date AS last_ex_date
        FROM
            executions) previous ON executions.ex_number = previous.ex_number
ORDER BY
    day_difference DESC
LIMIT 10
--- Senators
WITH mutuals AS (
    SELECT DISTINCT
        c1.sponsor_name AS a,
        c2.sponsor_name AS b
    FROM
        cosponsors AS c1
        JOIN cosponsors AS c2 ON c1.sponsor_name = c2.cosponsor_name
            AND c2.sponsor_name = c1.cosponsor_name
)
    SELECT
        a AS senator,
        count(*) AS mc
FROM
    mutuals
GROUP BY
    senator
ORDER BY
    mc DESC
LIMIT 1
