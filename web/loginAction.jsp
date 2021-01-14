<%@page import="java.io.PrintWriter"%>	<!-- 자바스크립트 입출력 메서드 불러오기 -->
<%@page import="user.UserDAO"%>			<!-- 내가 만든 UserDAO 불러오기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>			<!-- 한글 입력시 UTF-8로변경해 깨지지 않음 -->
<jsp:useBean id="user" class="user.User" scope="page"/>	<!-- USer클래스를 javaBeans로 사용(scope="page" 이 페이지에서만 사용) -->
<jsp:setProperty name="user" property="userID"/>		<!-- 전페이지에서 받아온 id를 userID에 저장 -->
<jsp:setProperty name="user" property="userPassword"/>	<!-- 전페이지에서 받아온 password를 userPassword에 저장 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	// 현재 세션 상태체크
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
	UserDAO dao=new UserDAO();
	int result=dao.login(user.getUserID(), user.getUserPassword());
	if(result== 1){		// 로그인 성공
		session.setAttribute("userID", user.getUserID());		// 로그인 성공시 세션을 보냄
		PrintWriter script=response.getWriter();
		script.println("<script>");			// 스크립트 출력
		script.println("location.href='main.jsp'");	// location.href='main.jsp' == main.jsp로 넘어기가
		script.println("</script>");
	}
	else if(result== 0){		// 비밀번호 불일치
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");	// 이전 페이지로 돌아가기
		script.println("</script>");
	}
	else if(result== -1){		// 존재하지 않는 아이디
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result== -2){		// 오류
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('네트워크 연결 오류')");
		script.println("history.back()");
		script.println("</script>");
	}
%>
</body>
</html>