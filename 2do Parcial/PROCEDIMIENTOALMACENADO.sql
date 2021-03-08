/*Procedimiento Almacenado*/

create or replace function obtener_detalles_servicio(servicioid integer)
RETURNS TABLE (empleado_nombre char,
  empleado_cedula char,
  empleado_descripcion char,
  vehiculo_placa char)
as $BODY$
begin
	RETURN QUERY
    SELECT empleado.empleado_nombre,
	empleado.empleado_cedula,
	tipo_empleado.tipo_empleado_descripcion,
	vehiculo.vehiculo_placa 
	from empleado_asignado
	inner join public.servicio_mudanza on servicio_mudanza.servicio_id = empleado_asignado.servicio_id	
	inner join public.vehiculo_servicio_mudanza on vehiculo_servicio_mudanza.vehiculo_servicio_mudanza_id = empleado_asignado.vehiculo_servicio_mudanza_id
	inner join public.empleado on empleado.empleado_cedula = empleado_asignado.empleado_cedula
	inner join public.tipo_empleado on tipo_empleado.tipo_empleado_id = empleado.tipo_empleado_id
	inner join public.vehiculo on vehiculo.vehiculo_placa = vehiculo_servicio_mudanza.vehiculo_placa
	where servicio_mudanza.servicio_id = servicioid;
end
$BODY$ language plpgsql;