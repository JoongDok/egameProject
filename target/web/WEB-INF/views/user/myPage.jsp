<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Store eGame : 마이페이지</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
$(document).ready(function() {
		
	var cookieUserId = "<c:out value='${cookieUserId}'/>";	
	
	$("#pointBtn").on("click", function(){
		location.href = "/kakao/pay";
	});
	
	$("#img-update").on("click", function(cookieUserId) {
		$("#img-update").prop("disabled", true);
		var fileInput = document.querySelector("#userFile").value;
		//console.log(fileInput);		
		
		if(fileInput == "")
		//fileInput 값이 없으면	
		{
			if(confirm("기본이미지로 변경하시겠습니까?"))		
			//확인
			{
				fn_updateImg(cookieUserId);				
			}
			else
			//취소
			{
				$('#popup_box').modal('hide');
			}
		}
		else
		{
			fn_updateImg(cookieUserId);				
		}
		
	});
});

//프로필 변경
function fn_updateImg(cookieUserId)
{
	var form = $("#imgForm")[0];
	var formData = new FormData(form);	
	
	$.ajax({
		type:"POST",
		enctype:"multipart/form-data",
		url:"/user/updateImg",
		data:formData,
		processData:false,
		contentType:false,
		cache:false,
		beforeSend:function(xhr){
			xhr.setRequestHeader("AJAX", "true");
		},
		success:function(response){
			if(response.code == 0)
			{
				alert("프로필 사진이 변경되었습니다.");				
				location.href = "/user/myPage";
			}
			else if(response.code == 1)
			{
				alert("기본이미지로 변경되었습니다.");
				location.href = "/user/myPage";
			}
			else if(response.code == 500)
			{
				alert("프로필 변경 중 오류가 발생하였습니다.");
				$("#img-update").prop("disabled", false);
			}
		},
		error:function(error){
			icia.common.error(error);
			alert("프로필 변경 중 오류가 발생하였습니다.");
			$("#img-update").prop("disabled", false);
		}
	});
	
	//location.reload();
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
                    <span>마이페이지</span>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb End -->

<!-- Anime Section Begin -->
<section class="anime-details spad" style="min-height: 600px; margin-top: 50px;">
    <div class="container">
        <div class="anime__details__content">
            <div class="row">
                <div class="col-lg-3">
               
                    <div class="anime__details__pic set-bg" data-setbg="/resources/img_userimg/${user.userImg}" style="height: 300px;">	                        
                        <div class="view" style="margin-bottom: -15px;">
                            <a data-toggle="modal" data-target="#popup_box" style="cursor: pointer;">프로필 변경</a>
                        </div>	                            
                    </div>


                    <!-- 프로필변경 팝업창 -->
                    <div class="modal fade" id="popup_box">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <p>프로필 변경</p>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>                                        
                                </div>
                                <form name="imgForm" id="imgForm" method="post" enctype="multipart/form-data">
	                                <div class="modal-body" style="display: flex;">
	                                    <!-- 미리보기 <img src="/resources/img_userimg/프로필이미지.jpg" alt="이미지 없음" style="border: 1px solid gray; width: 80px; height: 90px; color: black;"> -->
	                                    <input type="file" id="userFile" name="userFile" class="form-control mb-2" placeholder="파일을 선택하세요." style="margin-left: 10px;" accept="image/*" required />
	                                </div>
	                                <div class="modal-footer">
	                                	<button type="submit" class="btn btn-default" id="img-update">저장</button>                                       
	                                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	                                </div>
                                </form>
                            </div>            
                        </div>
                    </div>
                    
                </div>
                <div class="col-lg-9">
                    <div class="anime__details__text">
                        <div class="anime__details__title">
 
<c:choose> 
    <c:when test="${!empty user.userNickname}">                            
                            <span>${user.userNickname}</span>
	</c:when>
	<c:otherwise>
							<span>${user.userId}</span>
	</c:otherwise>
</c:choose>	                            
                            
                            <span>${user.userEmail}</span>
                        </div>                                                                                                                                                                                                                                                                                                                   

                        <div class="anime__details__widget">
                            <div class="row">
                                <div class="col-lg-6 col-md-6">
                                    <ul>
                                        <li>
                                        	<span><a href="/user/library">보유 게임:</a></span> 
                                            <a href="/user/library"> ${countGame}</a>
                                        </li>
                                        <li><span>보유 포인트:</span> <fmt:formatNumber value="${user.pointPos}" pattern="#,###"/></li> 
                                        <li><span>사용 포인트:</span> <fmt:formatNumber value="${expenditure}" pattern="#,###"/></li>
                                        <li><span>장바구니:</span> ${countCart}</li>
                                        <li><span>친구:</span> ${countFriend}</li>
                                    </ul>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <ul>
                                        <li><span>문의:</span> ${countQnaReview} / ${countQna}</li>
                                        <li><span>리뷰:</span> ${countReview}</li>
                                        <li><span>신고:</span> ${countCompleteReport} / ${countReport}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="anime__details__btn">
                        	<button type="button" id="pointBtn" class="follow-btn" style="border: none;">포인트 충전</button>
                            <a href="/user/friend" class="watch-btn"><span>친구</span> <i class="fa fa-angle-right"></i></a>                            
                        </div>
                    </div>
                </div>
            </div>
        </div>      
    </div>
</section>
<!-- Anime Section End -->
    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>