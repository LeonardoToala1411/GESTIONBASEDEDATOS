--CONSULTA 1
SELECT sucursal.ciudad_id,
COUNT(sucursal.sucursal_id) AS CANTIDAD,
ciudad.ciudad_nombre,
sucursal.sucursal_id
FROM sucursal
INNER JOIN public.servicio_mudanza on servicio_mudanza.sucursal_id = sucursal.sucursal_id
INNER JOIN public.ciudad on ciudad.ciudad_id = sucursal.ciudad_id
group by sucursal.sucursal_id,ciudad.ciudad_nombre
ORDER BY CANTIDAD DESC limit 1;


--CONSULTA 2
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
where servicio_mudanza.servicio_id = 4;


--CONSULTA 3
SELECT empleado.empleado_cedula,
empleado.sucursal_id,
empleado.empleado_nombre,
empleado.empleado_telefono,
empleado.empleado_direccion,
COUNT(servicio_mudanza) AS CANTIDAD
from empleado
inner join public.sucursal on sucursal.sucursal_id = empleado.sucursal_id
inner join public.empleado_asignado on empleado_asignado.empleado_cedula = empleado.empleado_cedula
inner join public.servicio_mudanza on servicio_mudanza.servicio_id = empleado_asignado.servicio_id
where empleado.empleado_cedula = '1313888502'
group by empleado.empleado_cedula;



--CONSULTA 4
SELECt origen.ciudad_nombre as origen,
destino.ciudad_nombre as destino,
solicitud.solicitud_descripcion
from solicitud
inner join public.ciudad destino on destino.ciudad_id = solicitud.ciudad_id_destino
inner join public.ciudad origen on origen.ciudad_id = solicitud.ciudad_id_origen
where solicitud.solicitud_id = 8; 
