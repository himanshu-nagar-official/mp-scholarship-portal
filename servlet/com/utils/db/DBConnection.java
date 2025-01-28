package com.utils.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection 
{

    // Database credentials
    private static final String url = "jdbc:mysql://localhost:3306/mp_scholarship_portal?useSSL=false&serverTimezone=UTC";
    private static final String uid = "root"; // MySQL username
    private static final String pass = "Password*123"; // MySQL password

    // Method to return the connection
    public static Connection getConnection() 
    {
        try 
        {
            // Load and register MySQL driver class
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            return DriverManager.getConnection(url, uid, pass);
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
            System.out.println("Connection to the database failed: " + e.getMessage());
        }
        catch (ClassNotFoundException e) 
        {
            e.printStackTrace();
            System.out.println("JDBC Driver not found: " + e.getMessage());
        }
        return null;
    }
}