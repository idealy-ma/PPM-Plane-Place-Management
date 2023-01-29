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
  prenom varchar(80), 
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

-- Insert

INSERT INTO avion VALUES (default, 'Boeing-314');
INSERT INTO avion VALUES (default, 'Boeing-315');

INSERT INTO categorie VALUES (default, 'Business Class');
INSERT INTO categorie VALUES (default, 'Live Class');
INSERT INTO categorie VALUES (default, 'Premium Class');


INSERT INTO avionCategorie VALUES (1, 1, 1, 10, 5000000);
INSERT INTO avionCategorie VALUES (1, 2, 11, 20, 12000000);
INSERT INTO avionCategorie VALUES (1, 3, 20, 30, 30000000);

INSERT INTO vol VALUES (default, '2023-12-10 13:00', 'VO-01', 'MG-USA', 1);
INSERT INTO vol VALUES (default, '2023-12-10 14:00', 'VO-02', 'MG-FRS', 1);

INSERT INTO client VALUES (nextval('seq_Client'), 'RAZAFY', 'Idealy');
INSERT INTO client VALUES (nextval('seq_Client'), 'RAZAFY', 'Sarobidy');
INSERT INTO client VALUES (nextval('seq_Client'), 'RANDRIA', 'Holy');
INSERT INTO client VALUES (nextval('seq_Client'), 'RAZAFY', 'Tovo');

INSERT INTO reservationclient VALUES (default, 1, 1, 1, 2);
INSERT INTO reservationclient VALUES (default, 2, 1, 2, 3);
INSERT INTO reservationclient VALUES (default, 3, 1, 3, 2);
INSERT INTO reservationclient VALUES (default, 4, 1, 1, 1);

create or replace view v_detailsAvion AS(
    SELECT avioncategorie.avionid,
           avion.nom,
           avioncategorie.categorieid,
           categorie.label,
           placedebut,
           placefin,
           (placefin-placedebut)+1 nombreDePlace,
           prix
    FROM avionCategorie 
    join avion on avion.id = avioncategorie.avionid
    join categorie on avioncategorie.categorieid = categorie.id
);

SELECT vol.*, avion.nom 
FROM vol
JOIN avion
ON avion.id = vol.avionid
WHERE vol.id=1;

SELECT reservationclient.clientid, 
       client.nom,
       client.prenom,
       reservationclient.nombredeplace,
       vol.*
FROM reservationclient
JOIN vol
ON vol.id = reservationclient.volid
JOIN client
ON client.id = reservationclient.clientid;

DROP VIEW v_nombre_place_by_cat_by_vol;
CREATE OR REPLACE VIEW v_nombre_place_by_cat_by_vol AS(
    SELECT reservationclient.categorieid, sum(nombredeplace) nombredeplace, reservationclient.volid
    FROM reservationclient
    JOIN vol
    ON vol.id = reservationclient.volid
    GROUP BY categorieid, reservationclient.volid
);

SELECT * FROM v_detailsavion;
SELECT * FROM avioncategorie;
SELECT * FROM reservationclient;
SELECT * FROM v_nombre_place_by_cat_by_vol;
SELECT * FROM v_details_vol;
SELECT * FROM vol;

CREATE OR REPLACE VIEW v_details_vol AS(
    SELECT vol.*,
           v_detailsavion.nom,
           v_detailsavion.categorieid,
           v_detailsavion.label,
           (v_detailsavion.nombredeplace-v_nombre_place_by_cat_by_vol.nombredeplace) placeDispo
    FROM v_nombre_place_by_cat_by_vol
    JOIN vol
    ON vol.id = v_nombre_place_by_cat_by_vol.volid
    JOIN v_detailsavion
    ON v_detailsavion.categorieid = v_nombre_place_by_cat_by_vol.categorieid
);

SELECT * 
FROM reservationclient
WHERE clientid = 1;