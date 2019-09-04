--------------------------------------------------------
--  DDL for View VW_MAPA
--------------------------------------------------------

  CREATE OR REPLACE VIEW "CORE"."VW_MAPA" AS 
  SELECT 
tmp.nm_mapa nm_mapa_modelo,
mmp.cd_ambiente,
mms.cd_tecnologia,
mms.cd_servidor,
mms.ds_conexao,
(select listagg(mmu.NM_USUARIO||'/'|| mmu.DS_SENHA, ',') within group(order by mmu.NM_USUARIO asc) from core.tb_mapa_usuario mmu where mmu.id_mapa_servidor = mms.id_mapa_servidor) usuarios
FROM
core.tb_mapa tmp
--left join core.tb_mapa_servidor tms on tmp.id_mapa = tms.id_mapa
left join core.tb_mapa mmp on mmp.id_mapa_template = tmp.id_mapa and mmp.tp_mapa='M'
left join core.tb_mapa_servidor mms on mmp.id_mapa = mms.id_mapa 
--and tms.cd_tecnologia = mms.cd_tecnologia
--and tms.cd_servidor = mms.cd_servidor
where tmp.tp_mapa='T'
;
