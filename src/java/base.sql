/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/SQLTemplate.sql to edit this template
 */
/**
 * Author:  i.m.a
 * Created: Jan 29, 2023
 */
DROP TABLE IF EXISTS Avion CASCADE;
DROP TABLE IF EXISTS AvionCategorie CASCADE;
DROP TABLE IF EXISTS Categorie CASCADE;
DROP TABLE IF EXISTS Client CASCADE;
DROP TABLE IF EXISTS placeReserve CASCADE;
DROP TABLE IF EXISTS ReservationClient CASCADE;
DROP TABLE IF EXISTS Vol CASCADE;
DROP SEQUENCE seq_Client;

CREATE SEQUENCE seq_Client;
CREATE TABLE Avion (
  id  SERIAL NOT NULL, 
  nom varchar(80), 
  PRIMARY KEY (id)
);

CREATE TABLE AvionCategorie (
  Avionid     int4 NOT NULL, 
  Categorieid int4 NOT NULL, 
  placeDebut  int4, 
  placeFin    int4, 
  prix        float8
);

CREATE TABLE Categorie (
  id    SERIAL NOT NULL, 
  label varchar(80), 
  PRIMARY KEY (id)
);

CREATE TABLE Client (
  id     int4 NOT NULL, 
  nom    varchar(80), 
  prenom int4, 
  PRIMARY KEY (id)
);

CREATE TABLE placeReserve (
  id                  SERIAL NOT NULL, 
  numero              int4 NOT NULL, 
  ReservationClientid int4 NOT NULL, 
  PRIMARY KEY (id)
);

CREATE TABLE ReservationClient (
  id            SERIAL NOT NULL, 
  Clientid      int4 NOT NULL, 
  Volid         int4 NOT NULL, 
  Categorieid   int4 NOT NULL, 
  nombreDePlace int4 NOT NULL, 
  PRIMARY KEY (id)
);

CREATE TABLE Vol (
  id        SERIAL NOT NULL, 
  dateDeVol timestamp, 
  nomDuVol  varchar(70) NOT NULL UNIQUE, 
  pays      varchar(80), 
  Avionid   int4 NOT NULL, 
  PRIMARY KEY (id)
);

ALTER TABLE AvionCategorie ADD CONSTRAINT FKAvionCateg959797 FOREIGN KEY (Avionid) REFERENCES Avion (id);
ALTER TABLE AvionCategorie ADD CONSTRAINT FKAvionCateg512929 FOREIGN KEY (Categorieid) REFERENCES Categorie (id);
ALTER TABLE Vol ADD CONSTRAINT FKVol561819 FOREIGN KEY (Avionid) REFERENCES Avion (id);
ALTER TABLE ReservationClient ADD CONSTRAINT FKReservatio60111 FOREIGN KEY (Clientid) REFERENCES Client (id);
ALTER TABLE ReservationClient ADD CONSTRAINT FKReservatio655976 FOREIGN KEY (Volid) REFERENCES Vol (id);
ALTER TABLE ReservationClient ADD CONSTRAINT FKReservatio213241 FOREIGN KEY (Categorieid) REFERENCES Categorie (id);
ALTER TABLE placeReserve ADD CONSTRAINT FKplaceReser5603 FOREIGN KEY (ReservationClientid) REFERENCES ReservationClient (id);
