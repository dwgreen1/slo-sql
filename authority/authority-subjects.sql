SELECT DISTINCT trim(regexp_replace(index_entry,
    '(“|;|:|\(|\)|\?| and | or |&c\.|&| in | an |,
    | the | for | on | so | with | to | by |”|’| be
    | that |\.{3}| near | same | \s+ )', ' ', 'g'))
FROM sierra_view.catmaint
WHERE condition_code_num = 1
  AND field ~'^d65'
ORDER BY 1;