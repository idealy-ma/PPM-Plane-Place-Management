/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import bdd.gestionary.BDD;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Vol;

/**
 *
 * @author i.m.a
 */
public class VolService {
    private ArrayList<Object> volListe;
    private BDD bdd;

    public VolService() throws Exception {
        try {
            this.bdd = new BDD("i.m.a","login","ppm-plane","postgresql");
        } catch (Exception ex) {
            Logger.getLogger(VolService.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        }
    }

    public ArrayList<Object> getVolListe() throws Exception {
        if(volListe == null) {
            try {
                try (Connection c = bdd.getConnection()) {
                    volListe = new Vol().findAll(c);
                }
            } catch (Exception ex) {
                Logger.getLogger(VolService.class.getName()).log(Level.SEVERE, null, ex);
                throw ex;
            }
        }
        return volListe;
    }
}
