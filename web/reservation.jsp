<%-- 
    Document   : reservation
    Created on : Jan 29, 2023, 4:17:59 PM
    Author     : i.m.a
--%>
<%@page import="model.Client"%>
<%@page import="bdd.gestionary.BDD"%>
<%@page import="model.InfoAvion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.VolService"%>
<%
    InfoAvion vs = new InfoAvion();
    vs.setAvionId(Integer.parseInt(request.getParameter("avion")));
    ArrayList<Object> iV = vs.findAll(new BDD("i.m.a","login","ppm-plane","postgresql").getConnection());
    ArrayList<Object> client = new Client().findAll(new BDD("i.m.a","login","ppm-plane","postgresql").getConnection());
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation</title>
    </head>
    <body>
        <h1>Reservation</h1>
        <hr/>
        <div>
            <form action="choixPlace.jsp?vol-id=<%= request.getParameter("id-vol") %>&avion=<%=request.getParameter("avion") %>" method="post">
                <h3>Voir directement</h3>
                <select name="client">
                    <% for(Object o : client) { Client cl = (Client) o;%>
                        <option value="<%= cl.getId() %>"><%= cl.getPrenom() %></option>
                    <% } %>
                </select>
                <div>
                    <input type="submit" value="Valider">
                </div>
            </form>
            <form action="traitement/insertReservation.jsp?vol-id=<%= request.getParameter("id-vol") %>&avion=<%=request.getParameter("avion") %>" method="post">
                <h3>Info du client</h3>
                <select name="client">
                    <% for(Object o : client) { Client cl = (Client) o;%>
                        <option value="<%= cl.getId() %>"><%= cl.getPrenom() %></option>
                    <% } %>
                </select>

                <h3>Classe et nombre de place</h3>
                <% for (Object object : iV) { InfoAvion i = (InfoAvion) object; %>
                <div>
                    <label>
                        <input type="checkbox" name="class" value="<%= i.getCategorieId() %>">
                        <%= i.getLabel()%>
                    </label>
                    <input type="text" name="classy" placeholder="1">
                </div>
                <%    } %>
                <div>
                    <input type="submit" value="Valider">
                </div>
            </form>
        </div>
    </body>
</html>
