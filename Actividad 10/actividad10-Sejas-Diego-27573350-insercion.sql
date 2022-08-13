/***************************************************************************************
Intro BD 2020 - Sintaxis básica de dialecto SQL MySQL:
Manual de consulta MySQL: https://dev.mysql.com/doc/refman/8.0/en/
Apunte 5-Elementos de SQL 5 - INSERCION .SQL
***************************************************************************************/

-- Establecemos el esquema sobre el que trabajamos:
use aerolinea;

-- Insertamos datos en la tabla PAIS:
insert into pais (nombre,descripcion)
	values
    ('Estados Unidos','pais de Norteamerica'),
	('Alemania','pais de Europa'),
	('Argentia','Pais de Sudamerica');
    
-- Insertamos datos en la tabla MARCA:
insert into marca (nombre,pais_idpais)
	values
    ('Cessna',1),
	('Beechcraft',1),
	('Fokker',2);

-- Insertamos datos en la tabla PROVINCIA:
insert into provincia (nombre)
	values 
    ('Buenos Aires'),
    ('CABA'),
    ('Cordoba'),
    ('La Pampa');
   
-- Insertamos datos en la tabla LOCALIDAD:
insert into localidad (nombre)
	values 
    ('Lanus'),
    ('CABA'),
    ('Avellaneda'),
    ('Lomas de Zamora');
    
    
 -- Insertamos datos en la tabla CALLE:
insert into calle (nombre)
	values 
    ('Ituzaingo'),
    ('Roca'),
    ('Campichuelo'),
    ('Meeks'),
    ('Mamberti'),
    ('Amenabar'),
    ('Capello'),
    ('San Martìn'),
    ('Azara'),
    ('Sarmiento'),
    ('Rivadavia'),
    ('Martinto'),
    ('Bolaños'),
    ('Loria'); 

-- Insertamos datos en la tabla DOMICILIO:
insert into domicilio (calle_idcalle,numero_calle,localidad_idlocalidad,provincia_idprovincia)
	values (1,123,1,1),
		   (2,4561,2,2),
           (3,6532,3,1),
           (4,562,4,1),
           (5,2356,1,1),
           (6,2345,2,2),
           (7,1589,4,1),
           (6,356,2,2),
           (4,1296,4,1),
           (8,3652,3,1),
           (8,2235,2,2),
           (9,1254,4,1),
           (10,500,1,1),
           (11,2351,2,2),
           (12,663,1,1),
           (13,1256,1,1),
           (14,333,4,1); 

-- Insertamos datos en la tabla AVION:
insert into avion (matricula,marca_codigo,modelo,fecha_entrada_servicio)
	values 
    ('LV-ABC',1,'Citation','2010-12-12'),
	('LV-CDE',2,'Baron','2011-10-01'),
	('LV-FGH',3,'F-27','2008-05-04'),
    ('LV-IJK',1,'Citation','2014-06-07'),
    ('LV-LMN',2,'King Air','2012-07-08');
  

-- Insertamos datos en la tabla PERSONA:
insert into persona (dni,nombre,apellido,domicilio_id_domicilio)
	values 
    ('11111111','Alejo','Barragan',1),
	('22222222','Andrès Alfredo','Casas',2),
    ('33333333','Barbara','Chaves',3),
    ('44444444','Brisa','Chimbo',4),
    ('55555555','Camila','Chudoba',5),
    ('66666666','Carlos','Cires',6),
    ('77777777','Carlos Sebastián','Cusato',7),
    ('88888888','Christian','Dominguez',8),
    ('99999999','Christian','Escullini',9),
    ('10111213','Christian','Feijoo',10),
    ('12345678','Federico Bernardo','Juarez',11),
    ('34567890','Franco','Lacoste',12),
    ('45678901','Mariana','Laime',13),
    ('56789123','Germán Ignacio','Lopez',14),
    ('67891234','Giuliano','Martinez',15),
    ('78912345','Adriana','Medina',16),
    ('90123456','Jair Alberto','Melgarejo',17);
  
-- Insertamos datos en la tabla PASAJERO:
insert into pasajero (persona_idpersona,viajero_frecuente)
	values 
    (1,'S'),
	(2,'S'),
    (3,'N'),
    (4,'S'),
    (5,'N'),
    (6,'S'),
    (7,'N'),
    (8,'S'),
    (9,'S'),
    (10,'S');
   
-- Insertamos datos en la tabla PILOTO:
insert into piloto (persona_idpersona,cuil,fecha_ingreso)
	values 
    (11,'20-12345678-8','1994-10-01'),
    (12,'20-34567890-1','2003-07-01'),
    (13,'27-45678901-1','2001-04-01'),
    (14,'20-56789123-3','2013-05-01'),
    (15,'20-67891234-4','2010-07-01'),
    (16,'27-78912345-5','2015-08-01'),
    (17,'20-90123456-6','2011-03-01');
    
-- Insertamos datos en la tabla AEROPUERTO:
insert into aeropuerto
	values 
    ('BUE','1994-10-01','CABA'),
    ('MDQ','Aeroparque Jorge Newbery','Mar Del Plata'),
    ('BRC','Teniente Luis Candelaria','San Carlos de Bariloche');
    
-- Insertamos datos en la tabla VUELO:
insert into vuelo (codigo,avion_matricula,aeropuerto_origen,aeropuerto_destino,fecha_hora_partida,fecha_hora_llegada,piloto_persona_idpersona)
	values 
    ('TT1234','LV-ABC','BUE','BRC','2018-05-01 20:00:00','2018-05-01 23:45:00',11),
    ('TT3456','LV-CDE','BUE','MDQ','2018-05-02 10:00:00','2018-05-02 12:00:00',16),
    ('TT1235','LV-ABC','BRC','BUE','2018-05-02 07:00:00','2018-05-02 10:50:00',11),
    ('TT1256','LV-FGH','BUE','MDQ','2018-05-02 08:00:00','2018-05-02 10:05:00',13),
    ('TT5632','LV-IJK','MDQ','BUE','2018-05-03 07:00:00','2018-05-03 09:15:00',14),
    ('TT3333','LV-LMN','BUE','BRC','2018-05-03 07:00:00','2018-05-03 10:50:00',11),
    ('TT1257','LV-FGH','BUE','MDQ','2018-05-04 08:00:00','2018-05-04 10:05:00',13),
    ('TT3457','LV-CDE','MDQ','BUE','2018-05-04 10:00:00','2018-05-04 12:00:00',16),
    ('TT5633','LV-IJK','BUE','MDQ','2018-05-05 07:00:00','2018-05-05 09:15:00',14);
    
-- Insertamos datos en la tabla VUELO:
insert into pasajero_por_vuelo
	values 
    ('TT1234',4),
    ('TT1234',5),
    ('TT1234',6),
    ('TT3456',7),
    ('TT3456',8),
    ('TT3456',9),
    ('TT1235',4),
    ('TT1235',5),
    ('TT1256',1),
    ('TT1256',2),
    ('TT1256',3),
    ('TT5632',7),
    ('TT5632',8),
    ('TT5632',9),
    ('TT3333',7),
    ('TT3333',8),
    ('TT3333',9),
    ('TT1257',2),
    ('TT3457',7),
    ('TT3457',8),
    ('TT3457',9),
    ('TT5633',7),
    ('TT5633',8),
    ('TT5633',9);
    