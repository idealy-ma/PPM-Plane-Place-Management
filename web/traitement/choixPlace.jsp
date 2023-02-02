<%-- 
    Document   : choixPlace
    Created on : Feb 1, 2023, 11:14:44 AM
    Author     : i.m.a
--%>
<%@page import="model.ContraintePlace"%>
<%@page import="model.Client"%>
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
    
    ContraintePlace contraintePlace = new ContraintePlace(10, 1);
    
    Client responsable = new Client();
    responsable.setId(Integer.parseInt(request.getParameter("client")));
    responsable.find(new BDD("i.m.a" ,"login" ,"ppm-plane" ,"postgresql").getConnection());
    
    ArrayList<Client> client = responsable.getListeReserver(new BDD("i.m.a" ,"login" ,"ppm-plane" ,"postgresql").getConnection());
    ArrayList<Place> place = new ArrayList<>();
    
    ArrayList<Place> pl = av.getPlaceOk(p, contraintePlace, responsable, client,Integer.parseInt(request.getParameter("vol")));

    for (Place placeItem : pl) {
        place.add(placeItem);
    }
    
    String returnValue = "../choixPlace.jsp?vol-id="+request.getParameter("vol")+"&avion="+request.getParameter("avion")+"&client="+responsable.getId()+"&";
    for (Place plpl : place) {
        returnValue += "pos="+plpl.getRange()+"-"+plpl.getColone()+"&";
    }

    response.sendRedirect(returnValue);
%>
