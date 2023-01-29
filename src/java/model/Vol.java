/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import annotation.PrimaryKey;
import bdd.object.BddObject;
import java.sql.Timestamp;

/**
 *
 * @author i.m.a
 */
public class Vol extends BddObject{
    @PrimaryKey
    private int id;
    private Timestamp dateDeVol;
    private String nomDuVol;
    private String pays;
    private int avionId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Timestamp getDateDeVol() {
        return dateDeVol;
    }

    public void setDateDeVol(Timestamp dateDeVol) {
        this.dateDeVol = dateDeVol;
    }

    public String getNomDuVol() {
        return nomDuVol;
    }

    public void setNomDuVol(String nomDuVol) {
        this.nomDuVol = nomDuVol;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public int getAvionId() {
        return avionId;
    }

    public void setAvionId(int avionId) {
        this.avionId = avionId;
    }
}
