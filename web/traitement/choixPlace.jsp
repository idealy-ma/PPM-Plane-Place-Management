<%-- 
    Document   : choixPlace
    Created on : Feb 1, 2023, 11:14:44 AM
    Author     : i.m.a
--%>
<%@page import="model.Avion"%>
<%@page import="bdd.gestionary.BDD"%>
<%@page import="model.Reservation"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Place"%>
<%
    Avion av = new Avion();
    av.setId(Integer.parseInt(request.getParameter("avion")));
    av.find(new BDD("i.m.a" ,"login" ,"ppm-plane" ,"postgresql").getConnection());
    String[] list = request.getParameterValues("name");
    String[] pos = list[0].split("-");
    
    Place p = new Place();
    p.setRange(Integer.parseInt(pos[0]));
    p.setColone(Integer.parseInt(pos[1]));
    p.setIdClasse(Integer.parseInt(pos[1]));
    
    Reservation r = new Reservation();
    r.setClientId(Integer.parseInt(request.getParameter("client")));
    r.setVolId(Integer.parseInt(request.getParameter("vol")));
    
    ArrayList<Object> listeRes = r.findAll(new BDD("i.m.a","login","ppm-plane", "postgresql").getConnection());
    ArrayList<Place> place = new ArrayList<>();
    
    for (Object listeRe : listeRes) {
        Reservation res = (Reservation) listeRe;
        ArrayList<Place> pl = av.getManodidinaClasse(p, res.getCategorieId(), res.getNombreDePlace(), res.getVolId());
        
        for (Place placeItem : pl) {
            place.add(placeItem);
        }
    }
    
    String returnValue = "../choixPlace.jsp?vol-id="+request.getParameter("vol")+"&avion="+request.getParameter("avion")+"&client="+r.getClientId()+"&";
    for (Place plpl : place) {
        returnValue += "pos="+plpl.getRange()+"-"+plpl.getColone()+"&";
    }

    response.sendRedirect(returnValue);
%>
