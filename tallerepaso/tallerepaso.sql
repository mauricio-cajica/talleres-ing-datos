
drop database votaciones2503816;

CREATE DATABASE votaciones2503816;

USE votaciones2503816;

-- Creacion de tablas

CREATE TABLE genero(idGenero INT PRIMARY KEY AUTO_INCREMENT,
								  nomGenero VARCHAR(20) not null,
								  estadoG bit not null);


CREATE TABLE jornada(idJornada INT PRIMARY KEY AUTO_INCREMENT,
									nomJornada VARCHAR(20) not null, 
                                    estadoJ bit not null);
                                    
                                    
CREATE TABLE tipoDocumento(idTipoDoc INT PRIMARY KEY AUTO_INCREMENT,
												nomTipoDoc VARCHAR(50) not null, 
                                                estadoTD bit not null);
                                                
                                                
CREATE TABLE tipoMiembro(idTipoMiembro INT PRIMARY KEY AUTO_INCREMENT,
											nomTipoMiembro VARCHAR(20) not null, 
                                            estadoTM bit not null);
                                            
                                            
CREATE TABLE curso(idCurso INT PRIMARY KEY AUTO_INCREMENT,
								nomCurso VARCHAR(20) not null,
                                estadoCu bit not null);
                                
                                
CREATE TABLE concejo(idConcejo INT PRIMARY KEY AUTO_INCREMENT,
									nomConcejo VARCHAR(50) not null, 
                                    estadoCO bit not null);
                                    
                                    
CREATE TABLE cargo(idCargo INT PRIMARY KEY AUTO_INCREMENT,
								nomCargo VARCHAR(20) not null, 
                                idConsejoFK int not null, estadoC bit not null, 
                                FOREIGN KEY (idConsejoFK) REFERENCES concejo(idconcejo) ON DELETE CASCADE );
                                
                                
CREATE TABLE eleccion(idEleccion INT PRIMARY KEY AUTO_INCREMENT,
									fechaEleccion DATE not null, 
                                    anioEleccion YEAR NOT NULL, 
                                    estadoEL bit not null);

CREATE TABLE usuario(idUsuario INT PRIMARY KEY AUTO_INCREMENT, 
					 noDocUsuario int(10) not null, 
                     idTipoDocFK int not null, 
                     nombreUsuario VARCHAR(20) not null, 
                     apellidoUsuario VARCHAR(20) not null, 
                     idGeneroFK int not null, 
                     fechaNacUsuario DATE NOT NULL,
                     emailUsuario VARCHAR(50), 
                     passwordUsuario TEXT(20), 
                     fotoUsuario BLOB not null, 
                     idJornadaFK int not null, 
                     idTipoMiembroFK int not null,
                     idCursoFK int,
                     estadoU bit not null,
                     FOREIGN KEY (idTipoDocFK) REFERENCES tipoDocumento(idTipoDoc) ON DELETE CASCADE,
                     FOREIGN KEY (idGeneroFK) REFERENCES genero(idGenero) ON DELETE CASCADE,
                     FOREIGN KEY (idJornadaFK) REFERENCES jornada(idJornada) ON DELETE CASCADE,
                     FOREIGN KEY (idTipoMiembroFK) REFERENCES tipoMiembro(idTipoMiembro) ON DELETE CASCADE,
                     FOREIGN KEY (idCursoFK) REFERENCES curso(idCurso) ON DELETE CASCADE
                     );
                     
CREATE TABLE postulacionCandidato(idPostCandidato INT PRIMARY KEY AUTO_INCREMENT, 
								  idUsuarioFK INT NOT NULL, 
                                  idEleccionFK INT NOT NULL, 
                                  idCargoFK INT NOT NULL, 
                                  propuestas VARCHAR(100) NOT NULL, 
                                  totalVotos INT NOT NULL, 
                                  estadoCan BIT NOT NULL,
                                  FOREIGN KEY (idUsuarioFK) REFERENCES usuario(idUsuario) ON DELETE CASCADE,
                                  FOREIGN KEY (idEleccionFK) REFERENCES eleccion(idEleccion) ON DELETE CASCADE,
                                  FOREIGN KEY (idCargoFK) REFERENCES cargo(idCargo) ON DELETE CASCADE
                                  );

CREATE TABLE votacion(idVotacion INT PRIMARY KEY AUTO_INCREMENT, 
									horaVotacion TIME NOT NULL, 
                                    idUsuarioVotanteFK INT UNIQUE NOT NULL, 
                                    idPostCandidatoFK INT NOT NULL, 
                                    estadoV BIT NOT NULL,
                                    FOREIGN KEY (idUsuarioVotanteFK) REFERENCES usuario(idUsuario) ON DELETE CASCADE,
                                    FOREIGN KEY (idPostCandidatoFK) REFERENCES usuario(idUsuario) ON DELETE CASCADE
                                    );			


-- insercion de datos

INSERT INTO genero(nomGenero, estadoG) VALUES ('Femenino', true), ('Masculino', true);
INSERT INTO jornada(nomJornada, estadoJ) VALUES ('Maniana', true), ('Tarde', true), ('Noche', true);
INSERT INTO	tipoDocumento(nomTipoDoc, estadoTD) VALUES ('tarjeta de identidad', true), ('cedula ciudadania', true), ('cedula extranjeria', true), ('pasaporte', true), ('nuip', false);
INSERT INTO tipoMiembro(nomTipoMiembro, estadoTM) VALUES ('estudiante', true), ('profesor', true), ('acudiente', true);
INSERT INTO curso(nomCurso, estadoCu) VALUES ('901', true), ('902', true), ('1001', true), ('1002', true), ('1003', false), ('1101', true), ('1102', true), ('1103', false);
INSERT INTO concejo(nomConcejo, estadoCO) VALUES ('concejo academico', true), ('concejo directivo', true), ('concejo convivencia', true);
INSERT INTO cargo(nomCargo,idConsejoFK, estadoC) VALUES ('personero', 1, true), ('contralor', 1, true), ('cabildante', 1, true);
INSERT INTO eleccion(fechaEleccion, anioEleccion, estadoEL) VALUES ('2020-04-20', 2020, true), ('2019-04-15', 2019, true), ('2019-04-12', 2019, false), ('2020-04-20', 2020, true);

INSERT INTO usuario(noDocUsuario, idTipoDocFK, nombreUsuario, apellidoUsuario, idGeneroFK, fechaNacUsuario, emailUsuario, passwordUsuario, fotoUsuario, idJornadaFK, idTipoMiembroFK, idCursoFK, estadoU) VALUES 
					(1, 1, 'VOTO', 'BLANCO', 2, '0000-00-00', null, null, '...', 1, 1, 3, true),
                    (1010123456, 1, 'david santiago', 'lopez mora', 2, '10/11/2004', 'davidLopez456@hotmail.com', 'David2004', '...', 1, 1, 1, true),
                    (1010123789, 1, 'LAURA MILENA', 'Gomez bonilla', 1, '3/17/2004', 'lauragomez@gmail.com', 'Gomez2004', '...', 1, 1, 1, true),
                    (1010123741, 1, 'DIEGO FERNANDO', 'CAÑON VARGAS', 2, '5/20/2003', 'diegocanon@hotmail.com', 'Diego2003', '...', 1, 1, 1, true),
                    (1010123852, 1, 'TATIANA', 'VARGAS CABRERA', 1, '11/28/2003', 'tatacabrera@gmail.com', 'Cabrera2003', '...', 1, 1, 3, true),
                    (1010123963, 1, 'LEYDY KATHERINE', 'FERNANDEZ RODRIGUEZ', 1, '6/28/2004', 'leydy2004@gmail.com', 'Leydy2004', '...', 1, 1, 4, true),
                    (1010123654, 1, 'MAURICIO', 'BERMUDEZ AMAYA', 2, '1/26/2002', 'maobermudez@gmail.com', 'Amaya2002', '...', 1, 1, 4, true),
                    (1010741258, 1, 'ANDRES FELIPE', 'RODRIGUEZ PEREZ', 2, '3/23/2004', 'andyrodriguez@gmail.com', 'Arodriguez2004', '...', 1, 1, 3, true),
                    (1010236859, 1, 'Maria angelica', 'trivinio latorre', 1, '2/4/2002', 'angelicatri@gmail.com', 'Trivino2002', '...', 1, 1, 3, true),
                    (1010236963, 1, 'genaro', 'vasquez rodriguez', 1, '11/14/2002', 'gevasquez@gmail.com', 'Vasquez123', '...', 1, 1, 3, false);
                    
INSERT INTO votacion(idVotacion, horaVotacion, idUsuarioVotanteFK, idPostCandidatoFK, estadoV) VALUES 
					(1, '12:08:15', 1, 1, true),
					(2, '12:12:35', 2, 2, true),
					(3, '12:14:18', 3, 2, true),
					(4, '12:15:58', 4, 1, true),
					(5, '12:18:02', 5, 3, true),
					(6, '12:24:22', 6, 3, true),
					(7, '12:28:02', 7, 3, true),
					(8, '12:30:14', 8, 1, true),
					(9, '12:40:20', 9, 2, true),
					(10, '12:45:20', 10, 2, true);

INSERT INTO postulacionCandidato(idPostCandidato, idUsuarioFK, idEleccionFK, idCargoFK, propuestas, totalVotos, estadoCan) VALUES 
					(1, 1, 1, 1, 'Mejorar entrega refrigerios, Alargar descansos', 0, true),
					(2, 2, 1, 1, 'Mejorar entrega refrigerios, Alargar descansos', 0, true),
					(3, 3, 1, 1, 'Mejorar sala de informática, Construir piscina', 0, true);

-- Consultas multitabla


# mostrar nombre del consejo que tenga un cargo asignado, nombre del cargo al que pertece y estado actual
SELECT nomConcejo as consejo, nomCargo as cargo, estadoC FROM cargo c INNER JOIN concejo co ON c.idConsejoFK = co.idConcejo;

# mostrar nombre de cada concejo, nombre del cargo al que pertenece, y el estado actual, independiente de si hay cargo asignado
SELECT nomConcejo as consejo, nomCargo as cargo, estadoC FROM cargo c RIGHT JOIN concejo co ON c.idConsejoFK = co.idConcejo;

# Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso
SELECT idUsuario, nombreUsuario as nombre, apellidoUsuario as apellido, noDocUsuario as documento, nomTipoMiembro as tipoMiembro, nomCurso  as nombreCurso FROM usuario u INNER JOIN jornada j ON u.idJornadaFK = j.idJornada INNER JOIN curso cu ON u.idCursoFK = cu.idCurso INNER JOIN tipoMiembro tm ON u.idTipoMiembroFK = tm.idTipoMiembro;

# consulta de cantidad de votos obtenidos por candidato
SELECT idUsuario, nombreUsuario, Count(*) as votos FROM usuario u INNER JOIN votacion v on u.idUsuario =v.idPostCandidatoFK GROUP BY idUsuario ORDER BY (Count(*)) DESC;

# procedimiento para crear una vista para la primera consulta
DELIMITER //
	CREATE PROCEDURE crearVistaConcejoVSCargo()
    BEGIN
		CREATE VIEW concejoVSCargo AS SELECT nomConcejo as consejo, nomCargo as cargo, estadoC FROM cargo c INNER JOIN concejo co ON c.idConsejoFK = co.idConcejo;
    END
// DELIMITER ;

# procedimiento para crear una vista para la tercera consulta
DELIMITER //
	CREATE PROCEDURE crearVistaUsuarioDetallado()
    BEGIN
		CREATE VIEW usuarioDetallado AS SELECT idUsuario, nombreUsuario as nombre, apellidoUsuario as apellido, noDocUsuario as documento, nomTipoMiembro as tipoMiembro, nomCurso  as nombreCurso FROM usuario u INNER JOIN jornada j ON u.idJornadaFK = j.idJornada INNER JOIN curso cu ON u.idCursoFK = cu.idCurso INNER JOIN tipoMiembro tm ON u.idTipoMiembroFK = tm.idTipoMiembro;
    END
// DELIMITER ;

#procedimiento para crear una vista para la cuarta consulta
DELIMITER //
	CREATE PROCEDURE crearVistaVotosTotales()
    BEGIN
		CREATE VIEW votosTotales AS SELECT idUsuario, nombreUsuario, Count(*) as votos FROM usuario u INNER JOIN votacion v on u.idUsuario =v.idPostCandidatoFK GROUP BY idUsuario ORDER BY (Count(*)) DESC;
    END
// DELIMITER ;


#subconsultas
SELECT nombreUsuario, apellidoUsuario FROM usuario WHERE idCursoFK = ( SELECT idCurso FROM curso WHERE nomCurso = '1001');

SELECT nomJornada, (SELECT COUNT(*) FROM usuario WHERE usuario.idJornadaFK = jornada.idJornada) AS totalUsuarios FROM jornada;





