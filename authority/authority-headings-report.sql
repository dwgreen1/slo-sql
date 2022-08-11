SET SEARCH_PATH to sierra_view;
SELECT CASE
         WHEN condition_code_num = '1' THEN 'Used for first time'
         WHEN condition_code_num = '2' THEN 'Invalid'
         WHEN condition_code_num = '3' THEN 'Duplicate Entry'
         WHEN condition_code_num = '4' THEN 'Blind Reference'
         WHEN condition_code_num = '5' THEN 'Duplicate Authority'
         WHEN condition_code_num = '6' THEN 'Updated Heading'
         WHEN condition_code_num = '7' THEN 'Near Match'
         WHEN condition_code_num = '8' THEN 'Busy Record'
         WHEN condition_code_num = '9' THEN 'Non-Unique 4XX'
         WHEN condition_code_num = '10' THEN 'Cross-Thesaurus'
         WHEN condition_code_num = '11' THEN 'Missing Form or |8'
         WHEN condition_code_num = '12' THEN 'Missing Form 2'
         END AS "Type",
       field,
       CASE
         WHEN index_tag = 'a' THEN 'AUTHOR'
         WHEN index_tag = 'd' THEN 'SUBJECT'
         WHEN index_tag = 't' THEN 'TITLE'
         WHEN index_tag = 'q' THEN 'SERIES'
         END AS "Tag",
      index_entry AS "Indexed As",
       correct_heading AS "Correct Heading is",
       record_metadata_id,
       author,
       title,
       program_code,
       iii_user_name
FROM catmaint
WHERE condition_code_num NOT IN (1, 6, 7)
ORDER BY condition_code_num, index_tag, record_metadata_id;