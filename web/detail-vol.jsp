<%-- 
    Document   : detail-vol
    Created on : Jan 29, 2023, 4:13:35 PM
    Author     : i.m.a
--%>
<%@page import="model.InfoVol"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.VolService"%>
<%
    VolService vs = new VolService();
    ArrayList<InfoVol> listeVol = vs.getListeInfoVol(Integer.parseInt(request.getParameter("id")));
    InfoVol v = null;
    if(!listeVol.isEmpty()){
        v = listeVol.get(0);
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail vol</title>
    </head>
    <body>
        <h1>Information du vol</h1>
        <% if(v!=null) { %>
            <p><a href="reservation.jsp?id-vol=<%= v.getId() %>">Reservation</a></p>
            <p><b>Nom : </b> <%= v.getNomDuVol()%></p>
            <p><b>Date : </b> <%= v.getDateDeVol()%></p>
            <p><b>Pays : </b> <%= v.getPays()%></p>
            <p><b>Avion : </b> <%= v.getNom() %> <a href="voir-avion.jsp?id=<%= v.getAvionId()%>">Voir</a></p>
        <% } %>
        <p><b>Etats de l'avion</b></p>
        <div>
            <table>
                <thead>
                    <tr>
                        <% for (Object object : listeVol) { 
                            InfoVol iV = (InfoVol) object;
                        %>
                            <th><%= iV.getLabel() %></th>
                        <%    } %>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <% for (InfoVol object : listeVol) {
                        %>
                            <td><%= object.getPlaceDispo() %> places (libres)</td>
                        <%    } %>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>
