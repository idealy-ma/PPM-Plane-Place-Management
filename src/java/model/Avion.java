/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import bdd.gestionary.BDD;
import bdd.object.BddObject;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author i.m.a
 */
public class Avion extends BddObject{
    private int id;
    private String nom;
    private int range;
    private int colone;
    private ArrayList<InfoAvion> infoAvion;
    private Place[] place;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getRange() {
        return range;
    }

    public void setRange(int range) {
        this.range = range;
    }

    private ArrayList<InfoAvion> getInfoAvion(Connection c) {
        if(this.infoAvion == null){
            try {
                infoAvion = new ArrayList<>();
                ArrayList<Object> liste = new InfoAvion().findAll(c);
                for (Object object : liste) {
                    infoAvion.add((InfoAvion) object);
                }
            } catch (Exception ex) {
                Logger.getLogger(Avion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return infoAvion;
    }

    public int getColone() {
        return colone;
    }

    public void setColone(int colone) {
        this.colone = colone;
    }
    
    public void makePlace() {
        this.place = new Place[this.getColone()*this.getRange()];
        for (int p = 0, y = 1, x = 1; p < place.length; p++) {
            place[p] = new Place();
            place[p].setRange(y);
            place[p].setColone(x);
            if(x == this.getColone()){
                y++;
                x=1;
            } else {
                x++;
            }
        }
        
        System.out.println(place.length);
    }
    
    private void initClassPlace(ArrayList<InfoAvion> infoAvions){
        for (InfoAvion infoAvion1 : infoAvions) {
            for (int i = 0; i < place.length; i++) {
                if(infoAvion1.getPlaceDebut()<= i+1 && infoAvion1.getPlaceFin() >= i+1){
                    place[i].setIdClasse(infoAvion1.getCategorieId());
                    place[i].setClasse(infoAvion1.getLabel());
                }
            }
        }
    }
    
    private void reservedPlace(ArrayList<Object> listeObject, int idVol){
        for (Place place1 : this.getPlace(idVol)) {
            for (Object object : listeObject) {
                Place place = (Place) object;
                if(place1.getColone() == place.getColone() && place1.getRange() == place.getRange()){
                    place1.setReserved(true);
                }
            }
        }
    }
    
    private void invalidPlace(ArrayList<Object> listeObject, int idVol){
        for (Place place1 : this.getPlace(idVol)) {
            for (Object object : listeObject) {
                Place place = (Place) object;
                if(place1.getColone() == place.getColone() && place1.getRange() == place.getRange()){
                    place1.setInvalide(true);
                }
            }
        }
    }

    public Place[] getPlace(int idVol) {
        if(this.place == null){
            try {
                Connection c = new BDD("i.m.a","login", "ppm-plane", "postgresql").getConnection();
                makePlace();
                initClassPlace(getInfoAvion(c));
                reservedPlace(new Place().listePlaceNonLibre(c, idVol), idVol);
                invalidPlace(new Place().placeInvalide(c, idVol), idVol);
                c.close();
            } catch (Exception ex) {
                Logger.getLogger(Avion.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return place;
    }
    
    public void setPlace(Place[] place) {
        this.place = place;
    }
    
    public ArrayList<Place> getManodidina(Place c, int nbPlace, int idVol){
        Place[] place = this.getPlace(idVol);
        ArrayList<Place> listePlace = new ArrayList<>();
        ArrayList<DistancePlace> distPlace = distancePlaces(c, place);
        
        for (int i = 0; i < nbPlace; i++) {
            listePlace.add(distPlace.get(i).getPlace());
        }
        
        return listePlace;
    }
    
    public ArrayList<Place> getPlaceOk(Place place, ContraintePlace contraintePlace ,Client responsable, ArrayList<Client> responser, int idVol) throws Exception{
        ArrayList<Place> listePlace = new ArrayList<>();        
        // Controle si l'age est trop bas
        if(place.getRange() == contraintePlace.getRang() && responsable.getAge()< contraintePlace.getAgeMin()){
            throw new Exception("Age trop bas");
        }
        
        place.setChecked(true);
        listePlace.add(place);
        // Information
        Place[] places = this.getPlace(idVol);
        ArrayList<DistancePlace> distPlace = distancePlaces(place, places);
        // Traitement selection des places des responser plus pres
        for (Client client : responser) {
            for (DistancePlace place1 : distPlace) {
                if(place1.getPlace().getRange() == contraintePlace.getRang() && client.getAge() < contraintePlace.getAgeMin()) continue;
                if(place1.getPlace().getIdClasse() == client.getClassId()
                        && !(place1.getPlace().getColone() == place.getColone() && place1.getPlace().getRange() == place.getRange())
                        && !place1.getPlace().isChecked()) {
                    place1.getPlace().setChecked(true);
                    place1.getPlace().setC(client);
                    place1.getPlace().setPrixTotal(place1.getPlace().getPrixTotal()+client.getMyPrix());
                    System.out.println(place1.getPlace().getC().getMyPrix());
                    listePlace.add(place1.getPlace());
                    break;
                }
            }
        }
        
        return listePlace;
    }
    
    public ArrayList<Place> getManodidinaClasse(Place c, int idClass, int nbPlace, int idVol){
        Place[] place = this.getPlace(idVol);
        ArrayList<Place> listePlace = new ArrayList<>();
        ArrayList<DistancePlace> distPlace = distancePlaces(c, place);
        
        for (int i = 0; i < distPlace.size(); i++) {
            if(distPlace.get(i).getPlace().getIdClasse() == idClass){
                listePlace.add(distPlace.get(i).getPlace());
                nbPlace--;
            }
            
            if(nbPlace == 0){
                break;
            }
        }
        
        return listePlace;
    }
    
    public ArrayList<DistancePlace> distancePlaces(Place p, Place[] place){
        ArrayList<DistancePlace> distPlace = new ArrayList<>();
        for (Place place1 : place) {
            if(place1.isInvalide() || place1.isReserved()){
                continue;
            }
            DistancePlace distancePlace = new DistancePlace();
            distancePlace.setDistance(p.distancePlace(place1));
            distancePlace.setPlace(place1);
            distPlace.add(distancePlace);
        }
        Collections.sort(distPlace);
        return distPlace;
    }
    
    public void checkPlace(int idVol,int range, int colone){
        Place[] place = this.getPlace(idVol);
        for (Place place1 : place) {
            if(place1.getRange()==range && place1.getColone() == colone){
                place1.setChecked(true);
            }
        }
    }
}