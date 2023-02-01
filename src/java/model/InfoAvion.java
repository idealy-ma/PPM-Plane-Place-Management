/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import annotation.DBTable;
import bdd.object.BddObject;

/**
 *
 * @author i.m.a
 */
@DBTable(tableName = "v_avion_categorieInfo")
public class InfoAvion extends BddObject{
    private int avionId;
    private int categorieId;
    private String label;
    private int placeDebut;
    private int placeFin;

    public int getAvionId() {
        return avionId;
    }

    public void setAvionId(int avionId) {
        this.avionId = avionId;
    }

    public int getCategorieId() {
        return categorieId;
    }

    public void setCategorieId(int categorieId) {
        this.categorieId = categorieId;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getPlaceDebut() {
        return placeDebut;
    }

    public void setPlaceDebut(int placeDebut) {
        this.placeDebut = placeDebut;
    }

    public int getPlaceFin() {
        return placeFin;
    }

    public void setPlaceFin(int placeFin) {
        this.placeFin = placeFin;
    }
}
