<%@page import="java.util.ArrayList"%>
<%@page import="com.solutec.EmployeBean"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="Controleur">

            <table border = 1>
                <tr>
                    <td><b>Detail</b><</td>
                    <td><b>Nom</b></td>
                    <td><b>Prenom</b></td>
                    <td><b>Teldom</b></td>
                    <td><b>Telport</b></td>
                    <td><b>Telpro</b></td>
                    <td><b>Adresse</b></td>
                    <td><b>Code Postal</b></td>
                    <td><b>Ville</b></td>
                    <td><b>Email</b></td>
                </tr>
                <%--
                    ATTENTION CHANGER tableau dans le while par bienvenue pour revenir vers bienvenue !
                    ArrayList<EmployeBean> listeE = (ArrayList<EmployeBean>) session.getAttribute("cleList");
               for (int i = 0; i < listeE.size(); i++) { --%>
                <c:forEach items="${cleList}" var="user">
                    
               
                <tr> 

                    <td>  <INPUT TYPE="radio" NAME='idClient' VALUE="${user.ID}" CHECKED ></td>
                    <td>  <c:out value="${user.prenom}" /> </td>
                    <td>  <c:out value="${user.nom}" />   </td>
                    <td>  <c:out value="${user.email}"  />  </td>
                    <td>  <c:out value="${user.adresse}" /> </td>
                    <td>  <c:out value="${user.codePostal}"/>    </td>
                    <td>  <c:out value="${user.ville}"/>  </td>
                    <td>  <c:out value="${user.telPort}"/> </td>
                    <td>  <c:out value="${user.telDom}"/>    </td>
                    <td>  <c:out value="${user.telPro}"/>    </td>
                </tr>   
                </c:forEach>
                <%-- <%}%> --%>

</table>
            <input type='submit' name="bouton" value="Detail"/>
            <input type='submit' name="bouton" value="Supprimer"/>
            
            <!--<input type='submit' name="bouton" value="quitter"/>-->

        </form>


    </body>
</html>