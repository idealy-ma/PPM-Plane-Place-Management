<%-- 
    Document   : detail-vol
    Created on : Jan 29, 2023, 4:13:35 PM
    Author     : i.m.a
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail vol</title>
    </head>
    <body>
        <h1>Information du vol</h1>
        <p><a href="reservation.jsp?id-vol=1">Reservation</a></p>
        <p><b>Nom : </b> VO-01</p>
        <p><b>Date : </b> VO-01</p>
        <p><b>Pays : </b> VO-01</p>
        <p><b>Avion : </b> Boeing-314 <a href="voir-avion.jsp?id=1">Voir</a></p>

        <p><b>Etats de l'avion</b></p>
        <div>
            <table border="1">
                <thead>
                    <tr>
                        <th>Class 1</th>
                        <th>Class 2</th>
                        <th>Class 3</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>5 places (libres)</td>
                        <td>2 places (libres)</td>
                        <td>2 places (libres)</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>
