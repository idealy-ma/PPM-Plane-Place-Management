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
  id     SERIAL NOT NULL, 
  nom    varchar(80), 
  range  int4, 
  colone int4, 
  PRIMARY KEY (id)
);

CREATE TABLE AvionCategorie (
  Avionid     int4 NOT NULL, 
  Categorieid int4 NOT NULL, 
  placeDebut  int4, 
  placeFin    int4
);

CREATE TABLE Categorie (
  id    SERIAL NOT NULL, 
  label varchar(80), 
  PRIMARY KEY (id)
);

CREATE TABLE Client (
  id            int4 NOT NULL, 
  nom           varchar(80), 
  prenom        varchar(80), 
  dateNaissance date, 
  PRIMARY KEY (id)
);

drop table if exists placeinvalide cascade;
CREATE TABLE PlaceInvalide (
  ReservationClientid int4 NOT NULL, 
  range               int4, 
  colone              int4
);

drop table if exists placeReserve cascade;
CREATE TABLE placeReserve (
  id                  SERIAL NOT NULL, 
  ReservationClientid int4 NOT NULL, 
  range               int4, 
  colonne             int4, 
  PRIMARY KEY (id)
);

drop table if exists placerestriction cascade; 
CREATE TABLE PlaceRestriction (
  ReservationClientid int4 NOT NULL, 
  range               int4, 
  colone              int4
);

drop table if exists Promotion cascade;
CREATE TABLE Promotion (
  id          SERIAL NOT NULL, 
  pourcentage float8, 
  dateDebut   int4, 
  dateFin     int4, 
  Volid       int4 NOT NULL, 
  PRIMARY KEY (id)
);

CREATE TABLE ReservationClient (
  id            SERIAL NOT NULL, 
  Clientid      int4 NOT NULL, 
  Volid         int4 NOT NULL, 
  Categorieid   int4 NOT NULL, 
  nombreDePlace int4 NOT NULL,
  dateDeReservation timestamp default current_timestamp,
  PRIMARY KEY (id)
);

drop table if exists tarifvol cascade; 
CREATE TABLE TarifVol (
  Categorieid int4 NOT NULL, 
  Volid       int4 NOT NULL, 
  prix        float8
);

CREATE TABLE Vol (
  id        SERIAL NOT NULL, 
  dateDeVol timestamp, 
  nomDuVol  varchar(70) NOT NULL UNIQUE, 
  pays      varchar(80), 
  Avionid   int4 NOT NULL, 
  PRIMARY KEY (id)
);

CREATE TABLE clientReserver (
    reservationId int references reservationClient(id),
    clientId int references client(id),
    classId int references categorie(id)
);

ALTER TABLE AvionCategorie ADD CONSTRAINT FKAvionCateg959797 FOREIGN KEY (Avionid) REFERENCES Avion (id);
ALTER TABLE AvionCategorie ADD CONSTRAINT FKAvionCateg512929 FOREIGN KEY (Categorieid) REFERENCES Categorie (id);
ALTER TABLE Vol ADD CONSTRAINT FKVol561819 FOREIGN KEY (Avionid) REFERENCES Avion (id);
ALTER TABLE ReservationClient ADD CONSTRAINT FKReservatio60111 FOREIGN KEY (Clientid) REFERENCES Client (id);
ALTER TABLE ReservationClient ADD CONSTRAINT FKReservatio655976 FOREIGN KEY (Volid) REFERENCES Vol (id);
ALTER TABLE ReservationClient ADD CONSTRAINT FKReservatio213241 FOREIGN KEY (Categorieid) REFERENCES Categorie (id);
ALTER TABLE placeReserve ADD CONSTRAINT FKplaceReser5603 FOREIGN KEY (ReservationClientid) REFERENCES ReservationClient (id);
ALTER TABLE TarifVol ADD CONSTRAINT FKTarifVol570093 FOREIGN KEY (Categorieid) REFERENCES Categorie (id);
ALTER TABLE TarifVol ADD CONSTRAINT FKTarifVol532279 FOREIGN KEY (Volid) REFERENCES Vol (id);
ALTER TABLE PlaceInvalide ADD CONSTRAINT FKPlaceInval378200 FOREIGN KEY (ReservationClientid) REFERENCES ReservationClient (id);
ALTER TABLE PlaceRestriction ADD CONSTRAINT FKPlaceRestr575140 FOREIGN KEY (ReservationClientid) REFERENCES ReservationClient (id);
ALTER TABLE Promotion ADD CONSTRAINT FKPromotion683174 FOREIGN KEY (Volid) REFERENCES Vol (id);


-- Insert

INSERT INTO avion VALUES (default, 'Boeing-314', 5, 10);
INSERT INTO avion VALUES (default, 'Boeing-315', 4, 10);

INSERT INTO categorie VALUES (default, 'Business Class');
INSERT INTO categorie VALUES (default, 'Live Class');
INSERT INTO categorie VALUES (default, 'Premium Class');


INSERT INTO avionCategorie VALUES (1, 1, 1, 30);
INSERT INTO avionCategorie VALUES (1, 2, 31, 40);
INSERT INTO avionCategorie VALUES (1, 3, 41, 50);

INSERT INTO vol VALUES (default, '2023-12-10 13:00', 'VO-01', 'MG-USA', 1);
INSERT INTO vol VALUES (default, '2023-12-10 14:00', 'VO-02', 'MG-FRS', 1);

INSERT INTO client VALUES (nextval('seq_Client'), 'RAZAFY', 'Idealy', '1990-04-04');
INSERT INTO client VALUES (nextval('seq_Client'), 'RAZAFY', 'Sarobidy', '1990-04-04');
INSERT INTO client VALUES (nextval('seq_Client'), 'RANDRIA', 'Holy', '1990-04-04');
INSERT INTO client VALUES (nextval('seq_Client'), 'RAZAFY', 'Tovo', '1990-04-04');

INSERT INTO client VALUES (nextval('seq_Client'), 'Nirina', 'soa', '2019-04-04');
INSERT INTO client VALUES (nextval('seq_Client'), 'Aina', 'be', '2020-04-04');


INSERT INTO reservationclient VALUES (default, 1, 1, 1, 2, default);
INSERT INTO reservationclient VALUES (default, 2, 1, 2, 3, default);
INSERT INTO reservationclient VALUES (default, 3, 1, 3, 2, default);
INSERT INTO reservationclient VALUES (default, 4, 1, 1, 1, default);
INSERT INTO reservationclient VALUES (default, 4, 2, 1, 4, default);
-- insert into reservationClient values (default, 19,1,1,1,default);

INSERT INTO placereserve VALUES (default, 1, 2, 2);

INSERT INTO placeInvalide VALUES (1, 1, 1);

INSERT INTO clientreserver VALUES (1, 5, 1);
INSERT INTO clientreserver VALUES (1, 6, 1);

CREATE OR REPLACE VIEW v_avion_categorieInfo AS (
    SELECT avionId,
        categorieid,
        label,
        placeDebut,
        placeFin
    FROM avion
    JOIN avioncategorie
    ON avion.id = avioncategorie.avionid
    JOIN categorie
    ON categorie.id = avioncategorie.categorieid
);


CREATE OR REPLACE VIEW v_place_reserve_vol AS(
    SELECT volid ,placereserve.range, placereserve.colonne colone
    FROM placereserve
    JOIN reservationclient
    ON placereserve.reservationclientid = reservationclient.id
    JOIN vol
    ON reservationclient.volid = vol.id
    JOIN avion
    ON vol.avionid = avion.id
);

CREATE OR REPLACE VIEW v_place_invalide_vol AS(
    SELECT volid ,placeinvalide.range, placeinvalide.colone
    FROM placeinvalide
    JOIN reservationclient
    ON placeinvalide.reservationclientid = reservationclient.id
    JOIN vol
    ON reservationclient.volid = vol.id
    JOIN avion
    ON vol.avionid = avion.id
);

CREATE OR REPLACE VIEW v_clientReserver AS (
    select 
        clientReserver.clientid id,
        client.nom,
        client.prenom,
        client.datenaissance,
        reservationclient.clientid responsableid,
        clientreserver.classid
    from clientreserver
    join client
    on client.id = clientreserver.clientid
    join reservationclient
    on reservationclient.id = clientreserver.reservationid
);

SELECT * FROM v;

SELECT * FROM vol;
SELECT * FROM client;
SELECT * from placereserve;
SELECT * FROM placeInvalide;

SELECT * FROM v_avion_categorieinfo;

SELECT * FROM reservationClient WHERE 1=1 AND clientid='1' AND volid='2';
    

SELECT * FROM avion;
SELECT * FROM categorie;
-- SELECT * FROM v_detailsavion;
SELECT * FROM avioncategorie;
SELECT * FROM reservationclient;
SELECT * FROM v_nombre_place_by_cat_by_vol;
SELECT * FROM v_details_vol;
SELECT * FROM vol;

SELECT range, colone FROM v_place_reserve_vol WHERE volid = 1;

SELECT * FROM v_details_vol WHERE id=1;

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

CREATE OR REPLACE VIEW v_placeReservation_Client AS (
    SELECT numero, v_detailsavion.avionid, volid, clientid,prix
    FROM reservationclient
    JOIN placereserve
    ON placereserve.reservationclientid = reservationclient.id
    JOIN vol
    ON vol.id = reservationclient.volid
    JOIN v_detailsavion
    ON v_detailsavion.avionid = vol.avionid
    WHERE (placereserve.numero between v_detailsavion.placedebut and v_detailsavion.placefin)
);

SELECT numero, v_detailsavion.avionid, volid, clientid,prix
    FROM reservationclient
    JOIN placereserve
    ON placereserve.reservationclientid = reservationclient.id
    JOIN vol
    ON vol.id = reservationclient.volid
    JOIN v_detailsavion
    ON v_detailsavion.avionid = vol.avionid
    WHERE (placereserve.numero between v_detailsavion.placedebut and v_detailsavion.placefin);

-- Alaina daholo ny liste ny seza par classe de l'avion

SELECT *
FROM v_placereservation_client;

SELECT currval('seq_Client');