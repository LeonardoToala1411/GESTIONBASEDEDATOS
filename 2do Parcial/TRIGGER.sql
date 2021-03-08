/*Trigger*/
create or replace function tg_asignarempleado() returns trigger
as
$tg_asignarempleado$
    declare
        solicitudfecha date;
		cantidad int;
begin
        Select s.solicitud_fecha into solicitudfecha from solicitud s
		INNER JOIN servicio_mudanza sm on s.solicitud_id = sm.solicitud_id
		where sm.servicio_id = NEW.servicio_id;
		
		select count(*) into cantidad from solicitud s
		INNER JOIN servicio_mudanza sm on s.solicitud_id = sm.solicitud_id
		INNER JOIN empleado_asignado ea on sm.servicio_id = ea.servicio_id
		where s.solicitud_fecha = solicitudfecha and ea.empleado_cedula = NEW.empleado_cedula;
		
        if(cantidad>0) then
            raise exception 'Ya se asgino este empleado a un servicio en este dia';
        end if;
        return new;
end;
$tg_asignarempleado$
language plpgsql;

create trigger tg_asignarempleado before insert OR UPDATE
on empleado_asignado for each row
execute procedure tg_asignarempleado();