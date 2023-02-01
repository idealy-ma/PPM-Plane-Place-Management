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

    @Override
    public void create(Connection c) throws Exception {
        String sql = "INSERT INTO client VALUES (?,?,?)";
        ArrayList<Object> al = new ArrayList<>();
        al.add(this.getId());
        al.add(this.getNom());
        al.add(this.getPrenom());
        
        this.executeQuery(c, sql, al);
    }
    
    public static void main(String[] args) {
        try {
            Client c = new Client();
            ArrayList<Object> listeClient = c.findAll(new BDD("i.m.a", "login", "ppm-plane", "postgresql").getConnection());
            for (Object object : listeClient) {
                Client cl = (Client) object;
                System.out.println(cl.getAge());
            }
        } catch (Exception ex) {
            Logger.getLogger(Client.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
