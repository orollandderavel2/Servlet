<%-- 
    Document   : controleur
    Created on : 31 mai 2018, 09:47:53
    Author     : stage011
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.solutec.EmployeBean"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.solutec.Utilisateur"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


        <%
// Database Identifiants
            Connection conn;
            Statement stmt;
            ResultSet rs;
            String URL = "jdbc:derby://localhost:1527/BaseTP";
            String USERDB = "jee";
            String MDPDB = "jee";
            String requete = "SELECT * from IDENTIFIANTS";
//Database solutec
            String URLs = "jdbc:derby://localhost:1527/solutec";
            String USERDBs = "test";
            String MDPDBs = "test";
            String requete1 = "SELECT * from EMPLOYES";

            String reqMaj = "UPDATE EMPLOYES SET PRENOM = ?, NOM = ?, EMAIL = ?, ADRESSE = ?, CODEPOSTAL = ?, VILLE = ?, TELPORT = ?, TELDOM = ?, TELPRO = ? WHERE PRENOM = ?";

            ArrayList<Utilisateur> listeID = new ArrayList<Utilisateur>();
            ArrayList<EmployeBean> listeEmployes = new ArrayList<EmployeBean>();

            Utilisateur user = new Utilisateur();
// Connexion à la base
            try {
                conn = DriverManager.getConnection(URL, USERDB, MDPDB);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(requete);

                while (rs.next()) {
                    user = new Utilisateur();
                    user.setLogin(rs.getString("LOGIN"));
                    user.setMdp(rs.getString("MDP"));
                    listeID.add(user);
                }
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }

            //Récupération des données saisies
            String loginSaisi = request.getParameter("chLogin");
            String mdpSaisi = request.getParameter("chMdp");

            int i = 0;
            if (loginSaisi != null && mdpSaisi != null) {
                if (loginSaisi.equals(user.getLogin()) && mdpSaisi.equals(user.getMdp())) {
                    conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);

                    try {
                        while (rs.next()) {
                            EmployeBean employe = new EmployeBean();
                            employe.setID(rs.getInt("ID"));
                            employe.setAdresse(rs.getString("ADRESSE"));
                            employe.setCodePostal(rs.getString("CODEPOSTAL"));
                            employe.setEmail(rs.getString("EMAIL"));
                            employe.setNom(rs.getString("NOM"));
                            employe.setPrenom(rs.getString("PRENOM"));
                            employe.setTelDom(rs.getString("TELDOM"));
                            employe.setTelPort(rs.getString("TELPORT"));
                            employe.setTelPro(rs.getString("TELPRO"));
                            employe.setVille(rs.getString("VILLE"));

                            listeEmployes.add(employe);
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                    }

                    session.setAttribute("cleList", listeEmployes);
                    request.getRequestDispatcher("tableau.jsp").forward(request, response);

                } else if (loginSaisi.equals("") || mdpSaisi.equals("")) {
                    i = 1;
                    request.setAttribute("cleErr", i);
                    request.getRequestDispatcher("accueil.jsp").forward(request, response);
                } else {
                    i = 2;
                    request.setAttribute("cleErr", i);
                    request.getRequestDispatcher("accueil.jsp").forward(request, response);
                }

            }
            String btn = request.getParameter("bouton");

            if (btn != null) {
                if (btn.equals("Supprimer")) {
                    String reqSup = "DELETE from EMPLOYES WHERE ID = ?";
                    String ID = request.getParameter("idClient");
                    try {
                        conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                        PreparedStatement pstmt;
                        pstmt = conn.prepareStatement(reqSup);
                        pstmt.setString(1, ID);
                        pstmt.executeUpdate();
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                    }
                    conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);

                    try {
                        while (rs.next()) {
                            EmployeBean employe = new EmployeBean();
                            employe.setID(rs.getInt("ID"));
                            employe.setAdresse(rs.getString("ADRESSE"));
                            employe.setCodePostal(rs.getString("CODEPOSTAL"));
                            employe.setEmail(rs.getString("EMAIL"));
                            employe.setNom(rs.getString("NOM"));
                            employe.setPrenom(rs.getString("PRENOM"));
                            employe.setTelDom(rs.getString("TELDOM"));
                            employe.setTelPort(rs.getString("TELPORT"));
                            employe.setTelPro(rs.getString("TELPRO"));
                            employe.setVille(rs.getString("VILLE"));

                            listeEmployes.add(employe);
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                    }
                    session.setAttribute("cleList", listeEmployes);
                    request.getRequestDispatcher("tableau.jsp").forward(request, response);

                } else if (btn.equals("Detail")) {

                    ArrayList<EmployeBean> listeE = (ArrayList<EmployeBean>) session.getAttribute("cleList");
                    String idClientTableau = request.getParameter("idClient");
                    Integer a = Integer.valueOf(idClientTableau);
                    EmployeBean employeB = new EmployeBean();

                    for (EmployeBean e : listeE) {

                        if (e.getID().equals(a)) {
                            employeB = e;
                            break;
                        }

                    }
                    request.setAttribute("cleEmp", employeB);
                    request.getRequestDispatcher("DetailsEmploye.jsp").forward(request, response);

                } else if (btn.equals("Voir liste")) {
                    conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);

                    try {
                        while (rs.next()) {
                            EmployeBean employe = new EmployeBean();
                            employe.setID(rs.getInt("ID"));
                            employe.setAdresse(rs.getString("ADRESSE"));
                            employe.setCodePostal(rs.getString("CODEPOSTAL"));
                            employe.setEmail(rs.getString("EMAIL"));
                            employe.setNom(rs.getString("NOM"));
                            employe.setPrenom(rs.getString("PRENOM"));
                            employe.setTelDom(rs.getString("TELDOM"));
                            employe.setTelPort(rs.getString("TELPORT"));
                            employe.setTelPro(rs.getString("TELPRO"));
                            employe.setVille(rs.getString("VILLE"));

                            listeEmployes.add(employe);
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                    }
                    session.setAttribute("cleList", listeEmployes);
                    request.getRequestDispatcher("tableau.jsp").forward(request, response);
                } else if (btn.equals("Modifier")) {

                    conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                    PreparedStatement pstmt = conn.prepareStatement(reqMaj);
                    String IDPrenom = request.getParameter("prenom");

                    try {

                        pstmt.setString(1, request.getParameter("prenom"));
                        pstmt.setString(2, request.getParameter("nom"));
                        pstmt.setString(3, request.getParameter("mail"));
                        pstmt.setString(4, request.getParameter("adresse"));
                        pstmt.setString(5, request.getParameter("cp"));
                        pstmt.setString(6, request.getParameter("ville"));
                        pstmt.setString(7, request.getParameter("telpor"));
                        pstmt.setString(8, request.getParameter("teldom"));
                        pstmt.setString(9, request.getParameter("telpro"));
                        
                        pstmt.setString(10, IDPrenom);
                        int u = pstmt.executeUpdate();
                        System.out.println(u);

                    } catch (SQLException e) {
                        System.out.println(e.getMessage());

                    }
                    conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);

                    try {
                        while (rs.next()) {
                            EmployeBean employe = new EmployeBean();
                            employe.setID(rs.getInt("ID"));
                            employe.setAdresse(rs.getString("ADRESSE"));
                            employe.setCodePostal(rs.getString("CODEPOSTAL"));
                            employe.setEmail(rs.getString("EMAIL"));
                            employe.setNom(rs.getString("NOM"));
                            employe.setPrenom(rs.getString("PRENOM"));
                            employe.setTelDom(rs.getString("TELDOM"));
                            employe.setTelPort(rs.getString("TELPORT"));
                            employe.setTelPro(rs.getString("TELPRO"));
                            employe.setVille(rs.getString("VILLE"));

                            listeEmployes.add(employe);
                        }
                    } catch (SQLException e) {
                        System.out.println(e.getMessage());
                    }
                    session.setAttribute("cleList", listeEmployes);
                    request.getRequestDispatcher("tableau.jsp").forward(request, response);
                }
            }


        %>

    </body>
</html>
