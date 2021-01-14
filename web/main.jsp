<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<mata name="viewport" content="text/html; charset=UTF-8"> <!-- 부트스트랩 반형형사이트 메타탭 (화면 최적화)-->
<link rel="stylesheet" href="css/bootstrap.css"><!-- 부트스트랩 CSS사용 -->
<!-- 부트스트랩 참조 링크 -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<script src="js/bootstrap.js"></script>
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
<%
	// 메인 페이지로 이동했을 때 세션 유지 체크
	String userID= null;
	if(session.getAttribute("userID") != null){
		userID=(String)session.getAttribute("userID");
	}
%>

	<!-- 네비게이션 영역 -->
	<nav class="navbar navbar-default">
		<div class="navbar_header"><!-- 네비게이션 헤더부 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a><!-- 메뉴바 제목 -->
			<!-- 네비게이션 메뉴부분 반응형으로 만들어 좁아지면 버튼에 넣음 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 좁아지면 나타나는 햄버거 버튼 <span/>사용사 1줄만 표현-->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
		</div>
		<!-- 게시판 제목 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a>
				<li><a href="bbs.jsp">게시판</a>
			</ul>
<%
			// 로그인 하지 않았을 경우
			if(userID == null){
%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
<%
			// 로그인 했을 경우
			}else{
%>
				<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
<%
			}
%>
		</div>
	</nav><!-- //nav -->
	메인페이지
</body>
</html>