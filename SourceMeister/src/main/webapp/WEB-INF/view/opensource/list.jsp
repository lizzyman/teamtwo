<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet" type="text/css"
	href="/SourceMeister/static/css/list_layout.css" />
<script type="text/javascript"
	src="/SourceMeister/static/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	/* $().ready(function(){
	
 		//댓글
		$(".detailLink > a").click(function(){
				
			<deal.jsp>.load("/SourceMeister/reply/list");
			
			$.post("/SourceMeister/reply/list",{
				"openSourceId" : $(this).data("opensourceid")
			},function(response){
				if (response == 'OK') {
					 writeDiv.load("/melon/artist/write");
					//화면 새로고침
					// location.reload(); 
				} else {
					alert("댓글 목록 load 실패 했습니다.\n관리자에게 문의하세요");
				}
			});  
		});	
	}); */
</script>
<title>Insert title here</title>
</head>
<body>

	<p>총 ${count}개가 나왔습니다.</p>

<%-- <<<<<<< HEAD
	<div id="table-content">
		<table>
			<colgroup>
				<col span="1" style="width: 60px;">
				<col span="1" style="width: 250px;">
			</colgroup>
			<c:forEach items="${results}" var="result">
				<tr>

					<td style=" text-align: center; "><c:forEach items="${result.langArr}" var="lang" begin="0"
							end="2">
							<div>${lang.language}:${lang.count }</div>
						</c:forEach><br /></td>
					<td style="padding:20px;"><a
						href="/SourceMeister/opensource/detail?opensourceId=${result.id}"><div
								id="detailLink">${result.name}---${result.repo }<br /><hr> <br />
								<c:forEach items="${result.lines }" var="line">
									
										<xmp>${line.value }</xmp>
									
								</c:forEach>
							</div><!-- </a> --><br /> <br /></td>




				</tr>
			</c:forEach>



		</table>
	</div>
======= --%>
	
	<div id=table-content>
	
	<table>
	
		<colgroup>
			<col span="1" style="width: 15%;">
			<col span="1" style="width: 85%;">
		</colgroup>
		
		<c:forEach items="${results}" var="result">
			<tr>
				<td>
					<c:forEach items="${result.langArr}" var="lang" begin="0" end="2">
						${lang.language}:${lang.count }<br>
					</c:forEach><br />
				</td>
				<td>
					<div class="detailLink" ><a data-opensourceid="${result.id}"  href="/SourceMeister/opensource/detail?opensourceId=${result.id}" >${result.name}---${result.repo }</a><br /> <br /> 
							<c:forEach items="${result.lines }" var="line">
								<div>
									<span>${line.value}</span>
								</div>
							</c:forEach>
					</div>
					
					<br/>
					<br/>
				</td>
			</tr>
		</c:forEach>



	</table>
</div>


</body>
</html>