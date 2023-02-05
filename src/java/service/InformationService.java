/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import bdd.gestionary.BDD;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Client;
import model.ClientReserve;
import model.Sequence;

/**
 *
 * @author i.m.a
 */
public class InformationService {
    private String[] nom;
    private String[] prenom;
    private String[] naissance;
    private String[] reservation;
    private String[] classe;

    public InformationService(String[] nom, String[] prenom, String[] naissance, String[] classe, String[] reservation) {
        this.nom = nom;
        this.prenom = prenom;
        this.naissance = naissance;
        this.reservation = reservation;
        this.classe = classe;
    }

    public InformationService(String[] nom, String[] prenom, String[] naissance) {
        this.nom = nom;
        this.prenom = prenom;
        this.naissance = naissance;
    }

    public String[] getNom() {
        return nom;
    }

    public void setNom(String[] nom) {
        this.nom = nom;
    }

    public String[] getPrenom() {
        return prenom;
    }

    public void setPrenom(String[] prenom) {
        this.prenom = prenom;
    }

    public String[] getNaissance() {
        return naissance;
    }

    public void setNaissance(String[] naissance) {
        this.naissance = naissance;
    }
    
    public void insert() throws SQLException{
        Connection c = null;
        try {
            c = new BDD("i.m.a","login","ppm-plane","postgresql").getConnection();
            c.setAutoCommit(false);
            for (int i = 1; i < naissance.length; i++) {
                int nextVal = new Sequence("seq_Client").nextVal(c);
                Client client = new Client();
                client.setId(nextVal);
                client.setNom(nom[i]);
                client.setPrenom(prenom[i]);
                client.setDateNaissance(Date.valueOf(naissance[i]));
                
                System.out.println(client.getDateNaissance());
                        
                ClientReserve clientReserve = new ClientReserve();
                clientReserve.setClientId(client.getId());
                clientReserve.setClassId(Integer.parseInt(classe[i]));
                clientReserve.setReservationId(Integer.parseInt(reservation[i]));
                System.out.println(clientReserve);
                client.create(c);
                clientReserve.create(c);
            }
            
            c.commit();
        } catch (Exception ex) {
            Logger.getLogger(InformationService.class.getName()).log(Level.SEVERE, null, ex);
            if(c!=null) c.rollback();
        } finally {
            if(c!=null) c.close();
        }
    }
    
}
