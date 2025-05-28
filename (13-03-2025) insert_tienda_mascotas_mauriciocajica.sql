INSERT INTO Mascota (idMascota, nombreMascota, generoMascota, razaMascota, cantidad)
VALUES 
(1, 'Max', 'Macho', 'Labrador', 1),
(2, 'Luna', 'Hembra', 'Poodle', 1),
(3, 'Rocky', 'Macho', 'Bulldog', 1),
(4, 'Mia', 'Hembra', 'Chihuahua', 1),
(5, 'Toby', 'Macho', 'Beagle', 1);

INSERT INTO Cliente (cedulaCliente, nombreCliente, apellidoCliente, direccionCliente, telefono, idMascotaFK)
VALUES 
(1, 'Juan', 'Perez', 'Calle 1', 1234567890, 1),
(2, 'Maria', 'Gomez', 'Calle 2', 1234567891, 2),
(3, 'Carlos', 'Lopez', 'Calle 3', 1234567892, 3),
(4, 'Ana', 'Rodriguez', 'Calle 4', 1234567893, 4),
(5, 'Luis', 'Fernandez', 'Calle 5', 1234567894, 5);

/* Insertar datos en la tabla Producto */
INSERT INTO Producto (codigoProducto, nombreProducto, marca, precio, cedulaClienteFK)
VALUES 
(201, 'Collar', 'PetSafe', 15.99, 1),
(202, 'Comida', 'Purina', 25.50, 2),
(203, 'Juguete', 'KONG', 10.75, 3),
(204, 'Cama', 'PawHut', 40.00, 4),
(205, 'Correa', 'Flexi', 18.30, 5);

INSERT INTO Vacuna (codigoVacuna, nombreVacuna, dosisVacuna, enfermedad)
VALUES 
(301, 'Rabia', 1, 'Rabia'),
(302, 'Parvovirus', 2, 'Parvovirus'),
(303, 'Moquillo', 2, 'Moquillo'),
(304, 'Hepatitis', 1, 'Hepatitis'),
(305, 'Leptospirosis', 2, 'Leptospirosis');

INSERT INTO Mascota_Vacuna (codigoVacunaFK, idMascotaFK, enfermedad)
VALUES 
(301, 1, 'Rabia'),
(302, 2, 'Parvovirus'),
(303, 3, 'Moquillo'),
(304, 4, 'Hepatitis'),
(305, 5, 'Leptospirosis');
