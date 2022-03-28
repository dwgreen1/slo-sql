WITH oclc_nums AS (
    SELECT DISTINCT oclc
    FROM OCLC
),
oclc_nums_019 AS (
    SELECT DISTINCT field019
    FROM OCLC
     )
SELECT *
FROM sierra
WHERE oclc NOT IN (
    SELECT *
    FROM oclc_nums
    UNION
    SELECT *
    FROM oclc_nums_019
)
