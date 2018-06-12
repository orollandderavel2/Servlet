/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.solutec;

/**
 *
 * @author stage011
 */
public class EmployesConstantes {
    // Database Base TP (données de la table Identifiants)

            public static final String URL = "jdbc:derby://localhost:1527/BaseTP";
            public static final String USERDB = "jee";
            public static final String MDPDB = "jee";
            
//Database solutec (données de la table Employes)
            public static final String URLS = "jdbc:derby://localhost:1527/solutec";
            public static final String USERDBS = "test";
            public static final String MDPDBS = "test";
            

//Requêtes
            public static final String REQ_MAJ = "UPDATE EMPLOYES SET PRENOM = ?, NOM = ?, EMAIL = ?, ADRESSE = ?, CODEPOSTAL = ?, VILLE = ?, TELPORT = ?, TELDOM = ?, TELPRO = ? WHERE PRENOM = ?";
            public static final String REQ_EMPLOYES = "SELECT * from EMPLOYES";
            public static final String REQ_IDENTIFIANTS = "SELECT * from IDENTIFIANTS";
            public static final String REQ_SUPPRIMER = "DELETE from EMPLOYES WHERE ID = ?";
}
