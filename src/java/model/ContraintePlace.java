/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author i.m.a
 */
public final class ContraintePlace {
    private int ageMin;
    private int rang;

    public ContraintePlace() {
    }

    public ContraintePlace(int ageMin, int rang) {
        this.setAgeMin(ageMin);
        this.setRang(rang);
    }

    public int getAgeMin() {
        return ageMin;
    }

    public void setAgeMin(int ageMin) {
        this.ageMin = ageMin;
    }

    public int getRang() {
        return rang;
    }

    public void setRang(int rang) {
        this.rang = rang;
    }
}
