package enrollment;
import java.sql.*;

public class coursedegree {
    public String courseid; // PK
    public String degree;   // PK

    public coursedegree () {
        courseid = "";
        degree = "";
    };
    public int modRecord()  { 
        return 1; // Since ALL fields are Primary Key
    };
    public int delRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrollmentdb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("DELETE FROM coursedegree WHERE courseid=? AND degree=?");
            sqlstatement.setString(1, courseid);
            sqlstatement.setString(2, degree);
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrollmentdb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("INSERT INTO coursedegree (courseid,degree) VALUES (?,?)");
            sqlstatement.setString(1, courseid);
            sqlstatement.setString(2, degree);
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
        return 1; // Since ALL fields are Primary Key
    };
    
    public static void main(String args[]) {
       
    }
}
