<%-- 
    Document   : insertionInformation
    Created on : Feb 2, 2023, 7:47:30 AM
    Author     : i.m.a
--%>

<%@page import="service.InformationService"%>
<%@page import="model.Client"%>
<%
    for (int i = 1; i <= Integer.parseInt(request.getParameter("class")); i++) {
        String[] nom = request.getParameterValues("class-"+i+"-nom");
        String[] prenom = request.getParameterValues("class-"+i+"-prenom");
        String[] naissance = request.getParameterValues("class-"+i+"-naissance");
        String[] classe = request.getParameterValues("class-"+i+"-class");
        String[] reservation = request.getParameterValues("class-"+i+"-reservation");

        
        InformationService inf = new InformationService(nom, prenom, naissance, classe, reservation);
        inf.insert();
        
        response.sendRedirect("../choixPlace.jsp?client="+request.getParameter("client")+"&vol-id="+request.getParameter("vol")+"&avion="+request.getParameter("avion"));
    }
%>
