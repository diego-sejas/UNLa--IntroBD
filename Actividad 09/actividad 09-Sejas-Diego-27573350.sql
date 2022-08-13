/***************************************************************************************
Intro BD 2020 - Sintaxis básica de dialecto SQL MySQL:
Manual de consulta MySQL: https://dev.mysql.com/doc/refman/8.0/en/
Apunte 5-Elementos de SQL 3
***************************************************************************************/

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

-- Creamos la tablas laboratorio
create table laboratorio(
idlaboratorio int primary key not null,
nombre varchar (45) not null
);

-- insertar los siguientes datos en la tabla Laboratorio : 
insert laboratorio values(1,"Baye");
insert laboratorio values(2,"Roemmers");
insert laboratorio values(3,"Farma");
insert laboratorio values(4,"Elea");

-- Creamos la Tabla Producto
create table producto(
idproducto int primary key not null,
nombre varchar(50) not null,
descripcion varchar(100) not null,
precio decimal(7,2) not null,
laboratorio_idlaboratorio int not null,
foreign key (laboratorio_idlaboratorio) references laboratorio(idlaboratorio)
);

-- Insertar los siguientes datos en Producto
-- codigo, nombre, descripcion, precio, laboratorio_codigo
insert producto values (1, 'Bayaspirina', 'Aspirina por tira de 10 unidades', 10, 1);
insert producto values (2, 'Ibuprofeno', 'Ibuprofeno por tira de 6 unidades', 20, 3);
insert producto values (3, 'Amoxidal 500', 'Antibiótico de amplio espectro', 300, 2);
insert producto values (4, 'Redoxon', 'Complemento vitamínico', 120, '1');
insert producto values (5, 'Atomo', 'Crema desinflamante', 90, 3); 


-- Creamos la tabla venta. 
create table venta (
numero int primary key not null,
fecha date not null,
cliente_dni int not null,
foreign key (cliente_dni) references cliente(dni)
);

-- Insertamos los siguientes datos:
-- numero, fecha, cliente_dni
insert venta values (1, '20-08-20', 12345678);
insert venta values (2, '20-08-20', 33333333);
insert venta values (3, '20-08-22', 22222222);
insert venta values (4, '20-08-22', 44444444);
insert venta values (5, '20-08-22', 22222222);
insert venta values (6, '20-08-23', 12345678);


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

/***************************************************************************************
Intro BD 2020 - Sintaxis básica de dialecto SQL MySQL:
Manual de consulta MySQL: https://dev.mysql.com/doc/refman/8.0/en/
Apunte 5-Elementos de SQL 3
***************************************************************************************/

-- creamos la tabla detalle_venta (¿Qué representa esta tabla?)
create table detalle_venta(
	venta_numero int,
	producto_codigo int,
	precio_unitario decimal(10,2),
	cantidad int,
	primary key (venta_numero, producto_codigo),
	foreign key (venta_numero) references venta(numero),
	foreign key (producto_codigo) references producto(idproducto)
);

/***************************************************************************************
Práctica:
Agregar el detalle de las ventas en detalle_venta de la siguiente manera:
# venta_numero, producto_codigo, precio_unitario, cantidad

***************************************************************************************/
insert into detalle_venta values 
(1, 2, 20.00, 3),
(1, 3, 300.00, 1),
(2, 1, 10.00, 2),
(2, 4, 120.00, 1), 
(3, 2, 20.00, 3),
(3, 5, 90.00, 2),
(4, 2, 20.00, 2),
(5, 1, 8.00, 4),
(5, 5, 70.00, 1),
(6, 2, 20.00, 2),
(6, 3, 300.00, 1),
(6, 4, 120.00, 1);

-- Intentar agregar el siguiente registro y ver que ocurre:
-- insert into detalle_venta values (7, 4, 120.00, 2); NO PERMITE EL INSERT POR LA FOREING KEY EN LA TABLA VENTA , EL CODIGO 7 NO EXISTE.

-- Intentar agregar el siguiente registro y ver que ocurre:
-- insert into detalle_venta values (4, 2, 20.00, 2); NO PERMITE EL INSERT POR LA CLAVE PRIMARIA COMPUESTA 4,2 YA EXISTE .

-- Consultas con operaciones y agregación

-- Total facturado para un item determinado de una venta:
select precio_unitario*cantidad as total from detalle_venta
where venta_numero=1 and producto_codigo=2;

-- Total facturado por la farmacia
select sum(precio_unitario*cantidad) as total from detalle_venta;


-- Total facturado en una venta (sum)
select sum(precio_unitario*cantidad) as total from detalle_venta 
where venta_numero=1;


-- Total facturado discriminado venta por venta (sum con group by):
select venta_numero, sum(precio_unitario*cantidad) as total from detalle_venta
group by venta_numero;


-- cantidad de ventas total (count)
select count(*) as cant_provincias from provincia;
select count(numero) as cant_ventas from venta;

-- cantidad de ventas por dia total (count con group by)
select v.fecha,v.numero, count(*) as cant_ventas 
from venta v
group by v.fecha;

-- Total facturado por día: (inner join, sum, group by)
select v.fecha, sum(precio_unitario*cantidad) as total 
from detalle_venta dv inner join venta v 
on dv.venta_numero=v.numero
group by v.fecha;


-- precio promedio de productos vendidos por producto (inner join, avg, group by)
select p.nombre, avg(dv.precio_unitario) as precio_prom_vendido, p.precio as precio_articulo 
from producto p inner join detalle_venta dv 
on p.idproducto=dv.producto_codigo
group by p.idproducto;


-- precio promedio de productos vendidos entre fecha (inner join, avg, group by, between)
select p.nombre, avg(dv.precio_unitario) as precio_promedio, p.precio as precio_lista 
from producto p 
inner join detalle_venta dv 
on p.idproducto=dv.producto_codigo
inner join venta v 
on dv.venta_numero=v.numero 
where v.fecha between '2020-08-22' and '2020-08-23'
group by p.idproducto;


-- precio promedio de productos vendidos entre fecha (inner join, avg, group by, filtro)
select p.nombre, avg(dv.precio_unitario) as precio_promedio, p.precio as precio_lista 
from producto p 
inner join detalle_venta dv on p.idproducto=dv.producto_codigo
inner join venta v on dv.venta_numero=v.numero 
where v.fecha >= '2020-08-22' and v.fecha<='2020-08-23'
group by p.idproducto;


-- artículos vendidos más baratos que el precio de lista
select v.numero, p.nombre, p.descripcion, p.precio as precio_lista, 
dv.precio_unitario as precio_venta, dv.precio_unitario-p.precio as diferencia
from venta v 
inner join detalle_venta dv on v.numero=dv.venta_numero
inner join producto p on dv.producto_codigo=p.idproducto
where dv.precio_unitario-p.precio<0;


-- total facturado en el año (inner join, sum, where)
select year(v.fecha) as año, sum(precio_unitario*cantidad) as total 
from detalle_venta d
inner join venta v on d.venta_numero=v.numero
group by year(v.fecha);

-- también: group by año;

-- Total facturado mayor a $100 (sum con group by y having):
select venta_numero, sum(precio_unitario*cantidad) as total from detalle_venta
group by venta_numero
having total>100;


-- Total facturado mayor a $100 (sum con group by y having, ordenado por total):
select venta_numero, sum(precio_unitario*cantidad) as total from detalle_venta
group by venta_numero
having total>100
order by total;


-- Total facturado mayor a $100 (sum con group by y having, ordenado por total):
select venta_numero, sum(precio_unitario*cantidad) as total from detalle_venta
group by venta_numero
having total>100
order by total desc;


/***************************************************************************************
Práctica:
Realizar una consulta que devuelva el total facturado del
producto 'Amoxidal 500' pero eligiendo el producto por nombre 
(no por código). 
***************************************************************************************/
select venta_numero, p.nombre as nombre_producto, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv inner join producto p
on dv.producto_codigo = p.idproducto
where p.nombre = 'Amoxidal 500';


-- Realizar una consulta que devuelva el total facturado al cliente con dni 
-- 22222222 (dni, total)
select c.apellido,c.nombre,c.dni, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv 
inner join venta v on dv.venta_numero = v.numero
inner join cliente c on v.cliente_dni = c.dni
where v.cliente_dni=22222222 ;

/***************************************************************************************
Realizar una consulta que devuelva la cantidad de ventas realizadas al 
cliente con dni 12345678. Cantidad de ventas es cada ticket emitido, no cada 
producto vendido. (dni, cantidad)
***************************************************************************************/
select c.dni, c.apellido,c.nombre,count(*) as cantidad_ventas
from venta v inner join cliente c on v.cliente_dni = c.dni
where v.cliente_dni=12345678 ;

/***************************************************************************************
Realizar una consulta que devuelva las ventas realizadas a los clientes con apellido
'Belgrano', discriminado venta por venta. (apellido, numero de venta, total)
***************************************************************************************/
select c.apellido, v.numero as numero_venta, sum(precio_unitario*cantidad) as total_facturado
from venta v 
inner join detalle_venta dv on dv.venta_numero = v.numero
inner join cliente c on c.dni = v.cliente_dni
where c.apellido = 'Belgrano';

/***************************************************************************************
Realizar una consulta que devuelva la cantidad de ventas realizadas a los clientes 
con apellido 'Moreno'. (apellido, cantidad)
***************************************************************************************/
select c.apellido , count(*) as cantidad_ventas
from venta v 
inner join cliente c on c.dni = v.cliente_dni
where c.apellido = 'Moreno';

-- Traer el total facturado por obra social. (nombre de obra social, total)
select os.nombre, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv
inner join venta v on dv.venta_numero = v.numero
inner join cliente c on c.dni = v.cliente_dni
inner join cliente_tiene_obra_social ctos on ctos.cliente_dni = c.dni
inner join obra_social os on os.codigo = ctos.obra_social_codigo
group by os.nombre; 


-- Idem a la anterior, pero filtrando desde el 1/1/2020 hasta el 30/8/2020.
select os.nombre, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv
inner join venta v on dv.venta_numero = v.numero
inner join cliente c on c.dni = v.cliente_dni
inner join cliente_tiene_obra_social ctos on ctos.cliente_dni = c.dni
inner join obra_social os on os.codigo = ctos.obra_social_codigo
where v.fecha between '2020-01-01' and '2020-08-30'
group by os.nombre;  

-- Traer el total facturado a clientes que no tienen obra social (sólo mostrar total)
select c.nombre, c.dni,sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv
inner join venta v on dv.venta_numero = v.numero
inner join cliente c on c.dni = v.cliente_dni
left join cliente_tiene_obra_social ctos on c.dni = ctos.cliente_dni 
where isnull(ctos.nro_afiliado); 

/**
select cos.nro_afiliado, dni, apellido, c.nombre 
from cliente c left join cliente_tiene_obra_social cos on c.dni=cos.cliente_dni
where isnull(cos.nro_afiliado);
**/

/***************************************************************************************
Realizar una consulta que devuelva el total de las ventas realizadas a 
clientes de la calle Sáenz (se debe filtrar por nombre de calle="Sáenz").
(apellido, nombre, total vendido)
***************************************************************************************/
select c.apellido,c.nombre, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv
inner join venta v on v.numero = dv.venta_numero
inner join cliente c on v.cliente_dni = c.dni  
inner join calle ca on ca.idcalle = c.calle_idcalle
where ca.nombre = 'Sáenz'
group by c.apellido;

/**
select c.apellido,c.nombre, count(*) as ventas_realizadas
from venta v 
inner join cliente c on v.cliente_dni = c.dni  
inner join calle ca on ca.idcalle = c.calle_idcalle
where ca.nombre = 'Sáenz'
group by c.apellido;
**/

/***************************************************************************************
Realizar una consulta que devuelva las ventas realizadas a clientes de la 
calle Sáenz (se debe filtrar por nombre de calle="Sáenz", discriminada 
venta por venta (apellido, nombre, venta_numero, total)
***************************************************************************************/
select c.apellido,c.nombre, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv
inner join venta v on v.numero = dv.venta_numero
inner join cliente c on v.cliente_dni = c.dni  
inner join calle ca on ca.idcalle = c.calle_idcalle
where ca.nombre = 'Sáenz'
group by v.numero;

/***************************************************************************************
Realizar una consulta que devuelva los productos vendidos. Se debe mostrar cada 
producto una sola vez (Ayuda: hay que agrupar por producto)
(código, nombre, descripcion)
***************************************************************************************/
select p.idproducto as codigo , p.nombre , p.descripcion
from producto p
inner join detalle_venta dv on p.idproducto = dv.producto_codigo
inner join venta v on v.numero = dv.venta_numero
group by p.idproducto;


/***************************************************************************************
Realizar una consulta que devuelva el total de ventas sin detallar realizadas 
a clientes de la obra social IOMA que vivan en la provincia de Buenos Aires. 
Consultar por nombre de obra social y de provincia
(nombre provincia, nombre obra social, total)
***************************************************************************************/
select p.nombre as nombre_provincia ,os.nombre as nombre_obra_social, sum(precio_unitario*cantidad) as total_facturado
from detalle_venta dv
inner join venta v on v.numero = dv.venta_numero
inner join cliente c on v.cliente_dni = c.dni  
inner join cliente_tiene_obra_social ctos on c.dni = ctos.cliente_dni
inner join obra_social os on ctos.obra_social_codigo = os.codigo
inner join provincia p on c.provincia_idprovincia = p.idprovincia
where os.nombre = 'IOMA' and p.nombre = 'Buenos Aires';
-- group by v.numero;

/***************************************************************************************
Realizar una consulta que devuelva cuántas son las ventas de la consulta anterior
(nombre provincia, nombre obra social, cantidad)
***************************************************************************************/
select p.nombre as nombre_provincia ,os.nombre as nombre_obra_social, count(numero) as ventas_realizadas
from venta v
inner join cliente c on v.cliente_dni = c.dni  
inner join cliente_tiene_obra_social ctos on c.dni = ctos.cliente_dni
inner join obra_social os on ctos.obra_social_codigo = os.codigo
inner join provincia p on c.provincia_idprovincia = p.idprovincia
where os.nombre = 'IOMA' and p.nombre = 'Buenos Aires';






/***************************************************************************************
Apunte 6-Elementos de SQL 4
***************************************************************************************/

-- Problema con group by en MySQL (consulta incorrecta):
select venta_numero, venta.fecha, sum(precio_unitario*cantidad) as total 
from detalle_venta
inner join venta on venta.numero=detalle_venta.venta_numero;

-- Campos en select con dependencias funcionales con un campo en group by:
select c.dni,sum(precio_unitario*cantidad) as total_facturado, c.nombre, c.apellido
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
inner join cliente c on v.cliente_dni=c.dni
group by c.dni;

-- Campos en select sin dependencia funcional con algún campo en group by (incorrecta)
-- debe devolver error, si no es así, verificar sql_mode:
select c.dni,sum(precio_unitario*cantidad) as total_facturado, c.nombre, c.apellido, v.fecha
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
inner join cliente c on v.cliente_dni=c.dni
group by c.dni;

select @@session.sql_mode;

-- Campos en select sin dependencia funcional con alguno en group by,
-- pero en función de agregación:
select c.dni,sum(precio_unitario*cantidad) as total_facturado, c.nombre, c.apellido,
max(v.fecha) as fecha_ultima_venta
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
right join cliente c on v.cliente_dni=c.dni
left join cliente_tiene_obra_social cos on c.dni=cos.cliente_dni
group by c.dni;

/***************************************************************************************
Modificamos (update) registros
******************************************************************/
-- agregamos 20% al precio de todos los productos
update producto set precio=precio*1.2
where producto.idproducto>-1 ; 

select * from producto;

-- agregamos 15% al precio de los productos Bayer
update producto set precio=precio*1.15 
	where laboratorio_idlaboratorio=1;

select * from producto;

-- agregamos 10% a un producto determinado
update producto set precio=precio*1.1 
	where producto.nombre="Amoxidal 500";

select * from producto;

-- agregamos 10% a los productos cuyo precio sea >150
update producto set precio=precio*1.1 
	where precio>150;

select * from producto;

-- podemos actualizar varios campos a la vez separando con comas.
-- aquí utilizamos una función de MySQL para concatenar dos strings
-- year, sum, count, avg también son funciones. 
-- Listado de funciones de MySQL:
-- https://dev.mysql.com/doc/refman/8.0/en/sql-function-reference.html
update producto set precio=precio*1.1, descripcion=concat(descripcion," testeada")
	where nombre="Amoxidal 500";

select * from producto;

/***************************************************************************************
Eliminamos (delete) registros
***************************************************************************************/

-- damos de alta una obra social para luego eliminarla
insert into obra_social (codigo, nombre, descripcion) 
	values(4,"OSPAPEL","Obra Social del personal del papel");

select * from obra_social;

-- la eliminamos
delete from obra_social where codigo=4;

select * from obra_social;

-- si no especificamos filtro, podemos borrar todas las 
-- obras sociales
delete from obra_social;
-- Se pudo? Por qué?

/***************************************************************************************
Práctica:
***************************************************************************************/
-- Realizar una consulta que traiga el total de las ventas de un cliente, indicando apellido, 
-- nombre, dni, localidad y total de ventas.
select c.apellido, c.nombre, c.dni ,l.nombre as localidad,sum(precio_unitario*cantidad) as total_ventas
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
inner join cliente c on v.cliente_dni=c.dni
inner join localidad l on c.localidad_idlocalidad=l.idlocalidad
group by c.dni;

-- Realizar una consulta que traiga el total de las ventas por provincia, indicando provincia, 
-- total de ventas.
select p.nombre as provincia,sum(precio_unitario*cantidad) as total_ventas
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
inner join cliente c on v.cliente_dni=c.dni
inner join provincia p on c.provincia_idprovincia=p.idprovincia
group by p.idprovincia;

-- Realizar una consulta que devuelva el promedio de precio de venta por producto, mostrando 
-- producto, precio promedio. El precio de venta es el precio con que se vendió, no el precio 
-- de lista.
select prod.nombre , prod.descripcion,avg(precio_unitario) as precio_promedio
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
inner join producto prod on dv.producto_codigo = prod.idproducto
group by dv.venta_numero ;

/**************
-- Realizar una consulta que traiga totales de venta por provincia y obra social, indicando
-- provincia, codigo de obra social, nombre de obra social, descripcion de obra social, 
-- total venta.
select p.nombre as provincia,os.codigo as codigo_obra_social,os.nombre as nombre,os.descripcion,sum(precio_unitario*cantidad) as total_ventas
from detalle_venta dv
inner join venta v on dv.venta_numero=v.numero
inner join cliente c on v.cliente_dni=c.dni
inner join provincia p on c.provincia_idprovincia=p.idprovincia
inner join cliente_tiene_obra_social ctos on c.
inner join obra_social
group by p.idprovincia;
**************/

-- Realizar una consulta que le cambie la obra social al cliente con dni 22222222.
update cliente_tiene_obra_social set obra_social_codigo = 1
	where cliente_dni = 22222222;

-- Realizar una consulta que retorne la obra social del cliente con dni 22222222 a la 
-- original (IOMA).
update cliente_tiene_obra_social set obra_social_codigo = 2
	where cliente_dni = 22222222;

-- Realizar las consultas necesarias para retornar los precios de lista de los productos 
-- a sus valores originales 
update producto set precio=precio/1.2
where producto.idproducto>-1; 


-- Sacamos 15% al precio de los productos Bayer
update producto set precio=precio/1.15 
	where laboratorio_idlaboratorio=1;
    
-- Sacamos 10% a un producto determinado
update producto set precio=precio/1.1 
	where producto.nombre="Amoxidal 500";

-- Sacamos 10% a los productos cuyo precio sea >150
update producto set precio=precio/1.1 
	where precio>150;

select * from producto;

-- Realizar una consulta que modifique al cliente Mariano Moreno para que quede sin obra
-- social
delete from cliente_tiene_obra_social
where cliente_dni = 44444444;

select * from cliente_tiene_obra_social;

-- Realizar una consulta que asigne nuevamente al cliente Mariano Moreno su obra social
-- original y su número de afiliado (IOMA, 12356987)
insert into cliente_tiene_obra_social (cliente_dni, obra_social_codigo, nro_afiliado) 
	values(44444444,2,12356987);

-- Crear una venta número 7, de fecha  25/08/2020, al cliente Cornelio Saavedra, con los 
-- siguientes productos (producto, cantidad):
-- Amoxidal 500, 3
-- Bayaspirina, 10
-- Redoxon, 1
-- Los precios deben ser los precios de lista
insert into venta (numero, fecha, cliente_dni) 
values(7,'2020-08-25',23456789);
select * from venta;

insert into detalle_venta (venta_numero, producto_codigo, precio_unitario,cantidad) 
values(7,3,300,3),
	  (7,1,10,10),
	  (7,4,132,1);
select * from detalle_venta;

-- Crear una consulta que Modifique el precio del artículo Redoxon de la venta 7 a $200

update detalle_venta set precio_unitario = 200
where venta_numero = 7 and producto_codigo = 4;

-- Crear las consultas necesarias para eliminar completamente la venta 7, incluyendo su
-- detalle. 
delete from detalle_venta
where venta_numero =7;
select * from detalle_venta;

delete from venta
where numero = 7;
select * from venta;

