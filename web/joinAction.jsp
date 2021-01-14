<%@page import="java.io.PrintWriter"%>	<!-- 자바스크립트 입출력 메서드 불러오기 -->
<%@page import="user.UserDAO"%>			<!-- 내가 만든 UserDAO 불러오기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>			<!-- 한글 입력시 UTF-8로변경해 깨지지 않음 -->
<jsp:useBean id="user" class="user.User" scope="page"/>	<!-- USer클래스를 user란 이름으로 javaBeans로 사용(scope="page" 이 페이지에서만 사용) -->
<!-- 전 페이지에서 회원정보 받아오기 위해 추가 -->
<jsp:setProperty name="user" property="userID"/>		<!-- 전페이지에서 받아온 id를 userID에 저장 -->
<jsp:setProperty name="user" property="userPassword"/>	<!-- 전페이지에서 받아온 id를 userPassword에 저장 -->
<jsp:setProperty name="user" property="userName"/>		<!-- 전페이지에서 받아온 id를 userName에 저장 -->
<jsp:setProperty name="user" property="userGender"/>	<!-- 전페이지에서 받아온 id를 userGender에 저장 -->
<jsp:setProperty name="user" property="userEmail"/>		<!-- 전페이지에서 받아온 id를 userEmail에 저장 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
//현재 세션 상태체크
	String userID=null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	// 이미 로그인이 됐음 로그인 못하게 함
	if(userID != null){
		PrintWriter script=response.getWriter();
		script.println("<script>");			// 스크립트 출력
		script.println("alret('이미 로그인 되었습니다')");
		script.println("location.href='main.jsp'");	// location.href='main.jsp' == main.jsp로 넘어기가
		script.println("</script>");
	}
	// 입력사항이 1개라도 빠지면
	if(user.getUserID()==null||user.getUserPassword()==null||user.getUserName()==null
	||user.getUserGender()==null||user.getUserEmail()==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		// 모두 입력 됐으면
		UserDAO dao=new UserDAO();
		int result=dao.join(user);
		if(result== -1){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			session.setAttribute("userID", user.getUserID());
			PrintWriter script=response.getWriter();
			script.println("<script>");			// 스크립트 출력
			script.println("alert('회원가입 성공')");
			script.println("location.href='main.jsp'");	// location.href='main.jsp' == main.jsp로 넘어가기
			script.println("</script>");
		}
	}
%>
</body>
</html>