USE master
IF DB_ID('BASEDATOS') IS NOT NULL
	DROP DATABASE BASEDATOS
GO
CREATE DATABASE BASEDATOS
GO
USE BASEDATOS
GO
--============TABLAS================================================
CREATE TABLE DEPARTAMENTO(
	IDDEPARTAMENTO INT PRIMARY KEY IDENTITY,
	NOM_DEP VARCHAR(50)
)
GO
create table PAIS 
(
id_pais int identity(1,1) not null primary key,
nom_pais varchar(30) unique not null,
)
go

CREATE TABLE PERSONAL(
	IDPERSONAL INT PRIMARY KEY IDENTITY,
	NOM_PER VARCHAR(50),
	IDDEPARTAMENTO INT NOT NULL FOREIGN KEY REFERENCES DEPARTAMENTO,
	IDPAIS INT NOT NULL FOREIGN KEY REFERENCES PAIS(id_pais),
	SUELDO DECIMAL(9,2),
	FEC_CONT DATE,
	EST_PER CHAR(1)
)
--======================REGISTROS=====================================
go
INSERT INTO DEPARTAMENTO VALUES('Administración'),('Contabilidad'),('Marketing'),('Sistemas'),('Ventas')
go

INSERT INTO PAIS VALUES('Perú'),('Argentina'),('Chile')
go

INSERT INTO PERSONAL VALUES('Juan Carlos Alva Castro',1,1,4500,'20001010','A')
INSERT INTO PERSONAL VALUES('Marco Antonio Medina Gonzáles',4,2,3500,'19980506','A')
INSERT INTO PERSONAL VALUES('Ana María Herrera Diaz',2,3,3000,'20011107','A')
go
--====================PROCEDIMIENTOS ALMACENADOS=======================

CREATE PROCEDURE pa_ListaDepartamentos
as
SELECT * FROM DEPARTAMENTO

GO

Create Procedure pa_ListaPais
as
select * from PAIS
go
CREATE PROCEDURE pa_ListaPersonal
as
SET DATEFORMAT DMY
SELECT P.IDPERSONAL,P.NOM_PER,D.NOM_DEP,D.IDDEPARTAMENTO,PA.nom_pais,PA.id_pais,P.SUELDO,CONVERT(CHAR(10),P.FEC_CONT,103) AS FEC_CONT
	FROM PERSONAL P INNER JOIN DEPARTAMENTO D ON
		D.IDDEPARTAMENTO = P.IDDEPARTAMENTO
		INNER JOIN PAIS PA ON PA.id_pais = P.IDPAIS
		WHERE P.EST_PER='A'
GO

--modifco el sp
CREATE PROCEDURE pa_nuevoPersonal
@nombre varchar(50),
@iddep int,
@sueldo decimal(9,2),
@fecha varchar(10),
@est CHAR(1),
@idpais int
As
SET DATEFORMAT DMY
INSERT INTO PERSONAL VALUES(@nombre,@iddep,@idpais,@sueldo,convert(date,@fecha),@est)

GO
CREATE PROCEDURE pa_modificaPersonal
@idper int,
@nombre varchar(50),
@iddep int,
@sueldo decimal(9,2),
@fecha varchar(10),
@est CHAR(1),
@idpais int
As
SET DATEFORMAT DMY
UPDATE PERSONAL
SET NOM_PER=@nombre,
    IDDEPARTAMENTO=@iddep,
	SUELDO=@sueldo,
	FEC_CONT=CONVERT(date,@fecha),
	IDPAIS = @idpais
WHERE IDPERSONAL=@idper
GO



CREATE PROCEDURE pa_eliminaPersonal
@idper int
As
UPDATE PERSONAL
SET EST_PER='E'
WHERE IDPERSONAL=@idper

use BASEDATOS
go

exec pa_ListaPais

exec pa_ListaPersonal







