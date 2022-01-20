package enrollment;
import java.sql.*;
import java.util.*;

/**
 * Report Generation Code for Report
 * @author Rafanan, Griffin, Tahimic, Tiongquico
 */
public class report {
    
    public Integer term;
    public int schoolyear;
    public ArrayList<courses>  CourseReportList      = new ArrayList<> ();
    public ArrayList<Integer>  CountReportList       = new ArrayList<> ();
    
    public report (){
        term = 0;
        schoolyear = 0;
    }
    
    public int resetreport () {
        CourseReportList.clear();
        CountReportList.clear();
        return 1;
    }
    
    public int generatereport () {
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            //the SQL statement below retrieves the number of students that enrolled in every course for the term and school year
            PreparedStatement   sqlstatement = conn.prepareStatement("SELECT    c.courseid, COUNT(e.courseid) AS num_enrolled " +
                                                                     "FROM      courses c JOIN enrollment e ON c.courseid = e.courseid " +
                                                                     "WHERE     e.term = ? AND e.schoolyear = ? " +
                                                                     "GROUP BY  c.courseid " +
                                                                     "ORDER BY  c.courseid ");  

            sqlstatement.setInt(1, term);
            sqlstatement.setInt(2, schoolyear);
            ResultSet rs = sqlstatement.executeQuery();
            CourseReportList.clear();
            CountReportList.clear();
            courses c = new courses ();
            while (rs.next()) {
                c.courseid = rs.getString("c.courseid");
                c.viewRecord();
                CourseReportList.add(c);
                CountReportList.add(rs.getInt("num_enrolled"));
            }
            sqlstatement.close();
            conn.close();
            return 1;    
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
}
