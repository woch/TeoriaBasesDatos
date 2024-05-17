
//Comandos de Docker

//Obtener Imagen
docker pull mysql:lts-oraclelinux9


//Iniciar contenedor
docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=C0ntrol1 -d mysql:innovation-oraclelinux9 



// MySQL 
// DDL
-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS sistema_facturacion;
USE sistema_facturacion;

-- Crear la tabla Cliente
CREATE TABLE Cliente (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla Edificio
CREATE TABLE Edificio (
    IdEdificio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(200) NOT NULL
);

-- Crear la tabla Medidor
CREATE TABLE Medidor (
    IdMedidor INT AUTO_INCREMENT PRIMARY KEY,
    IdCliente INT NOT NULL,
    IdEdificio INT NOT NULL,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (IdEdificio) REFERENCES Edificio(IdEdificio)
);

-- Crear la tabla Personal
CREATE TABLE Personal (
    IdPersonal INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla Lectura
CREATE TABLE Lectura (
    IdLectura INT AUTO_INCREMENT PRIMARY KEY,
    IdMedidor INT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LecturaIni DECIMAL(10, 2) NOT NULL,
    LecturaFin DECIMAL(10, 2) NOT NULL,
    IdPersonal INT NOT NULL,
    FOREIGN KEY (IdMedidor) REFERENCES Medidor(IdMedidor),
    FOREIGN KEY (IdPersonal) REFERENCES Personal(IdPersonal)
);

-- Crear la tabla Tarifa
CREATE TABLE Tarifa (
    IdTarifa INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL
);

-- Crear la tabla Cargo
CREATE TABLE Cargo (
    IdCargo INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(100) NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL
);

-- Crear la tabla Consumo
CREATE TABLE Consumo (
    IdConsumo INT AUTO_INCREMENT PRIMARY KEY,
    IdLectura INT NOT NULL,
    IdTarifa INT NOT NULL,
    IdCargo INT,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdLectura) REFERENCES Lectura(IdLectura),
    FOREIGN KEY (IdTarifa) REFERENCES Tarifa(IdTarifa),
    FOREIGN KEY (IdCargo) REFERENCES Cargo(IdCargo)
);

-- Crear la tabla Factura
CREATE TABLE Factura (
    IdFactura INT AUTO_INCREMENT PRIMARY KEY,
    IdCliente INT NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- Crear la tabla Pago
CREATE TABLE Pago (
    IdPago INT AUTO_INCREMENT PRIMARY KEY,
    IdFactura INT NOT NULL,
    Monto DECIMAL(10, 2) NOT NULL,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura)
);

-- Crear la tabla que relaciona Factura y Consumo
CREATE TABLE FacturaConsumo (
    IdFactura INT NOT NULL,
    IdConsumo INT NOT NULL,
    PRIMARY KEY (IdFactura, IdConsumo),
    FOREIGN KEY (IdFactura) REFERENCES Factura(IdFactura),
    FOREIGN KEY (IdConsumo) REFERENCES Consumo(IdConsumo)
);


USE sistema_facturacion;

-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (Nombre) VALUES
('Juan Perez'),
('Maria Gomez'),
('Carlos Sanchez');

-- Insertar datos en la tabla Edificio
INSERT INTO Edificio (Nombre, Direccion) VALUES
('Edificio Central', 'Calle Principal 123'),
('Edificio Norte', 'Avenida Secundaria 456');

-- Insertar datos en la tabla Medidor
INSERT INTO Medidor (IdCliente, IdEdificio) VALUES
(1, 1),
(2, 2),
(3, 1);

-- Insertar datos en la tabla Personal
INSERT INTO Personal (Nombre) VALUES
('Ana Lopez'),
('Luis Martinez'),
('Pedro Fernandez');

-- Insertar datos en la tabla Lectura
INSERT INTO Lectura (IdMedidor, LecturaIni, LecturaFin, IdPersonal) VALUES
(1, 100.0, 150.0, 1),
(2, 200.0, 250.0, 2),
(3, 300.0, 350.0, 3);

-- Insertar datos en la tabla Tarifa
INSERT INTO Tarifa (Tipo, Precio) VALUES
('Bajo Consumidor', 0.10),
('Medio Consumidor', 0.15),
('Alto Consumidor', 0.20);

-- Insertar datos en la tabla Cargo
INSERT INTO Cargo (Descripcion, Monto) VALUES
('Cargo por Alumbrado Público', 5.00),
('Ajuste por Combustible', 3.00),
('Cargo por Comercialización', 2.00),
('Pérdidas por Transformación', 1.00);

-- Insertar datos en la tabla Consumo
INSERT INTO Consumo (IdLectura, IdTarifa, IdCargo, Total) VALUES
(1, 1, 1, 55.00),
(2, 2, 2, 82.50),
(3, 3, 3, 105.00);

-- Insertar datos en la tabla Factura
INSERT INTO Factura (IdCliente, Total) VALUES
(1, 55.00),
(2, 82.50),
(3, 105.00);

-- Insertar datos en la tabla Pago
INSERT INTO Pago (IdFactura, Monto) VALUES
(1, 55.00),
(2, 82.50),
(3, 105.00);

-- Insertar datos en la tabla FacturaConsumo
INSERT INTO FacturaConsumo (IdFactura, IdConsumo) VALUES
(1, 1),
(2, 2),
(3, 3);
