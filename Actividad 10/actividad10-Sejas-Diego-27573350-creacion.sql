/***************************************************************************************
Intro BD 2020 - Sintaxis básica de dialecto SQL MySQL:
Manual de consulta MySQL: https://dev.mysql.com/doc/refman/8.0/en/
Apunte 5-Elementos de SQL 5 - CREACION .SQL
***************************************************************************************/

-- Creación de esquema:
create schema if not exists aerolinea;

-- Establecemos el esquema sobre el que trabajamos:
use aerolinea;

-- Creamos la tabla CALLE
create table calle(
	idcalle int primary key AUTO_INCREMENT,
	nombre varchar(45) not null
);

-- Creamos la tabla PROVINCIA 
create table provincia(
	idprovincia int primary key AUTO_INCREMENT,
	nombre varchar(45) not null
);

-- Creamos la tabla LOCALIDAD 
create table localidad(
	idlocalidad int primary key AUTO_INCREMENT,
	nombre varchar(45) not null
);

-- Creamos la tabla DOMICILIO 
create table domicilio(
    id_domicilio int primary key AUTO_INCREMENT,
	calle_idcalle int not null,
    numero_calle int not null,
    localidad_idlocalidad int not null,
    provincia_idprovincia int not null,
    foreign key (provincia_idprovincia) references provincia(idprovincia),
    foreign key (calle_idcalle) references calle(idcalle),
    foreign key (localidad_idlocalidad) references localidad(idlocalidad)
);

-- Creamos la tabla PAIS
create table pais(
	idpais int primary key AUTO_INCREMENT,
	nombre varchar(100) not null,
	descripcion varchar(100) not null
);

-- Creamos la tabla MARCA , en el esquema activo
create table marca(
	codigo int primary key AUTO_INCREMENT,
	nombre varchar(100) not null,
    pais_idpais int not null,
    foreign key (pais_idpais) references pais(idpais)
);

-- Creamos la tabla AVION
create table avion(
	matricula char(6) primary key,
    marca_codigo int not null,
	modelo varchar(100) not null,
	fecha_entrada_servicio date not null,
    foreign key (marca_codigo) references marca(codigo)
);

-- Creamos la tabla PERSONA
create table persona(
	idpersona int primary key AUTO_INCREMENT,
	dni char(8) not null,
	nombre varchar(45) not null,
	apellido varchar(45)not null,
	domicilio_id_domicilio int not null,
    foreign key (domicilio_id_domicilio) references domicilio(id_domicilio)
);


-- Creamos la tabla PASAJERO
create table pasajero(
	persona_idpersona int primary key,
    viajero_frecuente char(1),
    foreign key (persona_idpersona) references persona(idpersona)
);

-- Creamos la tabla PILOTO
create table piloto(
	persona_idpersona int primary key,
	cuil char(13),
	fecha_ingreso date not null,
	foreign key (persona_idpersona) references persona(idpersona)
);

-- Creamos la tabla AEROPUERTO
create table aeropuerto(
	codigo char(3) primary key,
	nombre varchar (100) not null,
	ciudad varchar(70) not null
);

-- Creamos la tabla VUELO
create table vuelo(
	codigo char(6) primary key,
	avion_matricula char(6) not null,
    aeropuerto_origen char(3) not null,
    aeropuerto_destino char(3) not null,
    fecha_hora_partida datetime not null,
    fecha_hora_llegada datetime not null,
    piloto_persona_idpersona int not null,
    foreign key (avion_matricula) references avion(matricula),
    foreign key (aeropuerto_origen) references aeropuerto(codigo),
    foreign key (aeropuerto_destino) references aeropuerto(codigo),
	foreign key (piloto_persona_idpersona) references piloto(persona_idpersona)
);

-- Creamos la tabla PASAJERO_POR_VUELO
create table pasajero_por_vuelo(
	vuelo_codigo char(6) not null,
    pasajero_persona_idpersona int not null,
    primary key (vuelo_codigo,pasajero_persona_idpersona),
    foreign key (vuelo_codigo) references vuelo(codigo),
    foreign key (pasajero_persona_idpersona) references pasajero(persona_idpersona)
);

