/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import annotation.DBTable;
import bdd.object.BddObject;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author i.m.a
 */
@DBTable(tableName = "v_details_vol")
public class InfoVol extends Vol {
    private String label;
    private int placeDispo;
    private String nom;

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getPlaceDispo() {
        return placeDispo;
    }

    public void setPlaceDispo(int placeDispo) {
        this.placeDispo = placeDispo;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public ArrayList<InfoVol> findInfo(Connection c) throws Exception {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String sql = "SELECT * FROM v_details_vol WHERE id=?";
        try {
            preparedStatement = c.prepareStatement(sql);
            preparedStatement.setInt(1, this.getId());
            resultSet = preparedStatement.executeQuery();
            
            ArrayList<InfoVol> listeObject = new ArrayList<>();
            
            while(resultSet.next()){
                InfoVol o = new InfoVol();
                o.setId(resultSet.getInt("id"));
                o.setDateDeVol(resultSet.getTimestamp("datedevol"));
                o.setNomDuVol(resultSet.getString("nomduvol"));
                o.setPays(resultSet.getString("pays"));
                o.setAvionId(resultSet.getInt("id"));
                o.setNom(resultSet.getString("nom"));
                o.setLabel(resultSet.getString("label"));
                o.setPlaceDispo(resultSet.getInt("placedispo"));

                listeObject.add(o);
            }
            return listeObject;
        } catch (SQLException ex) {
            Logger.getLogger(BddObject.class.getName()).log(Level.SEVERE, null, ex);
            throw ex;
        } finally {
            if(resultSet != null) resultSet.close();
            if(preparedStatement!=null) preparedStatement.close(); 
        }
    }
}
