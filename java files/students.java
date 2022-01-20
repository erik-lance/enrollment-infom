package enrollment;
import java.sql.*;

public class students {
    public long     studentid; //PK
    public String   completename;
    public String   degreeid;
    public students () {
        studentid = 0;
        completename = "";
        degreeid = "";
    };
    public int modRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrollmentdb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("UPDATE students SET completename=?, degreeid=? department=? WHERE studentid=?");
            sqlstatement.setLong(3, studentid);
            sqlstatement.setString(1, completename);
            sqlstatement.setString(2, degreeid);
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrollmentdb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("DELETE FROM students WHERE studentid=?");
            sqlstatement.setLong(1, studentid);
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
            PreparedStatement   sqlstatement = conn.prepareStatement("INSERT INTO students (studentid,completename,degreeid) VALUES (?,?,?)");
            sqlstatement.setLong(1, studentid);
            sqlstatement.setString(2, completename);
            sqlstatement.setString(3, degreeid);
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
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrollmentdb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("SELECT completename, degreeid FROM students WHERE studentid=?");
            sqlstatement.setLong(1, studentid);
            ResultSet rs = sqlstatement.executeQuery();
            while (rs.next()) 
            {
                completename = rs.getString("completename");
                degreeid = rs.getString("degreeid");

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
