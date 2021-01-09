<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				<li><a href="main.jsp">메인</a>
				<li><a href="bbs.jsp">게시판</a>
			</ul>
			<!--  -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav><!-- //nav -->
	<!-- 로그인 양식 -->
	<div class="container">
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top:20px;">
				<form action="loginAction.jsp" method="post">
					<h3 style="text-align:center;">로그인 화면</h3>
					<div class=form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class=form-group">
						<input type="password" class="form-control" placeholder="패스워드" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
			</div>
		</div>
	</div>
	
	JSP: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>
	
	Servlet: <%=application.getMajorVersion()%>.<%= application.getMinorVersion() %>


</body>
</html>