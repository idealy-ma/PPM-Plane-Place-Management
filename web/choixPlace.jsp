<%-- 
    Document   : choixPlace
    Created on : Feb 1, 2023, 12:20:49 AM
    Author     : i.m.a
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="bdd.gestionary.BDD"%>
<%@page import="model.Place"%>
<%@page import="model.Avion"%>
<%
    Avion av = new Avion();
    av.setId(Integer.parseInt(request.getParameter("avion")));
    av.find(new BDD("i.m.a","login","ppm-plane","postgresql").getConnection());
    Place[] placeAvion = av.getPlace(Integer.parseInt(request.getParameter("vol-id")));
    int classId = placeAvion[0].getIdClasse();
    String[] pos = request.getParameterValues("pos");
    if(pos != null){
        for (String po : pos) {
            String[] split = po.split("-");
            av.checkPlace(Integer.parseInt(request.getParameter("vol-id")), Integer.parseInt(split[0]), Integer.parseInt(split[1]));
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="traitement/choixPlace.jsp?client=<%= request.getParameter("client") %>&vol=<%= request.getParameter("vol-id") %>&avion=<%= request.getParameter("avion") %>" method="post">
            <% for (Place place : placeAvion) { %>
                <% if(classId != place.getIdClasse()){ classId = place.getIdClasse(); %>
                    <hr/>
                <% } %>
                <% if(place.isReserved()) { %>
                    <input type="checkbox" id="id" name="name" title="reserved" disabled="true" >
                <% } else if(place.isInvalide()) {%>
                    <input type="checkbox" id="id" name="name" title="invalide" disabled="true">
                <% } else if(place.isChecked()) {%>
                    <input type="checkbox" id="id" name="name" checked="true" value="<%= place.getRange() %>-<%= place.getColone() %>-<%= place.getIdClasse()%>">
                    <%--<%= place.getC().getAge() %>--%>
                <% } else {%>
                    <input type="checkbox" id="id" name="name"  value="<%= place.getRange() %>-<%= place.getColone() %>-<%= place.getIdClasse()%>">
                <% } %>
                <% if (place.getColone() == av.getColone()) { %>
                    <br/>
                <% } %>
            <%    } %>
            <input type="submit" value="valider">
        </form>
    </body>
</html>
