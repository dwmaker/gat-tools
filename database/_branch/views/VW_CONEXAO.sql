--------------------------------------------------------
--  DDL for View VW_CONEXAO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "CORE"."VW_CONEXAO" ("CD_CONEXAO", "CD_AMBIENTE", "CD_SISTEMA", "CD_CENARIO", "DS_CONEXAO") AS 
  SELECT 
dbl.db_link cd_conexao,
substr(dbl.db_link, instr(dbl.db_link, '_')+1, instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-instr(dbl.db_link, '_')-1) cd_ambiente,
case when instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1) > 0 then substr( dbl.db_link , instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1 , instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1) - instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-1) 
else substr(dbl.db_link,instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1, instr(dbl.db_link, '.NET', instr(dbl.db_link, '_' )) - instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)-1) end AS cd_sistema,
substr( dbl.db_link ,instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)+1 , instr(dbl.db_link, '.NET', instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)) - instr(dbl.db_link, '_', instr(dbl.db_link, '_', instr(dbl.db_link, '_')+1)+1)-1) AS cd_cenario,
HOST ds_conexao
FROM   user_db_links dbl
where dbl.db_link like 'GA^_%.NET' escape '^'
;
