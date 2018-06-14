
<%@page import="java.util.ArrayList"%>
<%@page import="com.solutec.EmployeBean"%>
<html><head>
        <meta content="text/html; charset=ISO-8859-1" http-equiv="content-type"><title></title>

    </head>
    <body>
        
        <%-- <%
           EmployeBean emp = (EmployeBean) request.getAttribute("cleEmp");
            
        %> --%>
          

        <span style="font-weight: bold;"></span><big><big><span style="font-weight: bold;">Détails du membre ${cleEmp.prenom} ${cleEmp.nom} </span><br style="font-weight: bold;">
        </big></big><br>
    <span style="font-weight: bold; color: red;"></span><br>
    <form action="Controleur"> 
        <label for="nom">Nom : </label><input value="${cleEmp.nom}" id="nom" name="nom" onblur="leaveField(this);"> 
        <label for="prenom">Prénom : </label><input value="${cleEmp.prenom}" id="prenom" name="prenom" onblur="leaveField(this); leavePrenom();">
        <br>
        <br>
        <span style="font-weight: bold;">Numéro de téléphone</span><br>
        <label for="teldom">Domicile : </label><input value="${cleEmp.telDom}" name="teldom" id="teldom" onblur="leaveField(this); checkTel(this);"><br>
        <label for="telpor">Portable : </label><input value="${cleEmp.telPort}" name="telpor" id="telpor" onblur="leaveField(this); checkTel(this);"><br>
        <label for="telpro">Professionnel : </label><input value="${cleEmp.telPro}" name="telpro" id="telpro" onblur="leaveField(this); checkTel(this);"><br>
        <br>
        <label for="adresse">Adresse : </label><input value="${cleEmp.adresse}" name="adresse" id="adresse" onblur="leaveField(this);"><br>
        <label for="cp">Code postal : </label><input value="${cleEmp.codePostal}" name="cp" id="cp" onblur="leaveField(this); checkCP();">
        <label for="ville">Ville : </label><input value="${cleEmp.ville}" name="ville" id="ville" onblur="leaveField(this);"><br>
        <label for="mail">E-mail : </label><input id="mail" name="mail" value="${cleEmp.email}" onblur="leaveField(this); checkMail();"><br>
       
        <br>
        
        <input type="submit" name="bouton" value="Voir liste"/><br>
        <input type='submit' name='bouton'value='Modifier'/>

    </form>
</body></html>