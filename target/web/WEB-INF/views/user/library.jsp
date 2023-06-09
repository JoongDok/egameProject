<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/library.css" type="text/css">
<title>Store eGame : 보유게임</title>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script>
//페이지 이동 함수
function fn_list(curPage)
{
	document.libraryForm.curPage.value = curPage;
	document.libraryForm.action = "/user/library";
	document.libraryForm.submit();
}

//디테일 페이지 이동 함수
function fn_detail(product_seq)
{
  var popup = window.open(`/storeDetail?productSeq=${"${product_seq}"}`, "_blank", 'width=1000, height=1200, scrollbars=yes, resizable =no')
}

//보유게임 환불 함수
function fn_refund(paySeq)
{
	if(confirm("환불하시겠습니까?") == true)
	{	
		$.ajax({
			type:"POST",
			url:"/library/refund",
			data:{
				paySeq: paySeq
			},
			datatype:"JSON",
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("환불이 완료되었습니다.");
					location.href = "/user/library";
				}
				else if(response.code == -1)
				{
					alert("로그인이 필요합니다.");
					location.href = "/user/login"
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
				}
				else if(response.code == 401)
				{
					alert("정지된 아이디 입니다.");
				}
				else if(response.code == 404)
				{
					alert("목록을 찾을 수 없습니다.");
				}
				else if(response.code == 500)
				{
					alert("환불 중 오류가 발생하였습니다. 500");
				}
				else
				{
					alert("환불 중 오류가 발생하였습니다.");
				}
			},
			error:function(xhr, status, error)
			{
				game.common.error(error);
			}
		});
	}
}
</script>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- Breadcrumb Begin -->
<div class="breadcrumb-option">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb__links">
                    <a href="/index"><i class="fa fa-home"></i> Home</a>
                    <a href="/user/myPage">마이페이지</a>
                    <span>보유게임</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb End -->

<!-- 보유게임 -->
<div id="library" style="min-height: 540px; width: 60%; margin: 0 auto; margin-top: 50px; margin-bottom: 50px;">
    <table class="library_table">
        <thead>
            <tr>
                <th style="width: 60%;">상품정보</th>                
                <th style="width: 20%;">구매날짜</th>
                <th style="width: 20%;">환불가능여부</th>
            </tr>
        </thead>
        <tbody id="tbody">
	<c:if test="${!empty list}">
		<c:forEach var="pay" items="${list}" varStatus="status">
            <tr>
                <td class="library_table_td1" style="padding-left: 15px;">
                    <a href="javascript:void(0)" onclick="fn_detail(${pay.productSeq})">
                    <img src="/resources/img_library/${pay.productName}.jpg" width="30%">
                    &nbsp;&nbsp;${pay.productName}
                    </a>
                </td>
                <td class="library_table_td2">
                    <span>${pay.payDate}</span>
                </td>
                
                <jsp:useBean id="now" class="java.util.Date" />
                <fmt:formatDate var="nowDate" value="${now}" pattern="yyyy.MM.dd HH:mm:ss" />
                <fmt:parseDate var="nowDateParse" value="${nowDate}" pattern="yyyy.MM.dd HH:mm:ss" />
                <fmt:parseNumber var="nowDateNum" value="${nowDateParse.time / (1000*60*60*24)}" integerOnly="true" />
                <fmt:parseDate var="startDateParse" value="${pay.payDate}" pattern="yyyy.MM.dd HH:mm:ss" />
                <fmt:parseNumber var="endDateNum" value="${startDateParse.time / (1000*60*60*24) + 3}" integerOnly="true" />
                
			<c:choose>
				<c:when test="${nowDateNum gt endDateNum}">
                <td class="library_table_td2" style="padding-top: 18px; padding-bottom: 18px;">
					<span>환불불가</span>
				</td>
                </c:when>
                <c:otherwise>
                <td class="library_table_td2" style="padding-top: 18px; padding-bottom: 18px;">
                    <button class="site-btn" onclick="fn_refund(${pay.paySeq})">환불</button>
                </td>
                </c:otherwise>
            </c:choose>    
            </tr>
		</c:forEach>
	</c:if>
		</tbody>
    </table>
    <div class="library_page">
<c:if test="${!empty paging}">
	<c:if test="${paging.prevBlockPage gt 0}">
        <a href="javascript:void(0)" class="page_link" onclick="fn_list(${paging.prevBlockPage})">이전</a>
    </c:if>
    <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
    	<c:choose>
    		<c:when test="${i ne curPage}">
        		<a href="javascript:void(0)" class="page_link" onclick="fn_list(${i})">${i}</a>
        	</c:when>
        	<c:otherwise>
				<a href="javascript:void(0)" class="page_link" style="cursor:default;">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${paging.nextBlockPage gt 0}">
        <a href="javascript:void(0)" class="page_link" onclick="fn_list(${paging.nextBlockPage})">다음</a>
    </c:if>    
</c:if>
    </div>
    
    <form name="libraryForm" id="libraryForm" method="post">
		<input type="hidden" id="curPage" name="curPage" value="${curPage}" />
	</form>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>