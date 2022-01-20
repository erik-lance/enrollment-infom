package enrollment;
import java.sql.*;

public class degree {
    public String degreeid; // PK
    public String degreename;
    public degree () {
        degreeid = "";
        degreename = "";
    };
    public int modRecord()  { 
        Connection conn;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrollmentdb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            PreparedStatement   sqlstatement = conn.prepareStatement("UPDATE degree SET degreename=? WHERE degreeid=?");
            sqlstatement.setString(1, degreename);
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
            PreparedStatement   sqlstatement = conn.prepareStatement("DELETE FROM degree WHERE degreeid=?");
            sqlstatement.setString(1, degreeid);
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
            PreparedStatement   sqlstatement = conn.prepareStatement("INSERT INTO degree (degreeid,degreename) VALUES (?,?)");
            sqlstatement.setString(1, degreeid);
            sqlstatement.setString(2, degreename);
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
            PreparedStatement   sqlstatement = conn.prepareStatement("SELECT degreename FROM degree WHERE degreeid=?");
            sqlstatement.setString(1, degreeid);
            ResultSet rs = sqlstatement.executeQuery();
            while (rs.next()) 
            {
                degreename = rs.getString("degreename");
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
