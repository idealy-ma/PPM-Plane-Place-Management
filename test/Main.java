
import bdd.gestionary.BDD;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Avion;
import model.Client;
import model.ContraintePlace;
import model.Place;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author i.m.a
 */
public class Main {
     public static void main(String[] args) {
        try {
            Connection c = new BDD("i.m.a" ,"login" ,"ppm-plane" ,"postgresql").getConnection();
            Avion av = new Avion();
            av.setId(1);
            av.find(c);
            
            Place pc = new Place();
            pc.setColone(6);
            pc.setRange(1);
            
            ContraintePlace contraintePlace = new ContraintePlace(10, 1);
            Client responsable = new Client();
            responsable.setId(1);
            responsable.find(c);
            
            ArrayList<Client> client = responsable.getListeReserver(c);
            System.out.println(client.size());
            
            ArrayList<Place> p = av.getPlaceOk(pc, contraintePlace, responsable, client,1);
            
//            for (Place place : p) {
//                System.out.println(place.getRange());
//                System.out.println(place.getColone());
//                System.out.println(place.getPrixTotal());
//                System.out.println("-----------------------------");
//            }
//            
            Place[] placeAvion = av.getPlace(1);
            ArrayList<Double> in = new ArrayList<>();
            
            int rang = 0;
            double somme = 0;
            for (Place place : placeAvion) {
                if(rang != place.getRange()){
                    rang = place.getRange();
                    in.add(somme);
                }
//                System.out.println(place.getRange());
//                System.out.println(place.getColone());
                somme += place.getPrixTotal();
//                System.out.println();
//                System.out.println("-----------------------------");
            }
            
            for (Double double1 : in) {
                System.out.println(double1);
                System.out.println("-----------------------------");
            }
        } catch (Exception ex) {
            Logger.getLogger(Avion.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
