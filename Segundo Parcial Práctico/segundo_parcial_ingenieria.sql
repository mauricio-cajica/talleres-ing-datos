CREATE DATABASE BDDataVerse;
-- drop database BDDataVerse;
use BDDataVerse;

CREATE TABLE sensores(
						id_sensor int primary key auto_increment, 
                        tipo varchar(20) not null, 
                        ubicacion varchar(50) not null, 
                        fecha_instalacion date not null);
                        
CREATE TABLE registros_sensores(
						id_registro int primary key auto_increment, 
                        id_sensor int not null, 
                        valor int not null, 
                        fecha_registro timestamp not null, 
                        foreign key (id_sensor) references sensores(id_sensor) on delete cascade);
                        
CREATE TABLE transporte(
						id_transporte int primary key auto_increment,
                        tipo varchar(20) not null,
                        capacidad int not null);

CREATE TABLE evento(
						id_evento int primary key auto_increment,
                        tipo_evento varchar(50) not null, 
                        descripcion varchar(100) not null, 
                        fecha_hora datetime not null, 
                        ubicacion varchar(50) not null
                        );
                        
CREATE TABLE consumo_energetico(
						id_registro int primary key auto_increment, 
                        id_evento int not null,
                        zona varchar(20) not null, 
                        consumo_kw float not null, 
                        fecha date not null, 
                        foreign key (id_registro) references registros_sensores(id_registro) on delete cascade,
                        foreign key (id_evento) references evento(id_evento) on delete cascade);
                        


CREATE TABLE seguridad(
						id_evento int primary key,
                        tipo_evento varchar(50) not null, 
                        descripcion varchar(100) not null, 
                        fecha_hora datetime not null, 
                        ubicacion varchar(50) not null,
                        foreign key (id_evento) references evento(id_evento));

CREATE TABLE usuarios(
						id_usuario int primary key auto_increment, 
                        id_evento int not null,
                        nombre varchar(50) not null,
                        email varchar(100) not null, 
                        id_transporte int not null, 
                        foreign key (id_transporte) references transporte(id_transporte) on delete cascade,
                        foreign key (id_evento) references evento(id_evento) on delete cascade);
ALTER TABLE usuarios ADD telefono int(10) not null;

-- insertar 5 registros en cada tabla

INSERT INTO sensores(tipo, ubicacion, fecha_instalacion) VALUES
							('luminico', 'Madelena', '2025-04-03'),
							('humedad', 'Soacha', '2025-04-04'),
                            ('temperatura', 'Engativa', '2025-04-05'),
                            ('presion atmos', 'Usme', '2025-04-06'),
                            ('luminico', 'Soacha', '2025-04-07');

INSERT INTO registros_sensores(id_sensor, valor, fecha_registro) VALUES 
							(1, 50,'2025-04-07'),
                            (2, 45,'2025-04-06'),
                            (2, 15,'2025-04-07'),
                            (3, 18,'2025-04-06'),
                            (4, 1,'2025-04-06'),
                            (5, 100,'2025-04-06');
                            
INSERT INTO transporte(tipo,capacidad) VALUES 
							('camion', 10),
                            ('camion', 10),
                            ('camion', 10),
                            ('camion grande', 30),
                            ('camion grande', 30);

INSERT INTO evento(tipo_evento, descripcion, fecha_hora, ubicacion) VALUES
							('accidente de transito', 'choque ligero entre 2 vehiculos', '2025-04-06', 'Ricaurte'),
                            ('ingreso al vehiculo', 'empleado ingresa a su vehiculo', '2025-04-07', 'Soacha'),
                            ('inauguracion museo', 'inauguracion de un museo', '2025-04-05', 'Centro'),
                            ('Embotellamiento', 'embotellamiento', '2025-04-04', 'Engativa'),
                            ('Disturbios', 'disturbios causados por una protesta', '2025-04-03', 'Dorado');
        
INSERT INTO usuarios(id_evento,nombre,email,id_transporte,telefono) VALUES 
							(1,'Jose','jose@gmail.com',1,0000000000),
                            (2,'Maria','maria@gmail.com',2,0000000001),
                            (3,'Carlos','carlos@gmail.com',3,0000000002),
                            (4,'Arturo','arturo@gmail.com',4,0000000003),
                            (5,'Luna','luna@gmail.com',5,0000000004);

INSERT INTO seguridad(id_evento, tipo_evento, descripcion, fecha_hora, ubicacion) VALUES 
							(1,'accidente de transito', 'choque ligero entre 2 vehiculos', '2025-04-06', 'Ricaurte'),
                            (2,'ingreso al vehiculo', 'empleado ingresa a su vehiculo', '2025-04-07', 'Soacha'),
                            (3,'inauguracion museo', 'inauguracion de un museo', '2025-04-05', 'Centro'),
                            (4,'Embotellamiento', 'embotellamiento', '2025-04-04', 'Engativa'),
                            (5,'Disturbios', 'disturbios causados por una protesta', '2025-04-03', 'Dorado');

INSERT INTO consumo_energetico(id_evento,zona,consumo_kw,fecha) VALUES 
							(1,'Ricaurte',100,'2025-04-06'),
                            (2,'Soacha',80,'2025-04-07'),
                            (3,'Centro',50,'2025-04-05'),
                            (4,'Engativa',100,'2025-04-04'),
                            (5,'Dorado',900,'2025-04-03');
                            
UPDATE consumo_energetico ce SET consumo_kw = (ce.consumo_kw*1.1) where zona = 'Ricaurte';
select * from consumo_energetico;
                            
DELIMITER //
	CREATE VIEW Vista_Consumo_Promedio as select zona, AVG(consumo_kw) as consumo_promedio from consumo_energetico GROUP BY zona ORDER BY AVG(consumo_kw) DESC;
// DELIMITER ;
select * from Vista_Consumo_Promedio;