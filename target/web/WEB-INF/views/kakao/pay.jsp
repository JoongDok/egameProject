<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    
	$("#btnPay").on("click", function() {
		
		$("#btnPay").prop("disabled", true);
		
		if($.trim($("#totalAmount").val()).length <= 0)
		{
			alert("금액을 입력하세요.");
			$("#totalAmount").val("");
			$("#totalAmount").focus();
			
			$("#btnPay").prop("disabled", false);
			
			return;
		}
		
		if(!icia.common.isNumber($("#totalAmount").val()))
		{
			alert("금액은 숫자만 입력 가능합니다.");
			
			$("#totalAmount").val("");
			$("#totalAmount").focus();
			
			$("#btnPay").prop("disabled", false);
			
			return;
		}
		
		icia.ajax.post({
	        url: "/kakao/payReady",
	        data: {itemCode:$("#itemCode").val(), itemName:$("#itemName").val(), quantity:$("#quantity").val(), totalAmount:$("#totalAmount").val()},
	        success: function (response) 
	        {
	        	icia.common.log(response);
	        	
	        	if(response.code == 0)
	        	{
	        		var orderId = response.data.orderId;
	        		var tId = response.data.tId;
	        		var pcUrl = response.data.pcUrl;
	        		
	        		$("#orderId").val(orderId);
	        		$("#tId").val(tId);
	        		$("#pcUrl").val(pcUrl);
	        		
	        		var win = window.open('', 'kakaoPopUp', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
	                
	        		$("#kakaoForm").submit();
	        		
	        		$("#btnPay").prop("disabled", false);
	        	}
	        	else
	        	{
	        		alert("오류가 발생하였습니다.");
	        		$("#btnPay").prop("disabled", false);
	        	}
	        },
	        error: function (error) 
	        {
	        	icia.common.error(error);
	        	
        		$("#btnPay").prop("disabled", false);
	        }
	    });
	});
});

function movePage()
{
	location.href = "/user/myPage";
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- Signup Section Begin -->

<div class="container" style="min-height: 700px;">
	
		<h2>카카오페이</h2>
		<form name="payForm" id="payForm" method="post" style="color: #ffffff;">
			<input type="hidden" name="itemCode" id="itemCode" class="form-control mb-2" maxlength="32" placeholder="결제코드" value="1" readonly />
			상품명<input type="text" name="itemName" id="itemName" maxlength="50" class="form-control mb-2" placeholder="상품명" value="포인트 충전" readonly /><br />
			<input type="hidden" name="quantity" id="quantity" maxlength="3" class="form-control mb-2" placeholder="수량" value="1" readonly />
			금액<input type="text" name="totalAmount" id="totalAmount" maxlength="10" class="form-control mb-2" placeholder="금액" value="" /><br /><br />
			<div class="form-group row">
				<div class="col-sm-12">
					<button type="button" id="btnPay" class="btn btn-primary" title="카카오페이">카카오페이</button>
				</div>
			</div>
		</form>
	
	<form name="kakaoForm" id="kakaoForm" method="post" target="kakaoPopUp" action="/kakao/payPopUp">
		<input type="hidden" name="orderId" id="orderId" value="" />
		<input type="hidden" name="tId" id="tId" value="" />
		<input type="hidden" name="pcUrl" id="pcUrl" value="" />
	</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>