<%-- 
    Document   : ajoutInformatio
    Created on : Feb 1, 2023, 2:43:10 PM
    Author     : i.m.a
--%>
<%@page import="bdd.gestionary.BDD"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Reservation"%>
<%
    Reservation r = new Reservation();
    r.setClientId(Integer.parseInt(request.getParameter("client")));
    r.setVolId(Integer.parseInt(request.getParameter("vol-id")));
    ArrayList<Object> object = r.findAll(new BDD("i.m.a","login","ppm-plane","postgresql").getConnection());
    
    ArrayList<Reservation> reservations = new ArrayList<>();
    
    for (Object object1 : object) {
        Reservation res = (Reservation) object1;
        res.findMe(new BDD("i.m.a","login","ppm-plane","postgresql").getConnection());
        reservations.add(res );
    }
    
//    reservations.get(0).setNombreDePlace(reservations.get(0).getNombreDePlace());
    int i = 0;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Remplir SVP :)</h1>
        <form action="traitement/insertionInformation.jsp?vol=<%= request.getParameter("vol-id") %>&client=<%= request.getParameter("client") %>&avion=<%= request.getParameter("avion") %>" method="post">
            <% for (Reservation reservation : reservations) { %>
                <div>
                    <% if (i!=reservation.getCategorieId()) { i = reservation.getCategorieId(); %>
                        <h3><%= reservation.getCategorie() %></h3>
                    <% } %>
                    <% for (int j = 0; j < reservation.getNombreDePlace(); j++) { %>
                        <div>
                            <input type="hidden" name="class-<%= i %>-class" value="<%= reservation.getCategorieId() %>">
                            <input type="hidden" name="class-<%= i %>-reservation" value="<%= reservation.getId() %>">
                            <label>Nom : </label>
                            <input type="nom" name="class-<%= i %>-nom">
                            <label>Prenom : </label>
                            <input type="nom" name="class-<%= i %>-prenom">
                            <label>Naissance : </label>
                            <input type="date" name="class-<%= i %>-naissance">
                        </div> 
                    <% } %>
                </div>
            <% } %>
            <input type="hidden" name="class" value="<%= i %>">
            <input type="submit" name="Valider">
        </form>
    </body>
</html>
