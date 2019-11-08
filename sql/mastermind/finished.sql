-- Create Table
-- Distinct combination
--- R :Red, B :Blue, G: Green, V: Violet, O: Orange, Y: Yellow
DROP TYPE IF EXISTS color cascade;CREATE TYPE color AS ENUM ('R', 'B', 'G', 'V', 'O', 'Y');

DROP TABLE IF EXISTS guesses cascade ; CREATE TABLE guesses (
    first color,
    second color,
    third color ,
    fourth color
);
CREATE TABLE mastermind () inherits (guesses);
INSERT INTO mastermind values ('R', 'G', 'R', 'G');


INSERT INTO guesses values ('R', 'G', 'G', 'R');
INSERT INTO guesses values ('R', 'G', 'R', 'R');
INSERT INTO guesses values ('R', 'G', 'R', 'G');
INSERT INTO guesses values ('Y', 'G', 'R', 'G');



--- Matches Black
CREATE OR REPLACE FUNCTION check_black(guesses,  mastermind) RETURNS integer AS $$
    SELECT (
        ($1.first  = $2.first)::int +
        ($1.second  = $2.second)::int +
        ($1.third = $2.third)::int +
        ($1.fourth = $2.fourth)::int
    );
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION check_white(guesses,  mastermind) RETURNS integer AS $$
    SELECT (
        case when ($1.first != $2.first) then (
                $1.first = $2.second or
                $1.first = $2.third or
                $1.first = $2.fourth
                )::int else 0 end +
        case when ($1.second != $2.second) then (
                $1.second = $2.first or
                $1.second = $2.third or
                $1.second = $2.fourth
                )::int else 0 end +
        case when ($1.third != $2.third) then (
                $1.third = $2.first or
                $1.third = $2.second or
                $1.third = $2.fourth
                )::int else 0 end +
        case when ($1.fourth != $2.fourth) then (
                $1.fourth = $2.first or
                $1.fourth = $2.second or
                $1.fourth = $2.third
                )::int else 0 end

    );
$$ LANGUAGE SQL;

SELECT guesses,
       check_black(guesses.*, mastermind.*),
       check_white(guesses.*, mastermind.*)
    FROM guesses, mastermind
