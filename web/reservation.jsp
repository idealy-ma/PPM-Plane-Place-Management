<%-- 
    Document   : reservation
    Created on : Jan 29, 2023, 4:17:59 PM
    Author     : i.m.a
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation</title>
    </head>
    <body>
        <h1>Reservation du vol VO-01</h1>
        <hr/>
        <div>
            <form action="action">
                <h3>Info du client</h3>
                <div>
                    <label> Nom :
                        <input type="text" name="nom">
                    </label>
                </div>
                <div>
                    <label> Prenom :
                        <input type="text" name="prenom">
                    </label>
                </div>
                <h3>Classe et nombre de place</h3>
                <div>
                    <label>
                        <input type="checkbox" name="class" value="1">
                        Class 1
                    </label>
                </div>
                <div>
                    <label>
                        <input type="checkbox" name="class" value="2">
                        Class 2
                    </label>
                </div>
                <div>
                    <input type="submit" value="Valider">
                </div>
            </form>
        </div>
    </body>
</html>
