package enrollment;
import java.sql.*;

public class enrollment {
    public long     studentid;  // PK
    public String   courseid;   // PK
    public int      term;       // PK
    public int      schoolyear; // PK
    public enrollment () {
        studentid = 0;
        courseid = "";
        term = 0;
        schoolyear = 0;
    };
    public int modRecord()  { 
        return 1; // Since ALL fields are Primary Key
    };
    public int delRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("DELETE FROM enrollment WHERE studentid=? AND courseid=? AND term=? AND schoolyear=?");
            sqlstatement.setLong(1, studentid);
            sqlstatement.setString(2, courseid);
            sqlstatement.setInt(3, term);
            sqlstatement.setInt(4, schoolyear);
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
            PreparedStatement   sqlstatement = conn.prepareStatement("INSERT INTO enrollment (studentid,courseid,term,schoolyear) VALUES (?,?,?,?)");
            sqlstatement.setLong(1, studentid);
            sqlstatement.setString(2, courseid);
            sqlstatement.setInt(3, term);
            sqlstatement.setInt(4, schoolyear);
            sqlstatement.executeUpdate();
            sqlstatement.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        } };
    public int viewRecord() { 
        return 1; // Since ALL fields are Primary Key
    };
    
    public static void main(String args[]) {
       
    }
}
