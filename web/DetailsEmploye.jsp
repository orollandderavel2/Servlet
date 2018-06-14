
<%@page import="java.util.ArrayList"%>
<%@page import="com.solutec.EmployeBean"%>
<html><head>
        <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type"><title></title>

    </head>
    <body>
        
        <%
           EmployeBean emp = (EmployeBean) request.getAttribute("cleEmp");
            
        %>
          

        <span style="font-weight: bold;"></span><big><big><span style="font-weight: bold;">Détails du membre <% out.println(emp.getPrenom()); %><% out.println(emp.getNom()); %></span><br style="font-weight: bold;">
        </big></big><br>
    <span style="font-weight: bold; color: red;"></span><br>
    <form action="Controleur"> 
        <label for="nom">Nom : </label><input value="<% out.println(emp.getNom()); %>" id="nom" name="nom" onblur="leaveField(this);"> 
        <label for="prenom">Prénom : </label><input value="<% out.println(emp.getPrenom()); %>" id="prenom" name="prenom" onblur="leaveField(this); leavePrenom();">
        <br>
        <br>
        <span style="font-weight: bold;">Numéro de téléphone</span><br>
        <label for="teldom">Domicile : </label><input value="<% out.println(emp.getTelDom()); %>" name="teldom" id="teldom" onblur="leaveField(this); checkTel(this);"><br>
        <label for="telpor">Portable : </label><input value="<% out.println(emp.getTelPort()); %>" name="telpor" id="telpor" onblur="leaveField(this); checkTel(this);"><br>
        <label for="telpro">Professionnel : </label><input value="<% out.println(emp.getTelPro()); %>" name="telpro" id="telpro" onblur="leaveField(this); checkTel(this);"><br>
        <br>
        <label for="adresse">Adresse : </label><input value="<% out.println(emp.getAdresse()); %>" name="adresse" id="adresse" onblur="leaveField(this);"><br>
        <label for="cp">Code postal : </label><input value="<% out.println(emp.getCodePostal()); %>" name="cp" id="cp" onblur="leaveField(this); checkCP();">
        <label for="ville">Ville : </label><input value="<% out.println(emp.getVille()); %>" name="ville" id="ville" onblur="leaveField(this);"><br>
        <label for="mail">E-mail : </label><input id="mail" name="mail" value="<% out.println(emp.getEmail()); %>" onblur="leaveField(this); checkMail();"><br>
       
        <br>
        
        <input type="submit" name="bouton" value="Voir liste"/><br>
        <input type='submit' name='bouton'value='Modifier'/>

    </form>
</body></html>