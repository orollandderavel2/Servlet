/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.solutec;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author stage011
 */
public class Controleur extends HttpServlet {

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

    public Connection initConnexionTP() {
        try {
            conn = DriverManager.getConnection(URL, USERDB, MDPDB);
        } catch (SQLException sqle) {
            System.out.println(sqle.getMessage());
        }
        return conn;

    }

    public Connection initConnexionSolutec() {
        try {
            conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
        } catch (SQLException sqle) {
            System.out.println(sqle.getMessage());
        }
        return conn;

    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
// Connexion à la base
        try {
            conn = this.initConnexionTP();
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
                //conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                try {
                    conn = this.initConnexionSolutec();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);

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
                request.getRequestDispatcher("index.jsp").forward(request, response);
            } else {
                i = 2;
                request.setAttribute("cleErr", i);
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        }
        String btn = request.getParameter("bouton");

        if (btn != null) {

            if (btn.equals("Supprimer")) {
                String reqSup = "DELETE from EMPLOYES WHERE ID = ?";
                String ID = request.getParameter("idClient");
                try {
                    //conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                    conn = this.initConnexionSolutec();
                    PreparedStatement pstmt;
                    pstmt = conn.prepareStatement(reqSup);
                    pstmt.setString(1, ID);
                    pstmt.executeUpdate();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
                //conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                try {
                   // conn = this.initConnexionSolutec();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);
                                              listeEmployes.clear();

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
                //conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                try {
                    conn = this.initConnexionSolutec();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);
                                              listeEmployes.clear();

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

                //conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                try {
                    conn = this.initConnexionSolutec();
                    PreparedStatement pstmt = conn.prepareStatement(reqMaj);
                    String IDPrenom = request.getParameter("prenom");

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
                   pstmt.executeUpdate();
     

                } catch (SQLException e) {
                    System.out.println(e.getMessage());

                }
                //conn = DriverManager.getConnection(URLs, USERDBs, MDPDBs);
                try {
                    conn = this.initConnexionSolutec();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(requete1);
                    listeEmployes.clear();

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

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
