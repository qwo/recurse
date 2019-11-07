BEGIN
-- get a random row from a table
DECLARE @username VARCHAR(50)
SELECT @username = [Username] FROM (
    SELECT ROW_NUMBER() OVER(ORDER BY [Username]) [row], [Username]
    FROM [UserProfile]
) t 
WHERE t.row = 1 + (SELECT CAST(RAND() * COUNT(*) as INT) FROM [UserProfile])

print(@username)
END