package com.tecleon;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CarreraDAO {

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tecleon", "root", "mypass");
        } catch (Exception e) {
            System.out.println("Failed to connect" + e);
        }
        return con;
    }

    public static int saveCarrera(Carrera car) {
        int status = 0;
        try {
            Connection con = CarreraDAO.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "insert into carrera(idCarrera, nombreCarrera) values (?,?)");
            ps.setString(1, car.getIdCarrera());
            ps.setString(2, car.getNombreCarrera());

            status = ps.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return status;
    }

    public static int update(Carrera car) {
        int status = 0;
        try {
            Connection con = CarreraDAO.getConnection();
            PreparedStatement ps = con.prepareStatement(
                    "update carrera set nombreCarrera=? where idCarrera=?");
            ps.setString(1, car.getNombreCarrera());
            ps.setString(2, car.getIdCarrera());
            status = ps.executeUpdate();

            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return status;
    }

    public static int delete(String idCarrera) {
        int status = 0;
        try {
            Connection con = CarreraDAO.getConnection();
            PreparedStatement ps = con.prepareStatement("delete from carrera where idCarrera=?");
            ps.setString(1, idCarrera);
            status = ps.executeUpdate();

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public static Carrera getCarrerbyId(int id) {
        Carrera car = new Carrera();

        try {
            Connection con = CarreraDAO.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from carrera where idCarrera=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                car.setIdCarrera(rs.getString("idCarrera"));
                car.setNombreCarrera(rs.getString("nombreCarrera"));
            }
            con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return car;
    }

    public static List<Carrera> getAllCarrers() {
        List<Carrera> list = new ArrayList<>();

        try {
            Connection con = CarreraDAO.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from carrera");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Carrera car = new Carrera();
                car.setIdCarrera(rs.getString("idCarrera"));
                car.setNombreCarrera(rs.getString("nombreCarrera"));
               

                list.add(car);
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public ResultSet query(String sql) {
        ResultSet resultado;
        try {
            Statement sentencia = getConnection().createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
            resultado = sentencia.executeQuery(sql);
        } catch (SQLException e) {
            System.out.println("The query couldn´t be done");
            e.printStackTrace();
            return null;
        }
        return resultado;
    }
}
