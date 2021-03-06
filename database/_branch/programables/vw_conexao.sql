--------------------------------------------------------
--  DDL for View vw_my_db_links
--------------------------------------------------------

  CREATE OR REPLACE VIEW DBANOVOSMS.vw_conexao AS 
  SELECT 
dbl.db_link cd_conexao,
substr(dbl.db_link, instr(dbl.db_link, '_')+1, instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-instr(dbl.db_link, '_')-1) cd_ambiente,
case when instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1) > 0 then substr( dbl.db_link , instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1 , instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1) - instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-1) 
else substr(dbl.db_link,instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1, instr(dbl.db_link, '.NET', instr(dbl.db_link, '_' )) - instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-1) end AS cd_aplicacao,
substr( dbl.db_link ,instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)+1 , instr(dbl.db_link, '.NET', instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)) - instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)-1) AS cd_cenario,
username,
HOST ds_conexao
FROM   user_db_links dbl
where dbl.db_link like 'GA^_%.NET' escape '^'
;
