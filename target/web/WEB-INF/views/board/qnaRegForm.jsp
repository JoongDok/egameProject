<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Store eGame : 문의 등록</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	$("#qnaTitle").focus();
	
	$("#btnWrite").on("click", function(){
		
		$("#btnWrite").prop("disabled", true);
		
		if($.trim($("#qnaTitle").val()).length <= 0)
		{
			alert("제목을 입력하세요.");
			$("#qnaTitle").val("");
			$("#qnaTitle").focus();
			$("#btnWrite").prop("disabled", false);
			return;
		}
		
		if($.trim($("#qnaContent").val()).length <= 0)
		{
			alert("내용을 입력하세요.");
			$("#qnaContent").val("");
			$("#qnaContent").focus();
			$("#btnWrite").prop("disabled", false);
			return;
		}
		
		var form = $("#qnaRegForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			type:"POST",
			url:"/board/qnaWriteProc",
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
					alert("문의 등록 되었습니다.");
					location.href = "/board/qna";
				}
				else if(response.code == 400)
				{
					alert("파라미터 값이 올바르지 않습니다.");
					$("#btnWrite").prop("disabled", false);
				}
				else
				{
					alert("문의 등록 중 오류가 발생하였습니다.");
					$("#btnWrite").prop("disabled", false);
				}
			},
			error:function(error)
			{
				game.common.error(error);
				alert("문의 등록 중 오류가 발생하였습니다.");
				$("#btnWrite").prop("disabled", false);
			}
		});
	});
	
	$("#btnCancel").on("click", function(){
		document.qnaForm.action = "/board/qna";
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
        <h2><a style="color: #fff;">문의 쓰기</a></h2>
        <form name="qnaRegForm" id="qnaRegForm" method="post">
            <input type="text" name="qnaTitle" id="qnaTitle" maxlength="50" class="form-control mb-2" placeholder="제목을 입력해주세요." required />
            <div class="form-group">
                <textarea class="form-control" rows="10" name="qnaContent" id="qnaContent" placeholder="내용을 입력해주세요" required></textarea>
            </div>
            
            <div class="form-group row">
                <div class="col-sm-12">
                    <button type="button" id="btnWrite" class="btn btn-primary">저장</button>
                    <button type="button" id="btnCancel" class="btn btn-secondary">취소</button>
                </div>
            </div>
        </form>
        <form name="qnaForm" id="qnaForm" method="post">
            <input type="hidden" name="qnaSeq" value="" />
            <input type="hidden" name="searchValue" value="" />
            <input type="hidden" name="curPage" value="" />
            <input type="hidden" name="qnaStatus" value="" />
        </form>
    </div>

</div>
    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>