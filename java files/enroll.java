package enrollment;
import java.sql.*;
import java.util.*;

/**
 * Transaction Code to facilitate Enrollment
 * @author Rafanan, Griffin, Tahimic, Tiongquico
 */

public class enroll {

    students                        Student         = new students();
    public ArrayList<enrollment>    EnrollmentList  = new ArrayList<> ();
    public ArrayList<coursedegree>  CourseList      = new ArrayList<> ();
 
    // perform all the necessary data loading from DB
    public enroll() {
        EnrollmentList.clear();
        CourseList.clear();
    }
    
    // clears enrollment data of the student 
    public int clearEnrollment () {   
        EnrollmentList.clear();
        return 0;   
    }   
    
    // load valid courses into CourseList
    public int loadCourses () {   
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            //the SQL statement below retrieves all degree programs not yet taken by a student
            PreparedStatement   sqlstatement = conn.prepareStatement("SELECT    courseid " +
                                                                     "FROM      coursedegree " +
                                                                     "WHERE     courseid NOT IN (SELECT e.courseid " +
                                                                                                  "FROM enrollment e JOIN  students s       ON e.studentid = s.studentid " +
                                                                                                                    "JOIN coursedegree cd   ON s.degreeid = cd.degree " +
                                                                                                  "WHERE  s.studentid = ? " + 
                                                                                                  "AND s.degreeid = cd.degree) " +
                                                                      "AND      degree = ?" +
                                                                      "ORDER BY courseid");
            sqlstatement.setLong(1, Student.studentid);
            sqlstatement.setString(2, Student.degreeid);
            ResultSet rs = sqlstatement.executeQuery();
            CourseList.clear();
            coursedegree c = new coursedegree();
            while (rs.next()) {
                c.courseid = rs.getString("courseid");
                c.degree = Student.degreeid;
                c.viewRecord(); //only returns 1 since all of the fields of enrollment are PKs
                CourseList.add(c);
            }
            sqlstatement.close();
            conn.close();
            return 1;    
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }   
    
    
    // saves enrollment data into the Database
    public int confirmEnrollment() { 
        enrollment e = new enrollment ();
        for(int i = 0; i < EnrollmentList.size(); i++){
            e.studentid = EnrollmentList.get(i).studentid;
            e.courseid = EnrollmentList.get(i).courseid;
            e.term = EnrollmentList.get(i).term;
            e.schoolyear = EnrollmentList.get(i).schoolyear;
            e.addRecord();
        }        
        return 1;
    }      
}
