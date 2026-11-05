# Luca Frezza 7109939

###################### CREAZIONE BASE DI DATI ######################

DROP DATABASE IF EXISTS Atletica;
CREATE DATABASE IF NOT EXISTS Atletica;
USE Atletica;

###################### CREAZIONE TABELLE ######################

DROP TABLE IF EXISTS Societa;

CREATE TABLE IF NOT EXISTS Societa(
    Nome VARCHAR(50) PRIMARY KEY, 
    Email VARCHAR(40) UNIQUE, 
    Numero_Di_Telefono varchar(10), 
    Via VARCHAR(40), 
    Citta VARCHAR(40), 
    CAP MEDIUMINT, 
    Provincia CHAR(2)
)ENGINE=INNODB;


DROP TABLE IF EXISTS Atleta;

CREATE TABLE IF NOT EXISTS Atleta(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(20), 
    Cognome VARCHAR(20),
    Genere ENUM('M', 'F'),
    Categoria ENUM ('E', 'R', 'C', 'A', 'J', 'P', 'S'),
    Nome_Societa VARCHAR(50),
    FOREIGN KEY (Nome_Societa)
        REFERENCES Societa (Nome)
        ON UPDATE CASCADE,
	Data_Di_Nascita DATE,
    Nazionalità VARCHAR (30)
)ENGINE=INNODB;    
 

DROP TABLE IF EXISTS Competizione;
    
CREATE TABLE IF NOT EXISTS Competizione(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(60), 
    Data_Competizione DATE,
    Luogo VARCHAR(30),
    Tipo ENUM ('Provinciale', 'Regionale', 'Nazionale', 'Olimpiade')
)ENGINE=INNODB; 
 
 
DROP TABLE IF EXISTS Prestazione;
    
CREATE TABLE IF NOT EXISTS Prestazione(
	ID INT PRIMARY KEY AUTO_INCREMENT,
    Risultato FLOAT, 
    Tipo ENUM ('Corsa', 'Salto', 'Lancio'),
    Descrizione VARCHAR(30),
    Vento FLOAT DEFAULT NULL,
    Data DATE,
    Posizione SMALLINT,
    ID_Atleta INT,
    FOREIGN KEY (ID_Atleta)
		REFERENCES Atleta (ID)
        ON UPDATE CASCADE,
    ID_Competizione INT,
    FOREIGN KEY (ID_Competizione)
		REFERENCES Competizione (ID)
        ON UPDATE CASCADE
)ENGINE=INNODB; 


DROP TABLE IF EXISTS Partecipazione;

CREATE TABLE IF NOT EXISTS Partecipazione(
	ID_Atleta INT,
    ID_Competizione INT,
    FOREIGN KEY (ID_Atleta)
		REFERENCES Atleta (ID)
        ON UPDATE CASCADE,
	FOREIGN KEY (ID_Competizione)
		REFERENCES Competizione (ID)
        ON UPDATE CASCADE,
	PRIMARY KEY(ID_Atleta, ID_Competizione)
)ENGINE=INNODB;


###################### POPOLAMENTO TABELLE ######################

INSERT INTO Competizione VALUES
(1, "Campionati regionali indivduali", "2024-06-09", "Genova", "Regionale"),
(2, "Campionato provinciale indiduale", "2024-06-09", "Padova", "Provinciale"),
(3, "Campionato italiano", "2024-06-10", "Roma", "Nazionale"),
(4, "Finale regionale CDS", "2024-06-08", "Molfetta", "Regionale"),
(5, "VII TROFEO DEI LAGHI PER RAPPRESENTATIVE PROVINCIALI", "2024-06-07", "Rovellasca", "Provinciale"),
(6, "III^ La Ultra di Saronno", "2024-06-07", "Saronno", "Regionale"),
(7, "3^ Fase CDS", "2024-07-07", "Salerno", "Nazionale"),
(8, "Giochi della XXXIII Olimpiade", "2024-07-26", "Parigi", "Olimpiade");


LOAD DATA LOCAL INFILE "Societa.txt" INTO TABLE Societa #inserire il proprio filepath
	FIELDS TERMINATED BY ","
	LINES TERMINATED BY "\r\n"
	IGNORE 1 ROWS;


INSERT INTO Atleta VALUES
(1, "Niccolò", "Pollicino", "M", "P", "Pistoia Atletica", "2004-09-03", "Italiana"),
(2, "Alessia", "Chiti", "F", "P", "Firenze Marathon", "2004-05-18", "Italiana"),
(3, "Filoippo", "Tortu", "M", "S", "Fiamme Gialle", "1999-02-20", "Italiana"),
(4, "Marcell", "Jacobs", "M", "S", "Fiamme Rosse", "1994-10-10", "Italiana"),
(5, "Luminosa", "Bogliolo", "F", "S", "Fiamme Oro", "1995-07-03", "Italiana"),
(6, "Leonardo", "Fabbri", "M", "S", "Fiamme Azzurre", "1998-01-01", "Italiana"),
(7, "Dalia", "Kaddari", "F", "S", "Fiamme Oro", "2001-03-23", "Italiana"),
(8, "Nadia", "Battocletti", "F", "S", "Fiamme Azzurre", "2000-04-12", "Italiana"),
(9, "Andrea", "Consolmagno", "M", "P", "Pistoia Atletica", "2002-05-15", "Italiana"),
(10, "Maria", "Moretti", "F", "E", "Pistoia Atletica", "2015-12-13", "Italiana"),
(11, "Asia", "Frogese", "F", "A", "Firenze Marathon", "2008-04-12", "Italiana"),
(12, "Federica", "Trincioni", "F", "J", "Firenze Marathon", "2006-11-24", "Italiana"),
(13, "Giada", "Carmassi", "F", "J", "Fiamme Gialle", "1994-05-15", "Italiana"),
(14, "Lorenzo", "Melisi", "M", "P", "Atletica Prato", "2003-01-13", "Italiana");

INSERT INTO Prestazione VALUES
(1, 10.89, "Corsa", "100 m", 0.5, "2024-06-01", 1, 1, 1),
(2, 6.37, "Salto", "Salto in lungo", -0.2, "2024-06-01", 19, 1, 1),
(3, 15.36, "Lancio", "Lancio del peso", NULL, "2024-05-18", 8, 6, 3),
(4, 1.74, "Salto", "Salto in alto", 0.0, "2024-05-18", 4, 5, 3),
(5, 10.02, "Corsa", "100 m", -0.4, "2024-05-18", 1, 4, 3),
(6, 13.85, "Corsa", "100 m", 0.1, "2024-05-18", 34, 2, 3),
(7, 20.18, "Corsa", "200 m", -1.5, "2024-06-11", 2, 3, 3),
(8, 21.22, "Corsa", "200 m", 2.0, "2024-06-09", 8, 9, 2),
(9, 75.72, "Lancio", "Lancio del giavellotto", NULL, "2024-07-07", 5, 6, 7),
(10, 12.95, "Corsa", "110 hs", 0, "2024-06-07", 6, 13, 6),
(11, 49.81, "Corsa", "400 m", 1.3, "2024-05-18", 3, 1, 3),
(12, 9.94, "Corsa", "100 m", 1.4, "2024-07-26", 1, 4, 8),
(13, 14.47, "Salto", "Salto triplo", 0.8, "2024-06-10", 12, 7, 3),
(14, 20.24, "Corsa", "200 m", 1.1, "2024-07-26", 4, 3, 8);

INSERT INTO Partecipazione VALUES
(4, 3),
(6, 3),
(5, 3),
(2, 3),
(3, 3),
(9, 2),
(6, 7),
(13, 6),
(1, 3),
(1, 1),
(4, 8),
(7, 3),
(3, 8);

UPDATE Atleta
	SET Nome = "Filippo" 
    WHERE ID = 3;

UPDATE Competizione
	SET Luogo = "Firenze"
    WHERE ID = 7;

DELETE FROM Atleta
	WHERE Nome = "Maria" AND Cognome = "Moretti";
    
    
###################### INTERROGAZIONI ######################

# Trovare gli atleti il cui cognome inizia per "B" oppure finisce per "i"
SELECT * FROM Atleta
	WHERE Cognome LIKE 'B%' OR Cognome LIKE '%i';

# Trovare Nome, Cognome degli atleti che hanno corso un 100 metri oppure un 200 metri
SELECT DISTINCT Nome, Cognome, Descrizione FROM Atleta 
	JOIN Prestazione ON Atleta.ID = Prestazione.ID_Atleta
	WHERE Descrizione IN ("100 m", "200 m"); 
    
# Trovare Nome, Cognome, Data di nascita e Risultato dell'atleta più veloce sui 100 metri
SELECT Nome, Cognome, Data_Di_Nascita, Risultato AS Miglior_Risultato FROM Atleta 
	JOIN Prestazione ON Atleta.ID = Prestazione.ID_Atleta
	WHERE Descrizione = '100 m' AND Risultato = (
    SELECT MIN(Risultato) FROM Prestazione WHERE Descrizione = '100 m');

# Seleziona per ogni Societa i relativi tesserati
#SET sql_mode=(SELECT REPLACE (@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
SELECT Societa.Nome, GROUP_CONCAT(CONCAT(Atleta.nome, ' ', cognome)) AS Tesserati FROM Atleta 
	JOIN Societa ON Societa.Nome = Atleta.Nome_Societa 
    GROUP BY Societa.Nome;
    
# Trovare per ogni competizione tutti gli atleti maschi che vi hanno partecipato
SELECT Competizione.Nome, GROUP_CONCAT(CONCAT(Atleta.nome, ' ', cognome)) AS Iscritti FROM Atleta 
	JOIN Partecipazione ON Atleta.ID = Partecipazione.ID_Atleta 
	JOIN Competizione ON Competizione.ID = Partecipazione.ID_Competizione
    WHERE Genere = 'M'
    GROUP BY Competizione.Nome;

# Trovare Nome, Cognome, Data_Di_Nascita degli atleti che NON hanno mai gareggiato
DROP VIEW IF EXISTS AtletiGareggiato;
CREATE VIEW AtletiGareggiato AS 
	SELECT A.ID, Nome, Cognome, Data_Di_Nascita
    FROM Atleta A JOIN Prestazione P ON A.ID = P.ID_Atleta
    GROUP BY A.ID; # Atleti che hanno gareggiato

Select A.ID, A.Nome, A.Cognome, A.Data_Di_Nascita
	FROM Atleta A 
    WHERE NOT EXISTS (SELECT AG.ID FROM AtletiGareggiato AG WHERE AG.ID = A.ID);

DROP VIEW AtletiGareggiato;

# Trovare l'atleta che ha partecipato al maggior numero di competizioni
CREATE VIEW AtletiGareggiato AS
	SELECT Atleta.nome, Count(*) AS NumeroCompetizioni FROM Atleta 
	JOIN Partecipazione ON Atleta.ID = Partecipazione.ID_Atleta 
	JOIN Competizione ON Competizione.ID = Partecipazione.ID_Competizione
    GROUP BY Atleta.Nome;

SELECT A.ID, A.Nome, A.Cognome
	FROM Atleta A NATURAL JOIN AtletiGareggiato AG
	WHERE NumeroCompetizioni=(SELECT max(NumeroCompetizioni) FROM AtletiGareggiato);
    
DROP VIEW AtletiGareggiato;


###################### PROCEDURE E FUNZIONI ######################

DROP PROCEDURE IF EXISTS GetAtletiBySoceita;

DELIMITER $$

CREATE PROCEDURE GetAtletiBySocieta(IN societa_nome VARCHAR(50))
	COMMENT "Stampa l'elenco degli atleti di una determinata società"
    SELECT Nome, Cognome, Data_Di_Nascita 
    FROM Atleta
	WHERE Nome_Societa = societa_nome $$

DELIMITER ;

CALL GetAtletiBySocieta('Fiamme Gialle');


DROP PROCEDURE IF EXISTS GetAtletiPrestazioniByCompetizione;

DELIMITER $$

CREATE PROCEDURE GetAtletiPrestazioniByCompetizione(IN competizione_nome VARCHAR(60))
COMMENT "Dato il nome di una competizione restituisce gli atleti che vi hanno partecipato con la relativa prestazione"
BEGIN
    DECLARE competizione_id INT;
    
    # Recupera l'ID della competizione dato il nome
    SELECT ID INTO competizione_id
    FROM Competizione
    WHERE Nome = competizione_nome;
    
    # Recupera gli atleti e le loro prestazioni nella competizione specificata
    SELECT A.Nome AS Nome_Atleta, A.Cognome AS Cognome_Atleta, P.Descrizione AS Prestazione, P.Risultato, P.Vento, P.Data, P.Posizione
    FROM Atleta AS A
    JOIN Prestazione AS P ON A.ID = P.ID_Atleta
    WHERE P.ID_Competizione = competizione_id;
    
END $$

DELIMITER ;

CALL GetAtletiPrestazioniByCompetizione('Campionato Italiano');


DROP FUNCTION IF EXISTS GetAtletaCompetizioniByAnno;

DELIMITER $$

CREATE FUNCTION GetAtletaCompetizioniByAnno(atleta_id INT, anno_competizione YEAR)
RETURNS VARCHAR(200)
COMMENT "Restituisce una stringa con Nome, Cognome, Numero di competizioni svolte in un determinato anno"
DETERMINISTIC
BEGIN
    DECLARE num_competizioni INT;
    DECLARE atleta_nome VARCHAR(20);
    DECLARE atleta_cognome VARCHAR(20);
    DECLARE risultato VARCHAR(200);
	
    IF (anno_competizione)>YEAR(NOW())
		THEN RETURN NULL;
	ELSE
		# Conta il numero di competizioni a cui ha partecipato l'atleta nell'anno specificato
		SELECT COUNT(DISTINCT ID_Competizione) INTO num_competizioni
		FROM Partecipazione AS P
		JOIN Competizione AS C ON P.ID_Competizione = C.ID
		WHERE P.ID_Atleta = atleta_id AND YEAR(C.Data_Competizione) = anno_competizione;

		# Ottiene il nome e il cognome dell'atleta
		SELECT Nome, Cognome INTO atleta_nome, atleta_cognome
		FROM Atleta
		WHERE ID = atleta_id;

		# Risultato come una stringa
		SET risultato = CONCAT('Nome: ', atleta_nome, ', Cognome: ', atleta_cognome, ', Numero di Competizioni: ', num_competizioni);

		RETURN risultato;
    END IF;
END $$

DELIMITER ;

SELECT GetAtletaCompetizioniByAnno(4, 2024);


###################### VISTE ######################

DROP VIEW IF EXISTS TesseratiFiammeGialle;

CREATE VIEW TesseratiFiammeGialle AS
	SELECT * FROM Atleta A
    WHERE A.Nome_Societa = "Fiamme Gialle"
	WITH LOCAL CHECK OPTION;
SELECT * FROM TesseratiFiammeGialle;

# LOCAL CHECK OPTION NON permette l'inserimento errato:
# INSERT INTO TesseratiFiammeGialle VALUES(20, "Gianmarco", "Tamberi", "M", "P", "Fiamme Rosse", "1992-06-01", "Italiana"); 

INSERT INTO TesseratiFiammeGialle VALUES(20, "Gianmarco", "Tamberi", "M", "P", "Fiamme Gialle", "1992-06-01", "Italiana"); 
SELECT * FROM TesseratiFiammeGialle;
Select * FROM Atleta where nome_societa = "Fiamme Gialle";


###################### TRIGGER ######################

DROP TABLE IF EXISTS StoricoSocieta;

CREATE TABLE IF NOT EXISTS StoricoSocieta (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_Atleta INT,
    Vecchia_Societa VARCHAR(50),
    Nuova_Societa VARCHAR(50),
    Data_Inizio DATE,
    Data_Fine DATE,
    FOREIGN KEY (ID_Atleta) REFERENCES Atleta(ID)
        ON UPDATE CASCADE
)ENGINE=INNODB;

DELIMITER $$

CREATE TRIGGER trigger_CambioSocieta
BEFORE UPDATE ON Atleta
FOR EACH ROW
BEGIN
    IF OLD.Nome_Societa != NEW.Nome_Societa THEN
        INSERT INTO StoricoSocieta (
            ID_Atleta,
            Vecchia_Societa,
            Nuova_Societa,
            Data_Inizio,
            Data_Fine
        ) VALUES (
            OLD.ID,
            OLD.Nome_Societa,
            NEW.Nome_Societa,
            (SELECT MIN(Data_Competizione) FROM Competizione WHERE ID IN (SELECT ID_Competizione FROM Prestazione WHERE ID_Atleta = OLD.ID)),
            CURDATE()
        );
    END IF;
END $$

DELIMITER ;

UPDATE Atleta
	SET Nome_Societa = "Fiamme Azzurre" 
    WHERE ID = 2;
SELECT * FROM StoricoSocieta;