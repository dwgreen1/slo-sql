SELECT irn.iii_role_id AS "authorization number", irn.name AS "authorization name"
FROM iiienv.iii_user iu
         JOIN iiienv.iii_user_iii_role iuir ON iu.id = iuir.iii_user_id
         JOIN iiienv.iii_role_name irn ON iuir.iii_role_id = irn.iii_role_id
WHERE iu.name = 'bwc_ahart'
EXCEPT
SELECT irn.iii_role_id AS "authorization number", irn.name AS "authorization name"
FROM iiienv.iii_user iu
         JOIN iiienv.iii_user_iii_role iuir ON iu.id = iuir.iii_user_id
         JOIN iiienv.iii_role_name irn ON iuir.iii_role_id = irn.iii_role_id
WHERE iu.name = 'bwc_aklein'
ORDER BY "authorization number";
