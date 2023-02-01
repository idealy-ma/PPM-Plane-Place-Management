/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import bdd.object.BddObject;
import java.sql.Connection;
import java.util.ArrayList;

/**
 *
 * @author i.m.a
 */
public class Place extends BddObject{
    private int range;
    private int colone;
    private int idClasse;
    private String classe;
    private boolean reserved;
    private boolean invalide;
    private boolean checked;

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }

    public boolean isInvalide() {
        return invalide;
    }

    public void setInvalide(boolean invalide) {
        this.invalide = invalide;
    }

    public boolean isReserved() {
        return reserved;
    }

    public void setReserved(boolean reserved) {
        this.reserved = reserved;
    }

    public int getRange() {
        return range;
    }

    public void setRange(int range) {
        this.range = range;
    }

    public int getColone() {
        return colone;
    }

    public void setColone(int colone) {
        this.colone = colone;
    }

    public int getIdClasse() {
        return idClasse;
    }

    public void setIdClasse(int idClasse) {
        this.idClasse = idClasse;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }
    
    public double distancePlace(Place p){
        return Math.sqrt(Math.pow((p.getColone()-this.getColone()), 2)+Math.pow((p.getRange()-this.getRange()), 2));
    }
    
    public ArrayList<Object> listePlaceNonLibre(Connection c, int idVol) throws Exception{
        String sql = "SELECT range, colone FROM v_place_reserve_vol WHERE volid = ?";
        ArrayList<Object> objects = new ArrayList<>();
        objects.add(idVol);
        
//        v_place_invalide_vol
        
        return this.executeResultedQuery(c, sql, objects);
    }
    
    public ArrayList<Object> placeInvalide(Connection c, int idVol) throws Exception{
        String sql = "SELECT range, colone FROM v_place_invalide_vol WHERE volid = ?";
        ArrayList<Object> objects = new ArrayList<>();
        objects.add(idVol);
        
        return this.executeResultedQuery(c, sql, objects);
    }
}
