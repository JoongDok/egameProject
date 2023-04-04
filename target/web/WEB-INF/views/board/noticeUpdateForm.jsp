<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Store eGame : 공지등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
    #div1{ width: 900px; height: 1000px; margin: auto; }
    #div2{ width: 900px; height: 100px; margin: auto; }
</style>

<script>
$(document).ready(function(){
	$("#noticeTitle").focus();
	
	$("#btnUpdate").on("click", function(){
		
		$("#btnUpdate").prop("disabled", true);
		
		if($.trim($("#noticeTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#noticeTitle").val("");
			$("#noticeTitle").focus();
			$("#btnUpdate").prop("disabled", false); // 저장버튼 활성화
			return;
		}
		
		if($.trim($("#noticeContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#noticeContent").val("");
			$("#noticeContent").focus();
			$("#btnUpdate").prop("disabled", false);
			return;
		}
		
		var form = $("#noticeUpdateForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			url:"/board/noticeUpdateProc",
			data:formData,
			processData:false,
			contentType:false,
			cache:false,
			beforeSend:function(xhr){
				xhr.setRequestHeader("AJAX", "true");
			},
			success:function(response)
			{
				if(response.code == 0)
				{
					alert("공지사항이 수정 되었습니다.");
					location.href = "/board/notice";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#btnUpdate").prop("disabled", false);
				}
				else
				{
					alert("공지사항 수정 중 오류가 발생하였습니다.");
					$("#btnUpdate").prop("disabled", false);
				}
			},
			error:function(error)
			{
				game.common.error(error);
				alert("공지사항 수정 중 오류가 발생하였습니다.");
				$("#btnUpdate").prop("disabled", false);
			}
		});
	});
	
	$("#btnCancel").on("click", function(){
		document.noticeForm.action = "/board/notice";
		document.noticeForm.submit();
	});
});

</script>
</head>

<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 
<div id="div1">
    <div id="div2"></div>
    <div class="container">
        <h2 style=color:#fff;>공지사항 등록</h2>
        <form name="noticeUpdateForm" id="noticeUpdateForm" method="post">
            <input type="text" name="noticeTitle" id="noticeTitle" maxlength="50" class="form-control mb-2" placeholder="제목을 입력해주세요." value="${notice.noticeTitle}" required />
            <div class="form-group">
                <textarea class="form-control" rows="10" name="noticeContent" id="noticeContent" placeholder="내용을 입력해주세요" required>${notice.noticeContent}</textarea>
            </div>
            
            <div class="form-group row">
                <div class="col-sm-12">
                    <button type="button" id="btnUpdate" class="btn btn-primary">저장</button>
                    <button type="button" id="btnCancel" class="btn btn-secondary">취소</button>
                </div>
            </div>
            <input type="hidden" name="noticeSeq" value="${noticeSeq}">
        </form>
        <form name="noticeForm" id="noticeForm" method="post">
	        <input type="hidden" name="noticeSeq" value="${notice.noticeSeq}" />
	        <input type="hidden" name="searchValue" value="${searchValue}" />
	        <input type="hidden" name="curPage" value="${curPage}" />
   		</form>
    </div>
</div>
    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>