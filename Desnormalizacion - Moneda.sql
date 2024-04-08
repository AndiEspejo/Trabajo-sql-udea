--Ejecutar este script después de insertar los datos a la base de datos

-- Crear tabla moneda
CREATE TABLE Moneda (
    Id SERIAL PRIMARY KEY,
    Moneda VARCHAR(100) NOT NULL,
    Sigla VARCHAR(5) NOT NULL,
    Imagen bytea NULL
);

-- Agregar Columna idMoneda
ALTER TABLE Pais
ADD COLUMN IdMoneda INTEGER;

-- Llenar la tabla moneda con las monedas que hay en pais
INSERT INTO Moneda (Moneda, Sigla)
SELECT DISTINCT Moneda, ''
FROM Pais;

-- Actualizar la tabla idMoneda comparando con el id de la tabla moneda
UPDATE Pais
SET IdMoneda = (SELECT Id FROM Moneda WHERE Moneda.Moneda = Pais.Moneda)
WHERE Moneda IS NOT NULL;

--Agregar la llave foranea para relacionar Moneda y Pais
ALTER TABLE Pais
ADD CONSTRAINT fkPais_IdMoneda FOREIGN KEY (IdMoneda)
    REFERENCES Moneda(Id);

-- Hacer Drop de la columna Moneda de la tabla pais
ALTER TABLE Pais
DROP COLUMN Moneda;

-- Agregar Mapa y Bandera a la tabla pais
ALTER TABLE pais
ADD COLUMN Mapa bytea NULL,
ADD COLUMN Bandera bytea NULL;
