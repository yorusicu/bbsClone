<%@page import="java.io.PrintWriter"%>	<!-- 자바스크립트 입출력 메서드 불러오기 -->
<%@page import="bbs.BbsDAO"%>			<!-- 내가 만든 UserDAO 불러오기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>			<!-- 한글 입력시 UTF-8로변경해 깨지지 않음 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>	<!-- USer클래스를 user란 이름으로 javaBeans로 사용(scope="page" 이 페이지에서만 사용) -->
<!-- 전 페이지에서 회원정보 받아오기 위해 추가 -->
<jsp:setProperty name="bbs" property="bbsTitle"/>		<!-- 전페이지에서 받아온 글제목를 bbsTitle에 저장 -->
<jsp:setProperty name="bbs" property="bbsContent"/>		<!-- 전페이지에서 받아온 글제목을를 bbsContent에 저장 -->

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
	// 로그인 한 사람만 글 쓸 수 있도록 코드 수정
	if(userID == null){
		PrintWriter script=response.getWriter();
		script.println("<script>");			// 스크립트 출력
		script.println("alert('로그인이 되어있지 않습니다')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		// 입력사항이 1개라도 빠지면
		if(bbs.getBbsTitle()==null||bbs.getBbsContent()==null){
			System.out.println("입력사항 빠짐");
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 사항이 있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 모두 입력 됐으면
			BbsDAO dao=new BbsDAO();
			int result=dao.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			// DB오류
			if(result== -1){
				System.out.println("DB오류");
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				System.out.println("성공");
				PrintWriter script=response.getWriter();
				script.println("<script>");			// 스크립트 출력
				script.println("alert('글쓰기 성공')");
				script.println("location.href='main.jsp'");	// location.href='main.jsp' == main.jsp로 넘어가기
				script.println("</script>");
			}
		}
	}
%>
</body>
</html>