/*Cursor*/

do $$
declare
	registro Record;

	Cur_servicio Cursor for select c.cliente_cedula,c.cliente_nombres, c.cliente_apellidos,c.cliente_telefono,c.cliente_direccion, ciu.ciudad_nombre as ciudad_origen, 
		s.solicitud_origen,ciudad.ciudad_nombre as ciudad_destino,s.solicitud_destino, s.solicitud_fecha,s.solicitud_descripcion,sm.servicio_distancia,sm.sucursal_id
		from cliente c 
		inner join solicitud s on s.cliente_cedula = c.cliente_cedula
		inner join servicio_mudanza sm on sm.solicitud_id = s.solicitud_id
		inner join ciudad ciu on ciu.ciudad_id = s.ciudad_id_origen
		inner join ciudad on ciudad.ciudad_id = s.ciudad_id_destino
		where sm.servicio_distancia>=180;
	begin
	for registro in Cur_servicio loop
	Raise notice 'Cédula del cliente: %,Nombres:  %,Apellidos: %,Teléfono: %,Dirección: %,Ciudad 0rigen: %,Direccion: %,Ciudad Destino: %,Direccion: %,Fecha: %,Descripción: %,Distancia: %,Sucursal: %', 
	registro.cliente_cedula, registro.cliente_nombres, registro.cliente_apellidos,registro.cliente_telefono,registro.cliente_direccion,registro.ciudad_origen,registro.solicitud_origen,registro.ciudad_destino,
	registro.solicitud_destino, registro.solicitud_fecha,registro.solicitud_descripcion,registro.servicio_distancia,registro.sucursal_id;
	end loop;
end $$
language 'plpgsql';