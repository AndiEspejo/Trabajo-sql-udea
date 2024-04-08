--Ejecutar este script después de insertar los datos a la base de datos o antes si los datos se ajustan a la estructura de la base de datos

-- Crear tabla moneda
CREATE TABLE Moneda (
    Id SERIAL PRIMARY KEY,
    Moneda VARCHAR(100) NOT NULL,
    Sigla VARCHAR(5) NOT NULL,
    Imagen BYTEA
);

-- Crear indice para Moneda ordenado por Moneda
CREATE UNIQUE INDEX ixMoneda_Moneda
	ON Moneda(Moneda);

-- Agregar atributo idMoneda
ALTER TABLE Pais
ADD COLUMN IdMoneda INTEGER;

-- Llenar la tabla moneda con las monedas que hay en pais
INSERT INTO Moneda (Moneda, Sigla)
SELECT DISTINCT Moneda, ''
FROM Pais;

-- Actualizar el atributo idMoneda comparando con el id de la tabla moneda
UPDATE Pais
SET IdMoneda = (SELECT Id FROM Moneda WHERE Moneda.Moneda = Pais.Moneda)
WHERE Moneda IS NOT NULL;

--Agregar la tabla foranea para relacionar Moneda y Pais
ALTER TABLE Pais
ADD CONSTRAINT fkPais_IdMoneda FOREIGN KEY (IdMoneda)
    REFERENCES Moneda(Id);

-- Agregar columnas Mapa y Bandera a la tabla pais
ALTER TABLE pais
ADD COLUMN Mapa BYTEA,
ADD COLUMN Bandera BYTEA;

-- Hacer Drop de la columna Moneda de la tabla pais
ALTER TABLE Pais
DROP COLUMN Moneda;
