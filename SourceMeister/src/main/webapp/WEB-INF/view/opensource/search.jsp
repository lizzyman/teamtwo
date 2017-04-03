<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="/SourceMeister/static/js/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/SourceMeister/static/css/index_layout.css" />
<script type="text/javascript">

$().ready(function () {
	
	$("#keyword").keydown(function(e) {
		if (e.which == 13) {
			submitForm();
		}
	});
		
	
	$("#searchForm").find("input[type=button]").click(function() {
		submitForm();
	});
	
	
	function submitForm() {
		$("#searchForm").attr({
			"action" : "/SourceMeister/opensource",
			"method" : "post"
		}).submit();
	}
	
	
	
});




</script>

<title>검색</title>
</head>
<body>







	<div id="container">
		
<%-- <<<<<<< HEAD
		<div id="top">
			<div id="login"></div>
			<div id="search">
				<form id="searchForm">
					<input id="keyword" name="search" type="text" /> <input type="button" value="검색" />
				</form>
			</div>
		</div>
		
		<div id="left-rank">
			<div id="rank-repo">
				<span>저장소별 소스 수</span>
			</div>
			<div id="rank-lan">
				<span>언어별 소스 수</span>
			</div>
		</div>
			
		<div id="middle-content">
			<jsp:include page="/WEB-INF/view/opensource/list.jsp" flush="false"></jsp:include>
		</div>	
		<div id="right-rank">
			<span>검색어 순위</span>
			
		</div>
			<div id="footer">
			 	<span>Copyright </span>
			</div>	
		</div>


=======
	<form id="searchForm">

		<input id="keyword" name="search" type="text" /> <input type="button" value="검색" />
	</form>

	<jsp:include page="/WEB-INF/view/opensource/list.jsp"></jsp:include>
>>>>>>> jun


======= --%>
		<div id="left">
			<div class="login">
				<jsp:include page="/WEB-INF/view/user/signIn.jsp" flush="false"></jsp:include>
			</div>
			
			<div class="rank-repo">
				<span>저장소별 소스 수</span>
			</div>
			
			<div class="rank-lan">
				<span>언어별 소스 수</span>
				
				<c:forEach items="${languages}" var="lang">
<span>${lang.id}</span>


</c:forEach>
				
				
			</div>
			
		</div><div id="middle">
		
			<div id="search">
				<br/><br/><br/><br/>
				<form id="searchForm">
					<input id="keyword" name="search" type="text" /> <input type="button" value="검색" />
				</form>
				
				<c:if test="${ not empty page}">
				
				<c:if test="${page == 1}">
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page - 1}">${page}</a>
				<span>${page+1}</span>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 1 }">${page+2}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 2 }">${page+3}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 2 }">${page+4}</a>
				
				</c:if>
				<c:if test="${page == 0}">
				<span>${page+1}</span>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 1 }">${page+2}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 2 }">${page+3}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 3 }">${page+4}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 4 }">${page+5}</a>
				
				</c:if>
				<c:if test="${page gt 1}">
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page - 1}">${page-1}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page}">${page}</a>
				<span>${page+1}</span>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 1 }">${page+2}</a>
				<a href="/SourceMeister/opensource?q=${search}&pageNum=${page + 2 }">${page+3}</a>
				</c:if>
				
				</c:if>
				
				
				
			</div>
			
			<div id="middle-content">
				<jsp:include page="${includeUrl}" flush="false"></jsp:include>
			</div>	
			
		</div>
		
		<div id="right">
			<div id="serchRank">
				<span>검색어 순위</span>
			</div>
			
			<div id="reply">
				<span>댓글</span>
			</div>
		</div>
		<div id="footer">
			 <span>Copyright </span>
		</div>	
		
		
		
</div>

		
		
</body>
</html>