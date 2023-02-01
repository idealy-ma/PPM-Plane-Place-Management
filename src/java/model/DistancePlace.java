/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author i.m.a
 */
public class DistancePlace implements Comparable<DistancePlace>{
    private Place place;
    private double distance;

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    @Override
    public int compareTo(DistancePlace arg0) {
        if(arg0.getDistance() == this.getDistance()){
            return 0;
        } else if (this.getDistance() > arg0.getDistance()){
            return 1;
        } else {
            return -1;
        }
    }
}
