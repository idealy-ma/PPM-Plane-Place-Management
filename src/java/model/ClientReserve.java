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
@DBTable(tableName = "clientReserver")
public class ClientReserve extends BddObject {
    private int reservationId;
    private int clientId;
    private int classId;

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    @Override
    public String toString() {
        return this.classId + " - cl : " + this.clientId + " - " + this.reservationId; 
    }
    
    
}
