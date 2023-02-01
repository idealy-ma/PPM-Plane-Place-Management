<%-- 
    Document   : insertReservation
    Created on : Jan 30, 2023, 6:39:15 AM
    Author     : i.m.a
--%>
<%@page import="service.ReservationService"%>
<%
    ReservationService reservationService = new ReservationService();
    reservationService.setCategorie(request.getParameterValues("class"));
    reservationService.setNbPlace(request.getParameterValues("classy"));
    reservationService.setIdVol(request.getParameter("vol-id"));
    reservationService.setClientId(Integer.parseInt(request.getParameter("client")));
    
    reservationService.insertReservation();
    
    response.sendRedirect("../choixPlace.jsp?vol-id="+request.getParameter("vol-id")+"&avion="+request.getParameter("avion")+"&client="+request.getParameter("client"));
%>
