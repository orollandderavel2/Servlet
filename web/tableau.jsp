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
                <%
     //               ATTENTION CHANGER tableau dans le while par bienvenue pour revenir vers bienvenue !
                    ArrayList<EmployeBean> listeE = (ArrayList<EmployeBean>) session.getAttribute("cleList");
               for (int i = 0; i < listeE.size(); i++) {%>
                <tr> 

                    <td>  <INPUT TYPE="radio" NAME='idClient' VALUE="<% out.print(listeE.get(i).getID()); %>" CHECKED ></td>
                    <td>  <% out.println(listeE.get(i).getPrenom()); %></td>
                    <td>  <% out.println(listeE.get(i).getNom()); %>    </td>
                    <td>  <% out.println(listeE.get(i).getEmail()); %>    </td>
                    <td>  <% out.println(listeE.get(i).getAdresse()); %>  </td>
                    <td>  <% out.println(listeE.get(i).getCodePostal()); %>    </td>
                    <td>  <% out.println(listeE.get(i).getVille()); %>  </td>
                    <td>  <% out.println(listeE.get(i).getTelPort()); %> </td>
                    <td>  <% out.println(listeE.get(i).getTelDom()); %>    </td>
                    <td>  <% out.println(listeE.get(i).getTelPro()); %>    </td>
                </tr>    
                <%}%>

            </table>
            <input type='submit' name="bouton" value="Detail"/>
            <input type='submit' name="bouton" value="Supprimer"/>
            
            <!--<input type='submit' name="bouton" value="quitter"/>-->

        </form>


    </body>
</html>