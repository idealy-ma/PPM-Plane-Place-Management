/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import bdd.gestionary.BDD;
import bdd.object.BddObject;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author i.m.a
 */
public class Client extends BddObject{
    private int id;
    private String nom;
    private String prenom;
    private Date dateNaissance;
    
    private int responsableId;
    private int classId;

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

    public String getPrenom() {
        return prenom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public Date getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(Date dateNaissance) {
        this.dateNaissance = dateNaissance;
    }
    
    public int getAge(){
        return LocalDate.now().getYear()-dateNaissance.toLocalDate().getYear();
    }

    public int getResponsableId() {
        return responsableId;
    }

    public void setResponsableId(int responsableId) {
        this.responsableId = responsableId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    @Override
    public void create(Connection c) throws Exception {
        String sql = "INSERT INTO client VALUES (?,?,?,?)";
        ArrayList<Object> al = new ArrayList<>();
        al.add(this.getId());
        al.add(this.getNom());
        al.add(this.getPrenom());
        al.add(this.getDateNaissance());
        
        this.executeQuery(c, sql, al);
    }
    
    public ArrayList<Client> getListeReserver(Connection c) throws Exception{
        String sql = "SELECT * FROM v_clientReserver WHERE responsableId=?";
        ArrayList<Object> listeObjet = new ArrayList<>();
        ArrayList<Client> clients = new ArrayList<>();
        listeObjet.add(this.getId());
        
        listeObjet = executeResultedQuery(c, sql, listeObjet);
        
        for (Object object : listeObjet) {
            clients.add((Client)object);
        }
        
        return clients;
    }

    @Override
    public String toString() {
        return this.getNom() + " - " + this.getPrenom() + " - " + this.getDateNaissance();
    }
    
    public double getMyPrix() throws Exception{
        double prix = 0;
        
//        for (Object object : list) 
            PrixReservation p = new PrixReservation();
            p.setIdCategorie(this.getClassId());
            p.find(new BDD("i.m.a", "login", "ppm-plane", "postgresql").getConnection());
            
            System.out.println(p.getPrixUnitaire());
            
            if(this.getClassId() == p.getIdCategorie()){
                if(this.getAge() >= 18){
                    if(p.getAge() == 1){
                        prix = p.getPrixUnitaire();
                    } 
                } else {
                    prix = p.getPrixUnitaire();
                }
            }
        
        return prix;
    }
    
    
    public static void main(String[] args) {
        try {
            Client c = new Client();
            ArrayList<Object> listeClient = c.findAll(new BDD("i.m.a", "login", "ppm-plane", "postgresql").getConnection());
            for (Object object : listeClient) {
                Client cl = (Client) object;
                System.out.println(cl.getId()+" : "+cl.getAge());
            }
        } catch (Exception ex) {
            Logger.getLogger(Client.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
