CREATE OR REPLACE PACKAGE core.pkg_mapa IS
	TYPE tab_usuario IS TABLE OF VARCHAR2(64) INDEX BY VARCHAR2(64);
	TYPE rec_servidor IS RECORD
	(
		conexao tb_mapa_servidor.ds_conexao%type,
		usuarios tab_usuario
	);
	TYPE rec_tecnologia IS TABLE OF rec_servidor INDEX BY VARCHAR2(64);
	TYPE tab_tecnologia IS TABLE OF rec_tecnologia INDEX BY tb_mapa_servidor.cd_tecnologia%type;
	TYPE rec_mapa IS RECORD
	(
		nome tb_mapa.nm_mapa%type,
		descricao tb_mapa.ds_mapa%type,
		nr_versao tb_mapa.nr_versao%type,
		cd_ambiente tb_mapa.cd_ambiente%type,
		tp_mapa tb_mapa.tp_mapa%type,
		id_mapa_template tb_mapa.id_mapa_template%type,
		tecnologias tab_tecnologia
	);
	
	TYPE tab_tp_mapa IS TABLE OF tb_mapa.tp_mapa%type INDEX BY binary_integer;
	
	TYPE rec_filtro IS RECORD
	(
		tp_mapa_in tab_tp_mapa
	);
	
	PROCEDURE del_mapa ( id in tb_mapa.id_mapa%type, nm_usuario_atual tb_mapa.nm_usuario_alteracao%type, dt_atual tb_mapa.dt_alteracao%type);
	
	PROCEDURE mrg_mapa ( id in OUT tb_mapa.id_mapa%type, obj_mapa IN rec_mapa, nm_usuario_atual tb_mapa.nm_usuario_alteracao%type, dt_atual tb_mapa.dt_alteracao%type);
	
	FUNCTION get_mapa ( id IN tb_mapa.id_mapa%type) RETURN rec_mapa;
	
	FUNCTION lst_mapa(obj_filtro rec_filtro) RETURN SYS_REFCURSOR;
	
	function to_json(obj_mapa rec_mapa) return varchar2;
	
END pkg_mapa;
/
