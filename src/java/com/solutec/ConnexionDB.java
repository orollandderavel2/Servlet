/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.solutec;


import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author stage011
 */
public class ConnexionDB {

    private Connection conn;
    private Statement stmt;
    private ResultSet rs;
    private PreparedStatement pstmt;

    
    public Statement getStatementBaseTP() {

        try {
            conn = DriverManager.getConnection(EmployesConstantes.URL, EmployesConstantes.USERDB, EmployesConstantes.MDPDB);
            stmt = conn.createStatement();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return stmt;
    }
    
    public Statement getStatementSolutec() {

        try {
            conn = DriverManager.getConnection(EmployesConstantes.URLS, EmployesConstantes.USERDBS, EmployesConstantes.MDPDBS);
            stmt = conn.createStatement();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return stmt;
    }

    public PreparedStatement getPreparedStatementSolutec(String req) {
        
        try {
        conn = DriverManager.getConnection(EmployesConstantes.URL, EmployesConstantes.USERDB, EmployesConstantes.MDPDB);
        pstmt = conn.prepareStatement(req);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return pstmt;
    }
        
    }

