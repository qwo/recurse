-- Create Table
-- Enforce if guess correctly
-- Distinct combination
CREATE TYPE color AS ENUM ('R', 'G', 'V', 'B', 'O', 'Y');
DROP table guesses;

CREATE TABLE guesses (
    first color UNIQUE,
    second color UNIQUE,
    third color UNIQUE,
    fourth color UNIQUE
);

CREATE TABLE mastermind () inherits (guesses);
INSERT INTO guesses values ('R', 'G', 'B', 'Y');
INSERT INTO mastermind values ('R', 'G', 'B', 'Y');



-- INSERT INTO guesses values ('R', 'R', 'R', 'Y')
--- Matches Black
DROP FUNCTION  check_white;
DROP FUNCTION IF EXISTS check_white(guesses, mastermind) ;
CREATE FUNCTION check_white(guesses,  mastermind) RETURNS bigint AS $$

--     SELECT coalesce(
--         CASE WHEN  $1.first  = $2.first THEN 1 END,
--         CASE WHEN  $1.second  = $2.second THEN 1 END
--         );
--     SELECT sum(
--         when $1.first  = $2.first then 1 else 0 end)
--         $1.second  = $2.second
--         $1.third = $2.third);
$$ LANGUAGE SQL;

SELECT *, check_white(guesses.*, mastermind.*)
    FROM guesses, mastermind
    SELECT count(coalesce(
            guesses.* = mastermind.*, false
        )) as black from guesses left join mastermind on guesses.* = mastermind.*