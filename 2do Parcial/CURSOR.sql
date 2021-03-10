/*Cursor*/
do $$
declare
	registro Record;
	Cur_servicio Cursor for select count(s.sucursal_id) as nro_servicios, s.sucursal_id from servicio_mudanza sm
				inner join sucursal s on s.sucursal_id = sm.sucursal_id
				group by s.sucursal_id;
	begin
	for registro in Cur_servicio loop
	Raise notice 'Nro Servicios: %,Sucursal:  %',registro.nro_servicios, registro.sucursal_id;
	end loop;
end $$
language 'plpgsql';