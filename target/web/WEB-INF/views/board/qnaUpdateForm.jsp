<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Store eGame : 문의 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#qnaTitle").focus();
	
	$("#btnSave").on("click", function(){
		
		$("#btnSave").prop("disabled", true);
		
		if($.trim($("#qnaTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#qnaTitle").val("");
			$("#qnaTitle").focus();
			$("#btnSave").prop("disabled", false);
			return;
		}
		
		if($.trim($("#qnaContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#qnaContent").val("");
			$("#qnaContent").focus();
			$("#btnSave").prop("disabled", false);
			return;
		}
		
		var form = $("#qnaUpdateForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			url:"/board/qnaUpdateProc",
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
					alert("문의가 수정 되었습니다.");
					location.href = "/board/qna";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#btnSave").prop("disabled", false);
				}
				else
				{
					alert("문의 수정 중 오류가 발생하였습니다.");
					$("#btnSave").prop("disabled", false);
				}
			},
			error:function(error)
			{
				game.common.error(error);
				alert("문의 수정 중 오류가 발생하였습니다.");
				$("#btnSave").prop("disabled", false);
			}
		});
	});
	
	$("#btnCancel").on("click", function(){
		document.qnaForm.action = "/board/qnaDetail";
		document.qnaForm.submit();
	});
});

</script>
</head>

<style>
    #div1{ width: 900px; height: 600px; margin: auto; }
    #div2{ width: 900px; height: 100px; margin: auto; }
</style>
<body>
 <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
 
<div id="div1">
    <div id="div2">
    </div>
    
    <div class="container">
        <h2><a style="color: #fff;">문의 수정</a></h2>
        <form name="qnaUpdateForm" id="qnaUpdateForm" method="post">
            <input type="text" name="qnaTitle" id="qnaTitle" maxlength="18" class="form-control mb-2" placeholder="제목을 입력해주세요." value="${qna.qnaTitle}" required />
            <div class="form-group">
                <textarea class="form-control" rows="10" name="qnaContent" id="qnaContent" placeholder="내용을 입력해주세요" required>${qna.qnaContent}</textarea>
            </div>
            
            <div class="form-group row">
                <div class="col-sm-12">
                    <button type="button" id="btnSave" class="btn btn-primary">저장</button>
                    <button type="button" id="btnCancel" class="btn btn-secondary">취소</button>
                </div>
            </div>
            <input type="hidden" name="qnaSeq" value="${qnaSeq}" />
        </form>
        <form name="qnaForm" id="qnaForm" method="post">
            <input type="hidden" name="qnaSeq" value="${qna.qnaSeq}" />
            <input type="hidden" name="searchValue" value="${searchValue}" />
            <input type="hidden" name="curPage" value="${curPage}" />
        </form>
    </div>

</div>
    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>