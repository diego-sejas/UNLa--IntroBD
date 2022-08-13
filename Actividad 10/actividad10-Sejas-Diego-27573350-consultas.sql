/***************************************************************************************
Intro BD 2020 - Sintaxis básica de dialecto SQL MySQL:
Manual de consulta MySQL: https://dev.mysql.com/doc/refman/8.0/en/
Apunte 5-Elementos de SQL 5 - CONSULTAS .SQL
***************************************************************************************/

-- Establecemos el esquema sobre el que trabajamos:
use aerolinea;

-- a. Listado de pasajeros de la empresa (apellido, nombre, dni).
select pe.apellido , pe.nombre , pe.dni
from persona pe
inner join pasajero pa on pe.idpersona = pa.persona_idpersona;


-- b. Listado de pasajeros de la empresa (apellido, nombre, dni, domicilio) .*
select pe.apellido , pe.nombre , pe.dni ,pa.viajero_frecuente, c.nombre as calle , dom.numero_calle as numero, l.nombre as localidad, p.nombre as provincia 
from persona pe
inner join pasajero pa on pe.idpersona = pa.persona_idpersona
inner join domicilio dom on pe.domicilio_id_domicilio = dom.id_domicilio
inner join calle c on dom.calle_idcalle = c.idcalle
inner join localidad l on dom.localidad_idlocalidad = l.idlocalidad
inner join provincia p on dom.provincia_idprovincia = p.idprovincia;
-- order by pe.apellido , pe.nombre;


-- c. Listado de pasajeros de la empresa (apellido, nombre, dni, domicilio)
-- ordenados por apellido y nombre.
select pe.apellido , pe.nombre , pe.dni ,pa.viajero_frecuente, c.nombre as calle , dom.numero_calle as numero, l.nombre as localidad, p.nombre as provincia 
from persona pe
inner join pasajero pa on pe.idpersona = pa.persona_idpersona
inner join domicilio dom on pe.domicilio_id_domicilio = dom.id_domicilio
inner join calle c on dom.calle_idcalle = c.idcalle
inner join localidad l on dom.localidad_idlocalidad = l.idlocalidad
inner join provincia p on dom.provincia_idprovincia = p.idprovincia
order by pe.apellido,pe.nombre;


-- d. Listado de los aviones de la compañía, (marca, modelo, matrícula, fecha de
-- entrada en servicio, país de origen).
select ma.nombre as marca , av.modelo, av.matricula, av.fecha_entrada_servicio,pa.nombre as pais_origen
from avion av
inner join marca ma on av.marca_codigo = ma.codigo
inner join pais pa on ma.pais_idpais = pa.idpais;


-- e. Listado de los aviones de la compañía, (marca, modelo, matrícula, fecha de
-- entrada en servicio, país de origen) cuyo país de origen sea “Alemania”.
select ma.nombre as marca , av.modelo, av.matricula, av.fecha_entrada_servicio,pa.nombre as pais_origen
from avion av
inner join marca ma on av.marca_codigo = ma.codigo
inner join pais pa on ma.pais_idpais = pa.idpais
where pa.nombre = 'Alemania';


-- f. Listado de vuelos realizados mostrando código, marca, modelo y matrícula
-- del avión, Código IATA del Aeropuerto origen, Código IATA del Aeropuerto
-- destino, fecha hora partida, fecha hora llegada y CUIL piloto.
select vue.codigo as vuelo , ma.nombre as marca , av.modelo, av.matricula,vue.aeropuerto_origen,vue.aeropuerto_destino, vue.fecha_hora_partida,
	   vue.fecha_hora_llegada,pil.cuil as cuil_piloto
from vuelo vue
inner join avion av on vue.avion_matricula = av.matricula
inner join marca ma on av.marca_codigo = ma.codigo
inner join aeropuerto aero on vue.aeropuerto_origen = aero.codigo
inner join piloto pil on vue.piloto_persona_idpersona = pil.persona_idpersona;


-- g. Listado de vuelos realizados mostrando código, marca, modelo y matrícula
-- del avión, Código IATA del Aeropuerto origen, Código IATA del Aeropuerto
-- destino, fecha hora partida, fecha hora llegada y CUIL piloto que hayan
-- partido del aeropuerto “BUE” ordenados por fecha hora de partida.
select vue.codigo as vuelo , ma.nombre as marca , av.modelo, av.matricula,vue.aeropuerto_origen,vue.aeropuerto_destino, vue.fecha_hora_partida,
	   vue.fecha_hora_llegada,pil.cuil as cuil_piloto
from vuelo vue
inner join avion av on vue.avion_matricula = av.matricula
inner join marca ma on av.marca_codigo = ma.codigo
inner join aeropuerto aero on vue.aeropuerto_origen = aero.codigo
inner join piloto pil on vue.piloto_persona_idpersona = pil.persona_idpersona
where vue.aeropuerto_origen = 'BUE'
order by vue.fecha_hora_partida; 


-- h. Listado de vuelos realizados mostrando codigo, Código IATA del Aeropuerto
-- origen, Código IATA del Aeropuerto destino, fecha hora partida y fecha hora
-- llegada que hayan partido del aeropuerto “BUE” y hayan arribado al
-- aeropuerto “MDQ”.
select vue.codigo as vuelo ,vue.aeropuerto_origen as codigo_IATA,vue.aeropuerto_destino as codigo_IATA, vue.fecha_hora_partida,
	   vue.fecha_hora_llegada
from vuelo vue
inner join avion av on vue.avion_matricula = av.matricula
inner join marca ma on av.marca_codigo = ma.codigo
inner join aeropuerto aero on vue.aeropuerto_origen = aero.codigo
where vue.aeropuerto_origen = 'BUE' and vue.aeropuerto_destino = 'MDQ';


-- i. Listado de todos los vuelos realizados y sus pasajeros, (código, apellido,
-- nombre, dni)
select vue.codigo as vuelo , pe.apellido , pe.nombre , pe.dni
from vuelo vue
inner join pasajero_por_vuelo pxv on vue.codigo = pxv.vuelo_codigo
inner join pasajero pa on pxv.pasajero_persona_idpersona = pa.persona_idpersona
inner join persona pe on pa.persona_idpersona = pe.idpersona;



-- j. Cantidad de vuelos realizados que hayan partido del aeropuerto “BUE” y
-- hayan arribado al aeropuerto “BRC”.
select count(vue.codigo) as cantidad_vuelos 
from vuelo vue
inner join aeropuerto aero on vue.aeropuerto_origen = aero.codigo
where vue.aeropuerto_origen = 'BUE' and vue.aeropuerto_destino = 'BRC';


-- k. Cantidad de vuelos realizados que hayan partido del aeropuerto “MDQ”
select count(vue.codigo) as cantidad_vuelos_MDQ 
from vuelo vue
inner join aeropuerto aero on vue.aeropuerto_origen = aero.codigo
where vue.aeropuerto_origen = 'MDQ';


-- l. Cantidad de vuelos realizados, por aeropuerto de origen (Código IATA,
-- cantidad).
select vue.aeropuerto_origen, count(vue.codigo) as cantidad
from vuelo vue
inner join aeropuerto aero on vue.aeropuerto_origen = aero.codigo
group by vue.aeropuerto_origen;


-- m. Cantidad de pasajeros transportados, por localidad del pasajero (localidad,
-- cantidad).
select lo.nombre as localidad , count(idlocalidad) as cantidad_pasajeros
from pasajero_por_vuelo pxv 
inner join pasajero pa on pxv.pasajero_persona_idpersona = pa.persona_idpersona
inner join persona pe on pa.persona_idpersona = pe.idpersona
inner join domicilio dom on pe.domicilio_id_domicilio = dom.id_domicilio
inner join localidad lo on dom.localidad_idlocalidad = lo.idlocalidad
group by lo.nombre;



-- n. Cantidad de pasajeros transportados, por dìa (fecha, cantidad)
select  vue.fecha_hora_partida  as fecha , count(pasajero_persona_idpersona) as cantidad_pasajeros  
from vuelo vue 
inner join pasajero_por_vuelo pxv on vue.codigo = pxv.vuelo_codigo
group by DATE(fecha_hora_partida) 
order by  DATE(fecha_hora_partida) ;



-- o. Cantidad de vuelos por pasajero (apellido, nombre, dni, cantidad)
select per.apellido , per.nombre , count(pasajero_persona_idpersona) as Cantidad_vuelos_realizados
from vuelo vue
inner join pasajero_por_vuelo pxv on vue.codigo = pxv.vuelo_codigo
inner join pasajero pa on pxv.pasajero_persona_idpersona = pa.persona_idpersona
inner join persona per on pa.persona_idpersona = per.idpersona
group by pxv.pasajero_persona_idpersona;


