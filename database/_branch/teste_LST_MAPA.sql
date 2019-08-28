set serveroutput on;
variable v_return  refcursor;
declare
  obj_filtro core.pkg_mapa.rec_filtro;
  v_return sys_refcursor;
begin
	obj_filtro.tp_mapa_in(obj_filtro.tp_mapa_in.count) := 'M';
	v_return := core.pkg_mapa.lst_mapa(obj_filtro => obj_filtro);
	:v_return := v_return;
end;
/

print :v_return;