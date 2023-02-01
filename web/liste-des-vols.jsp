<%-- 
    Document   : liste-des-vols
    Created on : Jan 29, 2023, 4:10:25 PM
    Author     : i.m.a
--%>
<%@page import="model.Vol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.VolService"%>
<%
    VolService vs = new VolService();
    ArrayList<Object> listeVol = vs.getVolListe();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Liste des vols</title>
    </head>
    <body>
        <h1>Liste des vols</h1>
        <table>
            <tr>
                <th>Nom</th>
                <th>Date et Heure</th>
                <th>Pays</th>
            </tr>
            <% for (Object object : listeVol) { 
                Vol vol = (Vol) object;
            %>
                <tr>
                    <td><%= vol.getNomDuVol() %></td>
                    <td><%= vol.getDateDeVol() %></td>
                    <td><%= vol.getPays() %></td>
                    <td><a href="reservation.jsp?id-vol=<%= vol.getId()%>&avion=<%= vol.getAvionId() %>">Details du vols</a></td>
                </tr>     
            <% } %>
        </table>
    </body>
</html>
