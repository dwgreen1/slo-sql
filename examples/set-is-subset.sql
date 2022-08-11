SELECT *,
       CASE
           WHEN regexp_split_to_array('2e,2g,2r,2s,2n,3a,3h,3l,3r', ',') && regexp_split_to_array(l.locations, ',')
               THEN 'irf'
           WHEN regexp_split_to_array('1p,1f', ',') && regexp_split_to_array(l.locations, ',') THEN 'pop'
           ELSE 'na'
           END as sort
FROM sierra_view.bib_locations as l


-- just fudging a CTE as a quick example...
WITH bibs AS (
    SELECT
    'ep,1p' as locations
)
SELECT
CASE
    WHEN regexp_split_to_array('1p,1f', ',') &&
        regexp_split_to_array(b.locations, ',') THEN 'pop'
    ELSE 'GTFO'
END as sort
FROM bibs as b