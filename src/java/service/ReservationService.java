/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import bdd.gestionary.BDD;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Reservation;

/**
 *
 * @author i.m.a
 */
public class ReservationService {
    private String[] categorie;
    private String[] nbPlace;
    private String idVol;
    private BDD bdd;
    private int clientId;

    public ReservationService() throws Exception {
        try {
            this.bdd = new BDD("i.m.a","login","ppm-plane","postgresql");
        } catch (Exception ex) {
            Logger.getLogger(VolService.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }
    
    

    public String getIdVol() {
        return idVol;
    }

    public void setIdVol(String idVol) {
        this.idVol = idVol;
    }

    public String[] getCategorie() {
        return categorie;
    }

    public void setCategorie(String[] categorie) {
        this.categorie = categorie;
    }

    public String[] getNbPlace() {
        return nbPlace;
    }

    public void setNbPlace(String[] nbPlace) {
        this.nbPlace = nbPlace;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }
    
    public void insertReservation() throws SQLException{
        Connection c = null;
        try {
            c = bdd.getConnection();
            c.setAutoCommit(false);
            
            for (int i = 0; i < categorie.length; i++) {
                Reservation r = new Reservation();
                r.setClientId(this.getClientId());
                r.setCategorieId(Integer.parseInt(categorie[i]));
                r.setNombreDePlace(Integer.parseInt(nbPlace[i]));
                r.setVolId(Integer.parseInt(this.getIdVol()));
                
                r.create(c);
            }
            
            c.commit();
        } catch (Exception ex) {
            Logger.getLogger(ReservationService.class.getName()).log(Level.SEVERE, null, ex);
            if(c!=null)c.rollback();
        } finally {
            if(c!=null) c.close();
        }
    }
}
