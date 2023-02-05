/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import annotation.DBTable;
import bdd.object.BddObject;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author i.m.a
 */
@DBTable(tableName = "v_client_reservation_categorie_label")
public class Reservation extends BddObject{
    private int id;
    private int clientId;
    private int volId;
    private int categorieId;
    private String categorie;
    private int nombreDePlace;
    private Timestamp dateDeReservation;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public int getVolId() {
        return volId;
    }

    public void setVolId(int volId) {
        this.volId = volId;
    }

    public int getCategorieId() {
        return categorieId;
    }

    public void setCategorieId(int categorieId) {
        this.categorieId = categorieId;
    }

    public String getCategorie() {
        return categorie;
    }

    public void setCategorie(String categorie) {
        this.categorie = categorie;
    }

    public int getNombreDePlace() {
        return nombreDePlace;
    }

    public void setNombreDePlace(int nombreDePlace) {
        this.nombreDePlace = nombreDePlace;
    }

    public Timestamp getDateDeReservation() {
        return dateDeReservation;
    }

    public void setDateDeReservation(Timestamp dateDeReservation) {
        this.dateDeReservation = dateDeReservation;
    }

    @Override
    public void create(Connection c) throws Exception {
        String sql = "insert into reservationClient values (default, ?,?,?,?, default)";
        ArrayList<Object> obj = new ArrayList<>();
        obj.add(this.getClientId());
        obj.add(this.getVolId());
        obj.add(this.getCategorieId());
        obj.add(this.getNombreDePlace());
        
        this.executeQuery(c, sql, obj);
    }

    
    public void findMe(Connection c) throws Exception {
        String sql = "SELECT * FROM reservationClient WHERE 1=1 AND clientid=? AND volid=?";
        ArrayList<Object> o = new ArrayList<>();
        o.add(this.getClientId());
        o.add(this.getVolId());
        ArrayList<Object> objects = this.executeResultedQuery(c, sql, o);
        Reservation res = (Reservation) objects.get(0);
        
        this.setId(res.getId());
    }
    
    
    
    
}
