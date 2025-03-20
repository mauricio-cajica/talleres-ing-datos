
/* Crear la base de datos */
create database if not exists tallerConsultas;
/*   drop database tallerConsultas;   */
use tallerConsultas;

/* Crear las tablas */

create table if not exists departamentos(
	idDepto varchar(5) primary key,
    nombreDepto varchar(30) not null
);

create table cargo(
	idCargo varchar(5) primary key,
	nombreCargo varchar(20) not null,
	rangoCargo varchar(10) not null,
	descCargo varchar(100) not null    
);

create table if not exists empleados(
	idEmpleado varchar(16) primary key,
    idDeptoFK varchar(5) not null,
    idCargoFK varchar(5) not null,
    nombreEmpleado varchar(50) not null,
    edadempleado varchar(3) not null,
    salarioEmpleado int not null,
    anioContrato year not null,
    foreign key (idDeptoFK) references departamentos(idDepto) on delete cascade, /* Relacion 1 departamento a muchos empleados*/
    foreign key (idCargoFK) references cargo(idCargo) on delete cascade
);


/* Creamos datos para poder relaizar la consulta */

INSERT INTO departamentos (idDepto, nombreDepto) VALUES
('D001', 'Recursos Humanos'),
('D002', 'IT'),
('D003', 'Contabilidad'),
('D004', 'Ventas'),
('D005', 'Marketing'),
('D006', 'Departamento Vacío');

INSERT INTO cargo ( idCargo, nombreCargo, rangoCargo, descCargo) VALUES
('C001','lider de proyecto', '3', 'Encargado de administrar un proyecto'),
('C002','desarrollador de proyecto', '3', 'Encargado de desarrollar un proyecto y presentar avances'),
('C003','monitor de proyecto', '2', 'Encargado de controlar el desarrollo un proyecto'),
('C004','gestor de proyecto', '2', 'Encargado de tomar decisiones de proyecto en ausencia del lider'),
('C005','trabajador', '1', 'trabaja en el proyecto'),
('C006','cargo vacío', '1', 'un cargo en blanco, para pruebas');


INSERT INTO empleados (idEmpleado, idDeptoFK, idCargoFK, nombreEmpleado, edadempleado, salarioEmpleado, anioContrato) VALUES
('E0001', 'D001', 'C001', 'Ana Pérez', '35', 50000, 2015),
('E0002', 'D002','C001', 'Carlos Gómez', '29', 75000, 2018),
('E0003', 'D002', 'C005','Lucía Fernández', '32', 72000, 2017),
('E0004', 'D003','C002', 'Javier Rodríguez', '40', 65000, 2012),
('E0005', 'D003','C003', 'Sofía Martínez', '38', 63000, 2014),
('E0006', 'D004','C001', 'David Ramírez', '27', 55000, 2020),
('E0007', 'D004', 'C004','Andrea Torres', '30', 57000, 2019),
('E0008', 'D005', 'C001','Fernando López', '33', 60000, 2016),
('E0009', 'D005', 'C004','Marta Sánchez', '28', 59000, 2021);

/* join: 
inner join: devuelve las filas comunes en ambas tablas.
left join: devuelve las filas de la tabla izquierda, junto con las fials que coincidan con la tabla derecha.
right join: devuelve las filas de la tabla derecha, junto con las fials que coincidan con la tabla izquierda.
full join: devuelve todas las filas de ambas tablas.

select campo1tabla1,campo2tabla2 from tabla1 inner join tabla2
*/
select nombreEmpleado,nombreDepto as departamento from empleados inner join departamentos on empleados.idDeptoFK = departamentos.idDepto;

/* consultar todos los cargos con un rango especifico */
select nombreCargo,rangoCargo,descCargo as descripcion from cargo where rangoCargo = '2';

/* mostrar en pantalla los empleados que tengan un cargo específico */
select nombreEmpleado,nombreCargo, descCargo as descripcion 
from empleados inner join cargo on empleados.idCargoFK = 'C002' and cargo.idCargo = 'C002';

/* mostrar empleados con más de 3 años de antigüedad, su depto, salario y cargo */

select nombreEmpleado,(year(curdate())-anioContrato) as antigüedad, nombreDepto, nombreCargo 
from empleados inner join departamentos on empleados.idDeptoFK = departamentos.idDepto 
inner join cargo on empleados.idCargoFK = cargo.idCargo where (year(curdate())-anioContrato) > 3;

/* mostrar toda la información de un empleado (nombre, fecha contrato, depto, antigüedad, cargo, rango cargo, salario) */

select nombreEmpleado, anioContrato, nombreDepto, (year(curdate())-anioContrato) as antigüedad, nombreCargo, rangoCargo, salarioEmpleado 
from empleados inner join departamentos on empleados.idDeptoFK = departamentos.idDepto
inner join cargo on empleados.idCargoFK = cargo.idCargo;

/* mostrar todos los departamentos que no tengan empleados*/
select nombreDepto, (select count(*) from empleados where idDeptoFK = idDepto) as cantidadEmpleados 
from departamentos left join empleados on empleados.idDeptoFK = departamentos.idDepto 
where (select count(*) from empleados where idDeptoFK = idDepto) = 0; 

/* mostrar todos los cargos que no tengan empleados*/
select nombreCargo, (select count(*) from empleados where idCargoFK = idCargo) as cantidadEmpleados 
from cargo left join empleados on empleados.idCargoFK = cargo.idCargo 
where (select count(*) from empleados where idCargoFK = idCargo) = 0; 



