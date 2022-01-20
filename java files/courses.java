package enrollment;
import java.sql.*;

public class courses {
    public String courseid; // PK
    public String coursename;
    public String department;
    public courses () {
        courseid = "";
        coursename = "";
        department = "";
    };
    public int modRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("UPDATE courses SET coursename=?, department=? WHERE courseid=?");
            sqlstatement.setString(3, courseid);
            sqlstatement.setString(1, coursename);
            sqlstatement.setString(2, department);
            sqlstatement.executeUpdate();
            sqlstatement.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    };
    public int delRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("DELETE FROM courses WHERE courseid=?");
            sqlstatement.setString(1, courseid);
            sqlstatement.executeUpdate();
            sqlstatement.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    };
    public int addRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("INSERT INTO courses (courseid,coursename,department) VALUES (?,?,?)");
            sqlstatement.setString(1, courseid);
            sqlstatement.setString(2, coursename);
            sqlstatement.setString(3, department);
            sqlstatement.executeUpdate();
            sqlstatement.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        } 
    };
    public int viewRecord() { 
        
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("SELECT coursename, department FROM courses WHERE courseid=?");
            sqlstatement.setString(1, courseid);
            ResultSet rs = sqlstatement.executeQuery();
            while (rs.next()) 
            {
                coursename = rs.getString("coursename");
                department = rs.getString("department");
            }
            sqlstatement.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    };
    
    public static void main(String args[]) {
        
    }
}
