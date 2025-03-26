/*Sentencias de DDL*/
/*Creacion de base de datos*/
/*drop database tiendamascota;*/
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

insert into mascota values (1,'maxwell','macho','golden retriever',1),(2,'michi','macho','gato negro',1);
insert into cliente values (00000000001,'José','Reyes','Direc1',0123456789,1),(00000000002,'María','Reyes','Direc2',0123456788,2);
insert into vacuna values (1,'anti rabia',1,'rabia'),(2,'antitoxo',2,'toxoplasm');
insert into mascota_vacuna values (1,1,'rabia'),(2,1,'rabia');
insert into producto values (1,'vacuna rabia','marca1',100.50,00000000001),(2,'vacuna rabia','marca1',100.50,00000000002);

select m.*, c.nombreCliente from mascota m right join cliente c on m.idmascota=c.idMascotaFK group by m.nombreMascota;

select m.*, c.nombreCliente, p.nombreProducto from Mascota m join cliente c on m.idMascota=c.idMascotaFK join producto p on p.cedulaClienteFK=c.cedulaCliente;

/* parametros de entrada con IN y de salida con OUT, no es necesario especificarlo para todos*/
DELIMITER //
-- creación de procedimiento almacenado
create procedure insertarMascota(IN idMascota int(11), nombreMascota varchar(15), generoMascota varchar(15), razaMascota varchar(15), cantidad int(10))
BEGIN
	insert into mascota values (idMascota, nombreMascota, generoMascota, razaMascota, cantidad);
END 
// DELIMITER ;

/* parametros de entrada con IN y de salida con OUT, no es necesario especificarlo para todos*/
DELIMITER //
-- creación de procedimiento almacenado
create procedure consultarPrecio(out precio float)
BEGIN
	select count(*) into precio from producto;
END 
// DELIMITER ;

-- procedimiento para insertar registros en tabla  débil
DELIMITER //
create procedure insertarMascotaVacuna(IN codigoVacunaFK int(11), idMascotaFK int(11), enfermedad varchar(15))
BEGIN
	insert into mascota_vacuna values (codigoVacunaFK,idMascotaFK,enfermedad);
END
// DELIMITER ;

CALL consultarMascotaVacuna(2,1,'antitoxo');


-- procedimiento para consultar vacunas aplicadas a una mascota y que enfermedad ataca la vacuna
DELIMITER //
create procedure consultarVacunasMascotas(IN idMascotaFK varchar(11))
BEGIN
		select idMascota, nombreMascota,codigoVacuna,nombreVacuna, v.enfermedad  from 
		mascota m inner join mascota_vacuna mv on m.idMascota = mv.idMascotaFK 
		inner join vacuna v on mv.codigoVacunaFK = v.codigoVacuna and mv.enfermedad = v.enfermedad; 
END
// DELIMITER ;

CALL consultarVacunasMascotas(1);

	