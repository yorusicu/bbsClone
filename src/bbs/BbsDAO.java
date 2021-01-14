package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn; // 자바와 DB 연결
	private ResultSet rs; // 결과값 받아오기

	public BbsDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/bbs"; // mariaDB의 주소
			String dbID = "root"; // mariaDB ID
			String dbPassword = "mariaDB0108"; // mariaDB password
			Class.forName("org.mariadb.jdbc.Driver"); // JDBC연결 클래스를 'String'타입으로 불러 옴
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); // DriverManager에 미리저장한 연결URL, DB계정정보를 담아 연결
		} catch (Exception e) {
			e.printStackTrace();
		} // 학원에선 finally사용 후 conn, pstmt, rs 모두 close();해줌
	}

	// 현재시간 가져오는 메서드
	// =======================================================================================
	public String getDate() {
		System.out.println("In_getDate");
		String sql = "SELECT NOW()"; // 현재의 시간을 가져오는 sql문
		try {
			// bbs는 DB접근이 많아 충돌날 수 있기 때문에 각 함수에 넣어 줌_퀴리문 대기 및 설정(설정및 실행)
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getString(1); // 현재 날짜 반환
		} catch (Exception e) {
			e.printStackTrace();
		}

		return ""; // 데이터베이스 오류
	}

	// 글번호 부여 메서드
	// =======================================================================================
	public int getNext() {
		System.out.println("In_getNext");
		String sql = "SELECT BBSID FROM BBS ORDER BY BBSID DESC"; // 가장 마지막에 쓰인 bbsID를 가져오는 sql문
		try {
			// bbs는 DB접근이 많아 충돌날 수 있기 때문에 각 함수에 넣어 줌_퀴리문 대기 및 설정(설정및 실행)
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
				return rs.getInt(1) + 1; // 나온결과에 +1을 해줌

			return 1; // 첫 게시물인 경우 1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // 데이터베이스 오류
	}

	// 글 작성 메서드
	// =======================================================================================
	public int write(String bbsTitle, String userID, String bbsContent) {
		System.out.println("In_wirte");
		String sql = "insert into bbs values(?,?,?,?,?,?)"; // 가장 마지막에 쓰인 bbsID를 가져오는 sql문
		try {
			// bbs는 DB접근이 많아 충돌날 수 있기 때문에 각 함수에 넣어 줌_퀴리문 대기 및 설정(설정및 실행)
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext()); // 글번호
			pstmt.setString(2, bbsTitle); // 글제목
			pstmt.setString(3, userID); // 작성자
			pstmt.setString(4, getDate()); // 날짜
			pstmt.setString(5, bbsContent); // 글내용
			pstmt.setInt(6, 1); // 글 삭제 유무 여부 유 = 1, 무 = 0

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1; // 데이터베이스 오류
	}

	// 게시글 리스트 메서드
	// =======================================================================================
	public ArrayList<Bbs> getList(int pageNumber) {
		String sql = "SELECT * FROM BBS WHERE BBSID < ? AND BBSAVAILABLE=1 ORDER BY BBSID DESC LIMIT 10"; // 가장 마지막에 쓰인
																											// bbsID를
																											// 가져오는 sql문
		ArrayList<Bbs> list = new ArrayList<>();
		try {
			// bbs는 DB접근이 많아 충돌날 수 있기 때문에 각 함수에 넣어 줌_퀴리문 대기 및 설정(설정및 실행)
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));

				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list; // 데이터베이스 오류
	}

	// 게시글 리스트 메서드
	// =======================================================================================
	public boolean nextPage(int pageNumber) {
		String sql = "SELECT * FROM BBS WHERE BBSID < ? AND BBSAVAILABLE=1"; // 가장 마지막에 쓰인 bbsID를 가져오는 sql문
		try {
			// bbs는 DB접근이 많아 충돌날 수 있기 때문에 각 함수에 넣어 줌_퀴리문 대기 및 설정(설정및 실행)
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false; // 데이터베이스 오류
	}
}
