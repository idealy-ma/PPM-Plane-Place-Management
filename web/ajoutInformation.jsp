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
    ArrayList<Object> object = r.findAll(new BDD("i.m.a","login","ppm-plane", "postgresql").getConnection());
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
        <form action="#">
            <div>
                <h3>Businness Class</h3>
                <div>
                    <label>Nom : </label>
                    <input type="nom" name="bussnessNom">
                    <label>Prenom : </label>
                    <input type="nom" name="bussnessNom">
                    <label>Naissance : </label>
                    <input type="date" name="businessDate">
                </div>
            </div>
            <div>
                <h3>Premium Class</h3>
                <div>
                    <label>Nom : </label>
                    <input type="nom" name="bussnessNom">
                    <label>Prenom : </label>
                    <input type="nom" name="bussnessNom">
                    <label>Naissance : </label>
                    <input type="date" name="businessDate">
                </div>
            </div>
            <div>
                <h3>Top Class</h3>
                <div>
                    <label>Nom : </label>
                    <input type="nom" name="bussnessNom">
                    <label>Prenom : </label>
                    <input type="nom" name="bussnessNom">
                    <label>Naissance : </label>
                    <input type="date" name="businessDate">
                </div>
            </div>
            <input type="submit" name="Valider">
        </form>
    </body>
</html>
