/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/*==============================================================*/

/*==============================================================*/
/* Table: CIUDAD                                                */
/*==============================================================*/
create table CIUDAD (
   CIUDAD_ID            SERIAL               not null,
   CIUDAD_NOMBRE        CHAR(256)            not null,
   constraint PK_CIUDAD primary key (CIUDAD_ID)
);

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLIENTE_CEDULA       CHAR(256)            not null,
   CLIENTE_NOMBRES      CHAR(256)            not null,
   CLIENTE_APELLIDOS    CHAR(256)            not null,
   CLIENTE_TELEFONO     CHAR(256)            not null,
   CLIENTE_DIRECCION    CHAR(256)            not null,
   constraint PK_CLIENTE primary key (CLIENTE_CEDULA)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   EMPLEADO_CEDULA      CHAR(256)            not null,
   SUCURSAL_ID          CHAR(256)            not null,
   TIPO_EMPLEADO_ID     INT4                 not null,
   EMPLEADO_NOMBRE      CHAR(256)            not null,
   EMPLEADO_TELEFONO    CHAR(256)            not null,
   EMPLEADO_DIRECCION   CHAR(256)            not null,
   constraint PK_EMPLEADO primary key (EMPLEADO_CEDULA)
);

/*==============================================================*/
/* Table: EMPLEADO_ASIGNADO                                     */
/*==============================================================*/
create table EMPLEADO_ASIGNADO (
   EMPLEADO_ASIGNADO_ID SERIAL               not null,
   SERVICIO_ID          INT4                 not null,
   EMPLEADO_CEDULA      CHAR(256)            not null,
   VEHICULO_SERVICIO_MUDANZA_ID INT4                 not null,
   constraint PK_EMPLEADO_ASIGNADO primary key (EMPLEADO_ASIGNADO_ID)
);

/*==============================================================*/
/* Table: EMPRESA                                               */
/*==============================================================*/
create table EMPRESA (
   EMPRESA_ID           SERIAL               not null,
   EMPRESA_NOMBRE       CHAR(256)            not null,
   constraint PK_EMPRESA primary key (EMPRESA_ID)
);

/*==============================================================*/
/* Table: SERVICIO_MUDANZA                                      */
/*==============================================================*/
create table SERVICIO_MUDANZA (
   SERVICIO_ID          SERIAL               not null,
   SUCURSAL_ID          CHAR(256)            not null,
   SOLICITUD_ID         INT4                 not null,
   SERVICIO_DISTANCIA   FLOAT8               not null,
   SERVICIO_VALORKM     FLOAT8               not null,
   constraint PK_SERVICIO_MUDANZA primary key (SERVICIO_ID)
);

/*==============================================================*/
/* Table: SOLICITUD                                             */
/*==============================================================*/
create table SOLICITUD (
   SOLICITUD_ID         SERIAL               not null,
   CLIENTE_CEDULA       CHAR(256)            not null,
   SERVICIO_ID          INT4                 null,
   CIUDAD_ID_ORIGEN     INT4                 null,
   CIUDAD_ID_DESTINO    INT4                 null,
   SOLICITUD_ORIGEN     CHAR(256)            not null,
   SOLICITUD_DESTINO    CHAR(256)            not null,
   SOLICITUD_FECHA      DATE                 not null,
   SOLICITUD_HORA       TIME                 not null,
   SOLICITUD_DESCRIPCION CHAR(256)            not null,
   constraint PK_SOLICITUD primary key (SOLICITUD_ID)
);

/*==============================================================*/
/* Table: SUCURSAL                                              */
/*==============================================================*/
create table SUCURSAL (
   SUCURSAL_ID          CHAR(256)            not null,
   CIUDAD_ID            INT4                 not null,
   EMPRESA_ID           INT4                 not null,
   SUCURSAL_DIRECCION   CHAR(256)            not null,
   SUCURSAL_TELEFONO    CHAR(256)            not null,
   constraint PK_SUCURSAL primary key (SUCURSAL_ID)
);

/*==============================================================*/
/* Table: TIPO_EMPLEADO                                         */
/*==============================================================*/
create table TIPO_EMPLEADO (
   TIPO_EMPLEADO_ID     SERIAL               not null,
   TIPO_EMPLEADO_DESCRIPCION CHAR(256)            not null,
   constraint PK_TIPO_EMPLEADO primary key (TIPO_EMPLEADO_ID)
);

/*==============================================================*/
/* Table: VEHICULO                                              */
/*==============================================================*/
create table VEHICULO (
   VEHICULO_PLACA       CHAR(256)            not null,
   VEHICULO_MODELO      CHAR(256)            not null,
   VEHICULO_ANO         INT4                 not null,
   VEHICULO_MARCA       CHAR(256)            not null,
   constraint PK_VEHICULO primary key (VEHICULO_PLACA)
);

/*==============================================================*/
/* Table: VEHICULO_SERVICIO_MUDANZA                             */
/*==============================================================*/
create table VEHICULO_SERVICIO_MUDANZA (
   VEHICULO_SERVICIO_MUDANZA_ID SERIAL               not null,
   SERVICIO_ID          INT4                 not null,
   VEHICULO_PLACA       CHAR(256)            not null,
   constraint PK_VEHICULO_SERVICIO_MUDANZA primary key (VEHICULO_SERVICIO_MUDANZA_ID)
);

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_SUCURSAL foreign key (SUCURSAL_ID)
      references SUCURSAL (SUCURSAL_ID)
      on delete restrict on update restrict;

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_TIPO_EMP foreign key (TIPO_EMPLEADO_ID)
      references TIPO_EMPLEADO (TIPO_EMPLEADO_ID)
      on delete restrict on update restrict;

alter table EMPLEADO_ASIGNADO
   add constraint FK_EMPLEADO_RELATIONS_VEHICULO foreign key (VEHICULO_SERVICIO_MUDANZA_ID)
      references VEHICULO_SERVICIO_MUDANZA (VEHICULO_SERVICIO_MUDANZA_ID)
      on delete restrict on update restrict;

alter table EMPLEADO_ASIGNADO
   add constraint FK_EMPLEADO_RELATIONS_SERVICIO foreign key (SERVICIO_ID)
      references SERVICIO_MUDANZA (SERVICIO_ID)
      on delete restrict on update restrict;

alter table EMPLEADO_ASIGNADO
   add constraint FK_EMPLEADO_RELATIONS_EMPLEADO foreign key (EMPLEADO_CEDULA)
      references EMPLEADO (EMPLEADO_CEDULA)
      on delete restrict on update restrict;

alter table SERVICIO_MUDANZA
   add constraint FK_SERVICIO_RELATIONS_SOLICITU foreign key (SOLICITUD_ID)
      references SOLICITUD (SOLICITUD_ID)
      on delete restrict on update restrict;

alter table SERVICIO_MUDANZA
   add constraint FK_SERVICIO_RELATIONS_SUCURSAL foreign key (SUCURSAL_ID)
      references SUCURSAL (SUCURSAL_ID)
      on delete restrict on update restrict;

alter table SOLICITUD
   add constraint FK_SOLICITU_RELATIONS_CLIENTE foreign key (CLIENTE_CEDULA)
      references CLIENTE (CLIENTE_CEDULA)
      on delete restrict on update restrict;

alter table SOLICITUD
   add constraint FK_SOLICITU_RELATIONS_SERVICIO foreign key (SERVICIO_ID)
      references SERVICIO_MUDANZA (SERVICIO_ID)
      on delete restrict on update restrict;

alter table SOLICITUD
   add constraint FK_SOLICITUD_CIUDAD_ORIGEN foreign key (CIUDAD_ID_ORIGEN)
      references CIUDAD (CIUDAD_ID)
      on delete restrict on update restrict;

alter table SOLICITUD
   add constraint FK_SOLICITUD_CIUDAD_DESTINO foreign key (CIUDAD_ID_DESTINO)
      references CIUDAD (CIUDAD_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_RELATIONS_EMPRESA foreign key (EMPRESA_ID)
      references EMPRESA (EMPRESA_ID)
      on delete restrict on update restrict;

alter table SUCURSAL
   add constraint FK_SUCURSAL_RELATIONS_CIUDAD foreign key (CIUDAD_ID)
      references CIUDAD (CIUDAD_ID)
      on delete restrict on update restrict;

alter table VEHICULO_SERVICIO_MUDANZA
   add constraint FK_VEHICULO_RELATIONS_VEHICULO foreign key (VEHICULO_PLACA)
      references VEHICULO (VEHICULO_PLACA)
      on delete restrict on update restrict;

alter table VEHICULO_SERVICIO_MUDANZA
   add constraint FK_VEHICULO_RELATIONS_SERVICIO foreign key (SERVICIO_ID)
      references SERVICIO_MUDANZA (SERVICIO_ID)
      on delete restrict on update restrict;

