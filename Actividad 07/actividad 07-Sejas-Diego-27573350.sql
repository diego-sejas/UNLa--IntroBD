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

-- Creamos la tabla localidad 
create table localidad(
	idlocalidad int primary key,
	nombre varchar(45) not null
);

-- Agregar en localidad: (1, Lanús), (2, Pompeya), (3, Avellaneda) 
insert into localidad 
	values
    (1,"Lanús"),
    (2,"Pompeya"),
    (3,"Avellaneda");
    
-- Volvemos a crear la tabla provincia 
create table provincia(
	idprovincia int primary key,
	nombre varchar(45) not null
);

-- Insertamos datos a la table provincia
insert into provincia 
	values
    (1,"Buenos Aires"),
    (2,"CABA");
   
-- Creamos la tabla calle.
create table calle(
	idcalle int primary key,
	nombre varchar(45) not null
);

-- Insertamos datos en la calle:
-- Agregar en calles: (1, 9 de Julio) , (2, Hipólito Yrigoyen) , (3, Mitre), (4, Sáenz).
insert into calle 
	values
    (1,"9 de Julio"),
    (2,"Hipólito Yrigoyen"),
    (3,"Mitre"),
    (4,"Sáenz");

    
-- ----------------     ACTIVIDAD 07  ------------------------

-- Creamos la tabla cliente:
create table cliente(
	dni int primary key,
	apellido varchar(45) not null,
	nombre varchar(45)not null,
	calle_idcalle int not null,
	localidad_idlocalidad int not null,
	provincia_idprovincia int not null,
    numero_calle int not null,
	foreign key (calle_idcalle) references calle(idcalle),
    foreign key (localidad_idlocalidad) references localidad(idlocalidad),
    foreign key (provincia_idprovincia) references provincia(idprovincia)
);

-- Agregamos registros:
insert into cliente values(12345678, "Belgrano", "Manuel", 1,1,1,2345);
insert into cliente values(23456789, "Saavedra", "Cornelio",1,1,1,1234); 
insert into cliente values(44444444, "Moreno", "Mariano", 3,3,1,3333);
insert into cliente values(33333333, "Larrea", "Juan", 4,2,2,2345);
insert into cliente values(22222222, "Moreno", "Manuel", 4,2,2,7777);

-- Mostramos clientes:
-- todos los clientes
select * from cliente; 
-- solo dni y apellido
select dni,apellido from cliente;

-- Consultamos registros por dni:
select apellido,nombre from cliente where dni=12345678;

-- Consultamos registros por apellido:
select * from cliente where cliente.apellido="Saavedra";

-- Consultamos clientes de la calle 9 de julio
select * from cliente where calle_idcalle=1;

-- Consultamos clientes de la calle 9 de Julio con el número 2345
select * from cliente where calle_idcalle=1 and numero_calle=2345;

-- Consultamos clientes que vivan en la calle 9 de Julio 
-- o en la calle Mitre
select * from cliente where calle_idcalle=1 or calle_idcalle=3;

-- agregamos obras sociales a los clientes
-- creamos la tabla intermedia que representa la relación opcional 1:n entre cliente y obra social 
create table cliente_tiene_obra_social(
	cliente_dni int primary key,
	obra_social_codigo int not null,
	nro_afiliado int not null,
	foreign key (cliente_dni) references cliente(dni),
    foreign key (obra_social_codigo) references obra_social(codigo)
);

-- Insertamos datos en la tabla. El cliente Cornelio Saavedra no tiene obra social
-- por ello no existe un registro con su dni en la misma
insert into cliente_tiene_obra_social values (22222222, 2, 11223344);
insert into cliente_tiene_obra_social values (33333333, 2, 33445566);
insert into cliente_tiene_obra_social values (44444444, 2, 12356987);
insert into cliente_tiene_obra_social values (12345678,  1, 87654321);

-- Consultas más complejas (joins)

-- Consultamos todos los clientes con su calle usando alias de tabla
-- Inner join: todos los registros de una tabla con correlato en la otra
select c.dni, c.apellido, c.nombre, ca.nombre, c.numero_calle 
from cliente c inner join calle ca 
on c.calle_idcalle=ca.idcalle;

-- igual, definiendo un alias para el campo c.nombre y numero_calle (con as)
select c.dni, c.apellido, c.nombre, ca.nombre as calle, c.numero_calle as numeracion 
from cliente c inner join calle ca 
on c.calle_idcalle=ca.idcalle;

-- inner join con filtro por nombre de localidad
select c.dni, c.apellido, c.nombre, l.nombre as Localidad 
from cliente c inner join localidad l 
on c.localidad_idlocalidad=l.idlocalidad
where l.nombre="Avellaneda";

-- Left join: Todos los registros de la izquierda y sólo los de la 
-- derecha que participan en la relación.
select ca.nombre as calle, dni, apellido, c.nombre 
from calle ca left join cliente c 
on ca.idcalle=c.calle_idcalle;

-- Right join: Todos los registros de la derecha y los de la izquierda que 
-- participan en la relación.
select cos.nro_afiliado, c.dni, c.apellido, c.nombre 
from cliente_tiene_obra_social cos right join cliente c 
on c.dni=cos.cliente_dni;

-- Vemos como un right join se puede escribir como un left join y viceversa.
-- esta consulta es similar a la anterior
select cos.nro_afiliado, dni, apellido, c.nombre 
from cliente c left join cliente_tiene_obra_social cos 
on c.dni=cos.cliente_dni;

-- Traemos a los clientes sin obra social
select cos.nro_afiliado, dni, apellido, c.nombre 
from cliente c left join cliente_tiene_obra_social cos 
on c.dni=cos.cliente_dni
where isnull(cos.nro_afiliado);

-- Traemos a los clientes con obra social
select cos.nro_afiliado, dni, apellido, c.nombre 
from cliente c left join cliente_tiene_obra_social cos 
on c.dni=cos.cliente_dni
where not isnull(cos.nro_afiliado);

-- Consultas aún más complejas:
-- joins múltiples: Queremos consultar todos los clientes de IOMA:
select c.dni, c.apellido, c.nombre, o.nombre
from cliente c inner join cliente_tiene_obra_social co 
on c.dni=co.cliente_dni
inner join obra_social o 
on co.obra_social_codigo=o.codigo
where o.nombre="IOMA";


-- ------------    PRACTICA ----------------------
-- consultar por:
-- Todos los clientes con la siguiente forma:
-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia;

-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
-- solo provinvia de Buenos Aires. 
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia
where p.nombre = "Buenos Aires";

-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
-- Igual que la primera pero sólo de la calle 9 de julio
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia
where ca.nombre = "9 de Julio";

-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
-- Igual que la primera pero sólo el dni 33333333 
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia
where c.dni = "33333333";

-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
-- Igual que la primera pero sólo de las localidades de avellaneda y lanus (filtrar por "Avellaneda" y "Lanús") 
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia
where l.nombre = "Avellaneda" or l.nombre = "Lanús";  

-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
-- Igual que la primera pero sólo los clientes de PAMI y IOMA (filtrar por "PAMI" y "IOMA")
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia ,
os.nombre as obra_social
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia
inner join  cliente_tiene_obra_social cos
on c.dni = cos.cliente_dni
inner join obra_social os
on os.codigo = cos.obra_social_codigo
where os.nombre = "PAMI" or os.nombre = "IOMA";

-- dni, apellido,nombre,calle,numero,localidad,provincia :
-- 12345678, Belgrano, Manuel, 9 de julio, 2345, Lanús, Buenos Aires
-- Igual que la primera pero sólo los clientes de IOMA que vivan en la calle Mitre (filtrar por "IOMA" y "Mitre")
select c.dni, c.apellido , c.nombre ,ca.nombre as nombre_calle, c.numero_calle, l.nombre as localidad , p.nombre as provincia ,
os.nombre as obra_social
from cliente c 
inner join calle ca
on c.calle_idcalle = ca.idcalle
inner join localidad l
on c.localidad_idlocalidad = l.idlocalidad
inner join provincia p
on c.provincia_idprovincia = p.idprovincia
inner join  cliente_tiene_obra_social cos
on c.dni = cos.cliente_dni
inner join obra_social os
on os.codigo = cos.obra_social_codigo
where os.nombre = "IOMA" and ca.nombre = "Mitre";

-- Crear las tablas laboratorio y producto
create table laboratorio(
idlaboratorio int primary key not null,
nombre varchar (45) not null
);

create table producto(
idproducto int primary key not null,
nombre varchar(50) not null,
descripcion varchar(100) not null,
precio decimal(7,2) not null,
laboratorio_idlaboratorio int not null,
foreign key (laboratorio_idlaboratorio) references laboratorio(idlaboratorio)
);

-- insertar los siguientes datos:
-- laboratorio:
insert laboratorio values(1,"Baye");
insert laboratorio values(2,"Roemmers");
insert laboratorio values(3,"Farma");
insert laboratorio values(4,"Elea");

-- Insertar los siguientes datos en Producto
-- codigo, nombre, descripcion, precio, laboratorio_codigo
insert producto values (1, 'Bayaspirina', 'Aspirina por tira de 10 unidades', 10, 1);
insert producto values (2, 'Ibuprofeno', 'Ibuprofeno por tira de 6 unidades', 20, 3);
insert producto values (3, 'Amoxidal 500', 'Antibiótico de amplio espectro', 300, 2);
insert producto values (4, 'Redoxon', 'Complemento vitamínico', 120, '1');
insert producto values (5, 'Atomo', 'Crema desinflamante', 90, 3); 


-- Crear tabla venta. Insertar los siguientes datos:
-- numero, fecha, cliente_dni
create table venta (
numero int primary key not null,
fecha date not null,
cliente_dni int not null,
foreign key (cliente_dni) references cliente(dni)
);

insert venta values (1, '20-08-20', 12345678);
insert venta values (2, '20-08-20', 33333333);
insert venta values (3, '20-08-22', 22222222);
insert venta values (4, '20-08-22', 44444444);
insert venta values (5, '20-08-22', 22222222);
insert venta values (6, '20-08-23', 12345678);

-- Realizar las siguientes consultas:
-- Todas las ventas, indicando número, fecha, apellido y nombre del cliente
select v.numero , v.fecha , c.apellido , c.nombre, c.dni -- opcional , para que se vea mejor la consulta
from cliente c inner join venta v
on c.dni = v.cliente_dni;

-- Todas las ventas, indicando número, fecha, apellido y nombre del cliente
-- Igual que la anterior, pero que traiga sólo las del cliente con dni 12345678
select v.numero , v.fecha , c.apellido , c.nombre , c.dni
from cliente c inner join venta v
on c.dni = v.cliente_dni
where c.dni = 12345678;

-- Todos (pero todos) los clientes con sus ventas
select v.numero , v.fecha , c.apellido , c.nombre , c.dni
from cliente c left join venta v -- con left join trae todos los cliente aunque no haya realizado compras . 
on c.dni = v.cliente_dni;

-- Los clientes que no tienen ventas registradas
select v.numero , v.fecha , c.apellido , c.nombre , c.dni
from cliente c left join venta v -- con left join trae todos los cliente aunque no haya realizado compras . 
on c.dni = v.cliente_dni
where isnull (v.numero);

-- Todos los laboratorios
select idlaboratorio,nombre from laboratorio;

-- Todos los productos, indicando a que laboratorio pertencen
select p.idproducto, p.nombre ,p.descripcion , l.nombre as laboratorio
from producto p inner join laboratorio l
on p.laboratorio_idlaboratorio= l.idlaboratorio;

-- Todos (pero todos) los laboratorios con los productos que elaboran
select lab.idlaboratorio , lab.nombre as laboratorio , p.nombre as producto , p.descripcion , p.precio
from laboratorio lab left join producto p
on lab.idlaboratorio = p.laboratorio_idlaboratorio;

-- Los laboratorios que no tienen productos registrados
select lab.idlaboratorio , lab.nombre as laboratorio , p.nombre as producto , p.descripcion , p.precio
from laboratorio lab left join producto p
on lab.idlaboratorio = p.laboratorio_idlaboratorio
where isnull(p.nombre);