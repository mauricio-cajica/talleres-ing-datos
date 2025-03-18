
/* Crear la base de datos */
create database if not exists tallerConsultas;

use tallerConsultas;

/* Crear las tablas */

create table if not exists departamentos(
	idDepto varchar(5) primary key,
    nombreDepto varchar(30) not null
);

create table if not exists empleados(
	idEmpleado varchar(16) primary key,
    idDeptoFK varchar(5) not null,
    nombreEmpleado varchar(50) not null,
    edadempleado varchar(3) not null,
    salarioEmpleado int not null,
    anioContrato year not null,
    foreign key (idDeptoFK) references departamentos(idDepto) on delete cascade /* Relacion 1 departamento a muchos empleados*/
);

/* Creamos datos para poder relaizar la consulta */

INSERT INTO departamentos (idDepto, nombreDepto) VALUES
('D001', 'Recursos Humanos'),
('D002', 'IT'),
('D003', 'Contabilidad'),
('D004', 'Ventas'),
('D005', 'Marketing');

INSERT INTO empleados (idEmpleado, idDeptoFK, nombreEmpleado, edadempleado, salarioEmpleado, anioContrato) VALUES
('E0001', 'D001', 'Ana Pérez', '35', 50000, 2015),
('E0002', 'D002', 'Carlos Gómez', '29', 75000, 2018),
('E0003', 'D002', 'Lucía Fernández', '32', 72000, 2017),
('E0004', 'D003', 'Javier Rodríguez', '40', 65000, 2012),
('E0005', 'D003', 'Sofía Martínez', '38', 63000, 2014),
('E0006', 'D004', 'David Ramírez', '27', 55000, 2020),
('E0007', 'D004', 'Andrea Torres', '30', 57000, 2019),
('E0008', 'D005', 'Fernando López', '33', 60000, 2016),
('E0009', 'D005', 'Marta Sánchez', '28', 59000, 2021);

/* Punto 1 */
select nombreEmpleado, edadEmpleado,salarioempleado from empleados;

/* Punto 2 */
select nombreEmpleado, salarioEmpleado from empleados where salarioEmpleado >= 4000;

/* Punto 3 */
select nombreEmpleado, salarioEmpleado from empleados where idDeptoFK = 'D004';

/* Punto 4 */
select nombreEmpleado, edadEmpleado from empleados where edadEmpleado > 30 and edadEmpleado < 40;

/* Punto 5 */
select nombreEmpleado, anioContrato from empleados where anioContrato > 2020;

/* Punto 6 */
select count(*)  as total from empleados where idDeptoFK = 'D001';
select count(*)  as total from empleados where idDeptoFK = 'D002';
select count(*)  as total from empleados where idDeptoFK = 'D003';
select count(*)  as total from empleados where idDeptoFK = 'D004';
select count(*)  as total from empleados where idDeptoFK = 'D005';

/* Punto 7 */
select avg(salarioEmpleado)  as total from empleados;

 /* Punto 8 */
 select nombreEmpleado from empleados where nombreEmpleado like 'A%' or nombreEmpleado like 'C%';
 
/* Punto 9 */
select nombreEmpleado, idDeptoFK from empleados where idDeptoFK != 'D002';

/* Punto 10 */
select nombreEmpleado, MAX(salarioEmpleado) from empleados;

/*   drop database tallerConsultas;   */
