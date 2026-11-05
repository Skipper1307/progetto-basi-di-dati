# Progetto Basi di Dati

Questo repository contiene il materiale relativo al progetto per l'esame di **Basi di Dati e Sistemi Informativi**. Il progetto comprende l'analisi dei requisiti, la modellazione concettuale e logica, e la relativa implementazione in SQL.

---

## 📁 Struttura del Repository

La cartella del progetto contiene i seguenti file:

| File | Descrizione |
| :--- | :--- |
| `Relazione progetto BDSI.pdf` | Documento di progetto completo contenente la traccia, la progettazione concettuale (schema E-R), la progettazione logica e le scelte implementative. |
| `Progetto.sql` | Script SQL principale contenente la creazione del DB, le tabelle, i dati iniziali, le query di verifica, viste, stored procedure, funzioni e trigger. |
| `Progetto.txt` | Copia in formato testo dello script SQL per una rapida consultazione online. |
| `Societa.txt` | Dataset CSV/TXT utilizzato per l'importazione automatica delle società sportive tramite `LOAD DATA LOCAL INFILE`. |

---

## 🗄️ Struttura del Database (`Atletica`)

Il database si compone di 5 tabelle principali e 1 tabella per lo storico:
- **`Societa`**: Anagrafica delle società sportive (chiave primaria: `Nome`).
- **`Atleta`**: Informazioni personali e di tesseramento degli atleti, aggregate per categoria (`E`, `R`, `C`, `A`, `J`, `P`, `S`) e genere.
- **`Competizione`**: Eventi agonistici catalogati per livello (`Provinciale`, `Regionale`, `Nazionale`, `Olimpiade`).
- **`Prestazione`**: Risultati tecnici conseguiti dagli atleti (tempi, misure, condizioni meteo/vento, posizioni).
- **`Partecipazione`**: Tabelle di associazione M:N tra atleti e competizioni.
- **`StoricoSocieta`**: Tabella di auditing popolata automaticamente da un trigger in caso di cambio società.

---

## 🛠️ Requisiti e Installazione

### Requisiti
* **RDBMS**: MySQL (v8.0+) o MariaDB.
* **Client SQL**: MySQL Workbench, DBeaver o riga di comando MySQL.

### Esecuzione dello Script
Il file `Progetto.sql` contiene già le istruzioni `CREATE DATABASE IF NOT EXISTS Atletica;` e `USE Atletica;`. Per eseguirlo:

1. Assicurati che il file `Societa.txt` sia presente nella cartella di lavoro corrente o aggiorna il percorso nel comando:
   ```sql
   LOAD DATA LOCAL INFILE "Societa.txt" INTO TABLE Societa ...
