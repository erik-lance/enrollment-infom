package enrollment;
import java.sql.*;
import java.util.*;

/**
 * Transaction Code to facilitate Dropping
 * @authors Rafanan, Griffin, Tahimic, Tiongquico
 */

//these codes doesn't include checking of valid values for any fields yet
public class drop {
  
    students                        Student         = new students();
    public ArrayList<enrollment>    EnrollmentList  = new ArrayList<> ();
    public ArrayList<enrollment>    DropList        = new ArrayList<> ();

    // perform all the necessary data loading from DB
    public drop () {
        EnrollmentList.clear();
        DropList.clear();
    }          
    
    // clears dropping data of the student
    public int clearDrop () {   
        DropList.clear();
        return 0;   
    }   
    
    // load enrollment data of the student
    public int loadEnrollment (int nCurrTerm, int nCurrSY) {   
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/enrolldb?user=root&password=12345678&useTimezone=true&serverTimezone=UTC&useSSL=false");
            //the SQL statement below retrieves all the courses a student is enrolled in given a particular term and school year
            PreparedStatement   sqlstatement = conn.prepareStatement("SELECT    e.courseid " +
                                                                     "FROM      enrollment e JOIN students s ON e.studentid = s.studentid " +
                                                                     "WHERE     s.studentid = ? AND e.term = ? AND e.schoolyear = ? " +
                                                                     "ORDER BY  e.courseid");
            sqlstatement.setLong(1, Student.studentid);
            sqlstatement.setInt(2, nCurrTerm);
            sqlstatement.setInt(3, nCurrSY);
            ResultSet rs = sqlstatement.executeQuery();
            EnrollmentList.clear();
            //saves all the retrieved courses in EnrollmentList
            while (rs.next()) {
                enrollment e = new enrollment();
                e.studentid = Student.studentid;
                e.courseid = rs.getString("e.courseid");
                e.term = nCurrTerm;
                e.schoolyear = nCurrSY;
                e.viewRecord(); //only returns 1 since all of the fields of enrollment are PKs
                EnrollmentList.add(e);
            }
            sqlstatement.close();
            conn.close();
            return 1;    
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        } 
    }    
    
    // confirms dropping and saves dropping data into the Database
    // valid courses that could be dropped will be added to DropList (outside of drop.java)
    public int confirmDrop () {   
        enrollment e = new enrollment ();
        for(int i = 0; i < DropList.size(); i++){
            e.studentid = DropList.get(i).studentid;
            e.courseid = DropList.get(i).courseid;
            e.term = DropList.get(i).term;
            e.schoolyear = DropList.get(i).schoolyear;
            e.delRecord();
        }
        return 1;   
    }   
    
}
