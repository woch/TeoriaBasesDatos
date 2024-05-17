
//Comandos de Docker

//Obtener Imagen
docker pull mysql:lts-oraclelinux9


//Iniciar contenedor
docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=C0ntrol1 -d mysql:innovation-oraclelinux9 



// MySQL 
// DDL

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS sistema_tickets;
USE sistema_tickets;


-- Crear la tabla Usuarios
CREATE TABLE Usuarios (
    IdUsuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Contrasena VARCHAR(100) NOT NULL
);

-- Crear la tabla Tickets
CREATE TABLE Tickets (
    IdTicket INT AUTO_INCREMENT PRIMARY KEY,
    IdUsuario INT NOT NULL,
    IdCtaegoria INT NOT NULL,
    Problema VARCHAR(100) NOT NULL,
    DescripcionProblema VARCHAR(300) NOT NULL UNIQUE,
    Estado ENUM('Abierto', 'Progreso', 'Cerrado') DEFAULT 'Abierto',
    FechaCreacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    SolucionFinal VARCHAR(300),
    FOREIGN KEY (IdUsuario) REFERENCES Usuarios(id),
    FOREIGN KEY (IdTicket) REFERENCES Categorias(id)
);


-- Crear la tabla Categoría
CREATE TABLE Categorias (
    IdCategorias INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(300)
);

-- Crear la tabla Equipo de Soporte
CREATE TABLE EquipoSoporte (
    IdAgente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Contrasena VARCHAR(300),
    Experiencia INT DEFAULT 0,
    CargaLaboral INT DEFAULT 0
);



-- Crear la tabla Procedimiento
CREATE TABLE Procedimiento (
    IdProcedimiento INT AUTO_INCREMENT PRIMARY KEY,
    IdTicket INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdTicket) REFERENCES Tickets(id)
);


-- Crear la tabla que relaciona Ticket y Equipo de soporte
CREATE TABLE UsuariosTickets (
    IdTicket INT NOT NULL,
    IdAgente INT NOT NULL,
    PRIMARY KEY (IdTicket, IdAgente),
    FOREIGN KEY (IdTicket) REFERENCES Tickets(id),
    FOREIGN KEY (IdAgente) REFERENCES EquipoSoporte(id)
);

//DML

USE sistema_tickets;

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (Nombre, Correo, Contrasena) VALUES
('Juan Perez', 'juan.perez@example.com', 'password123'),
('Maria Gomez', 'maria.gomez@example.com', 'password456'),
('Carlos Sanchez', 'carlos.sanchez@example.com', 'password789');

-- Insertar datos en la tabla Categorias
INSERT INTO Categorias (Nombre, Descripcion) VALUES
('Redes', 'Problemas relacionados con la conectividad de red'),
('Hardware', 'Problemas relacionados con los componentes físicos del equipo'),
('Software', 'Problemas relacionados con aplicaciones y sistemas operativos');

-- Insertar datos en la tabla Equipo de Soporte
INSERT INTO EquipoSoporte (Nombre, Correo, Contrasena, Experiencia, CargaLaboral) VALUES
('Ana Lopez', 'ana.lopez@example.com', 'securepass1', 5, 2),
('Luis Martinez', 'luis.martinez@example.com', 'securepass2', 3, 1),
('Pedro Fernandez', 'pedro.fernandez@example.com', 'securepass3', 4, 0);

-- Insertar datos en la tabla Tickets
INSERT INTO Tickets (IdUsuario, IdCtaegoria, Problema, DescripcionProblema, Estado, SolucionFinal) VALUES
(1, 1, 'Problema de conectividad', 'No puedo conectarme a la red Wi-Fi', 'Cerrado', 'Reconfiguración de la red Wi-Fi'),
(2, 2, 'Pantalla azul', 'El equipo muestra una pantalla azul al arrancar', 'Progreso', NULL),
(3, 3, 'Error de aplicación', 'La aplicación se cierra inesperadamente', 'Abierto', NULL);

-- Insertar datos en la tabla Procedimiento
INSERT INTO Procedimiento (IdTicket, Descripcion) VALUES
(1, 'Revisar configuraciones de red'),
(1, 'Reemplazar cable de red defectuoso'),
(2, 'Diagnosticar problema de hardware');

-- Insertar datos en la tabla UsuariosTickets
INSERT INTO UsuariosTickets (IdTicket, IdAgente) VALUES
(1, 1),
(2, 2),
(3, 3);
