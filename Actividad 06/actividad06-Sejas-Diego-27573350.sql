-- Creación de esquema:
drop schema if exists farmacia;
create schema if not exists farmacia;

-- Establecemos el esquema sobre el que trabajamos:
use farmacia;

-- Creamos la tabla obra_social en el esquema activo:
create table obra_social(
	codigo int primary key,
	nombre varchar(45) not null,
	descripcion varchar(100) not null
);

-- Insertamos datos en la tabla:
insert into obra_social 
	values
    (1,"PAMI","Programa de Atención Médica Integral"),
	(2,"IOMA","Instituto de Obra Medico Asistencial"),
	(3,"OSECAC","Obra Social de Empleados de Comercio");

-- CREAR , ELIMINAR Y CREAR NUEVAMENTE LAS TABLAS , CALLE , LOCALIDAD Y PROVINCIA
-- Creamos la tabla calle.
create table calle(
	codigo int primary key,
	nombre varchar(45) not null
);

-- Eliminamos la tabla calle .
drop table calle;

-- Volvemos a crear nuevamente la tabla calle
create table calle(
	codigo int primary key,
	nombre varchar(45) not null
);

-- Cambiando el nombre de la tabla calle y volvemos a cambiarlo al original
alter table calle rename to cal;
alter table cal rename to calle;

-- Cambiando el nombre de la columna nombre a nom y volvemos a dejarlo al nonbre original
alter table calle change column nombre nom varchar(45);
alter table calle change column nom nombre varchar(45);


-- Creamos la tabla localidad 
create table localidad(
	codigo int primary key,
	nombre varchar(45) not null
);

-- Eliminamos la tabla localidad .
drop table localidad;

-- Volvemos a crear la tabla localidad 
create table localidad(
	codigo int primary key,
	nombre varchar(45) not null
);

-- Cambiar el nombre de la tabla localidad y volver a cambiarlo al original
alter table localidad rename to loca;
alter table loca rename to localidad;

-- Cambiando el nombre de la columna nombre a nom y volvemos a dejarlo al nonbre original
alter table localidad change column nombre nom varchar(50);
alter table localidad change column nom nombre varchar(45);


-- Creamos la tabla provincia 
create table provincia(
	codigo int primary key,
	nombre varchar(45) not null
);

-- Eliminamos la tabla provincia
drop table provincia;

-- Volvemos a crear la tabla provincia 
create table provincia(
	codigo int primary key,
	nombre varchar(45) not null
);

-- Cambiar el nombre de la tabla provincia y volver a cambiarlo al original
alter table provincia rename to prov;
alter table prov rename to provincia;

-- Cambiando el nomnre de la columna codigo a cod y volvemos a dejarlo al nonbre original
alter table provincia change column codigo cod int ;
alter table provincia change column cod codigo int ;

-- Insertamos datos en la tabla provincia:
-- Agregar en provincia: (1, Buenos Aires) y (2, CABA) 
insert into provincia 
	values
    (1,"Buenos Aires"),
    (2,"CABA");

-- Insertamos datos en la localidad:
-- Agregar en localidad: (1, Lanús), (2, Pompeya), (3, Avellaneda) 
insert into localidad 
	values
    (1,"Lanús"),
    (2,"Pompeya"),
    (3,"Avellaneda");
    
-- Insertamos datos en la calle:
-- Agregar en calles: (1, 9 de Julio) , (2, Hipólito Yrigoyen) , (3, Mitre), (4, Sáenz).
insert into calle 
	values
    (1,"9 de Julio"),
    (2,"Hipólito Yrigoyen"),
    (3,"Mitre"),
    (4,"Sáenz");
    
-- Consultamos los registos insertados en la tabla provincia
select codigo, nombre from provincia;

-- Consultamos los registos insertados en la tabla localidad
select codigo, nombre from localidad;

-- Consultamos los registos insertados en la tabla calle
select codigo, nombre from calle;

-- Consultamos los registos insertados en la tabla obra_social
select codigo, nombre, descripcion from obra_social;