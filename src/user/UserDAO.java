package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;	// 자바와 DB 연결
//	private PreparedStatement pstmt;	// 퀴리문 대기 및 설정(설정및 실행)
	private ResultSet rs;	// 결과값 받아오기
	public UserDAO() {
		try {
			String dbURL="jdbc:mariadb://localhost:3306/bbs";			// mariaDB의 주소
			String dbID="root";											// mariaDB ID
			String dbPassword="mariaDB0108";							// mariaDB password
			Class.forName("org.mariadb.jdbc.Driver");					// JDBC연결 클래스를 'String'타입으로 불러 옴
			conn=DriverManager.getConnection(dbURL, dbID, dbPassword);	// DriverManager에 미리저장한 연결URL, DB계정정보를 담아 연결
		} catch (Exception e) {
			e.printStackTrace();
		}	// 학원에선 finally사용 후 conn, pstmt, rs 모두 close();해줌
	}
	
	// 로그인 영역 ================================================================================================================
	public int login(String userID, String userPassword) {
			String sql="SELECT userPassword FROM USER WHERE userID = ?";
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);	// sql쿼리문을 대기 시킴
				pstmt.setString(1, userID);		// 첫번째 '?'에 'userID' 대입
				rs=pstmt.executeQuery();	// select에 관한 결과를 받아 옴
				if (rs.next()) {		// 결과 존재시
					if (rs.getString(1).equals(userPassword))	// rs의 값이 userPassword랑 같으면
						return 1;	// 로그인 성공
					else
						return 0;	// 로그인 실패(비밀번호 불일치)
				}
				return -1;	// 아이디 없음
			} catch (Exception e) {
				// TODO: handle exception
			}
		return -2;	// 오류
	}
	// 회원가입 영역 ================================================================================================================
	public int join(User user) {
		String sql="INSERT INTO USER VALUES(?,?,?,?,?)";
		try {
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
	// 회원가입 영역 ================================================================================================================
		public String getUserEmail(String userID) {
			String sql="SELECT USEREMAIL FROM USER WHERE USERID=?";
			try {
				PreparedStatement pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, userID);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					return rs.getString(1);	// 이메일 주소 반환
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return null;	// 데이터베이스 오류
		}
		
		// 회원가입 영역 ================================================================================================================
				public String getUserEmailChecked(String userID) {
					String sql="select userEmailChecked from user where userID=?";
					try {
						PreparedStatement pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, userID);
						rs=pstmt.executeQuery();
						while(rs.next()) {
							return rs.getString(1);	// 이메일 주소 반환
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					
					return null;	// 데이터베이스 오류
				}
	

	
}
