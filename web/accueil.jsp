<%-- 
    Document   : login
    Created on : 30 mai 2018, 14:19:42
    Author     : stage011
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <form action="Controleur" method="POST">
            <label> Login <input type="text" name="chLogin" /> </label>
            
            <label> Mot de passe <input type="text" name="chMdp" /> </label>
            
            <input type="submit" name="btnOK" value="OK" />
        </form>
       
<span style="color:red"/>
<%--
        <%
            Integer i=(Integer) request.getAttribute("cleErr");
            if (i != null)
            {
            if (i.equals(1)){
                out.println("Veuillez renseignez les 2 cases");
            }
            else if (i.equals(2)){
                out.println("veuillez remplir cases");   
            }
            }
            %>
            --%>
            
            
                
            </c:if>
                
    </body>
</html>