<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> -->

<!DOCTYPE html>
<html>
  <head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>Store eGame : 상품 등록</title>
    <script>
      $(document).ready(function () {
        $("#product_page_btn").click(function(){
           location.href = '/test/product'; 
        });

        $(".main_tag").on("change", function () {
         //#action_tag_div

          if ($("input[name='main_tag']:checked").val() == "0100") {
            check_false();
            $("#action_tag_div").css("display", "block");
            $("#racing_tag_div").css("display", "none");
            $("#fps_tag_div").css("display", "none");
            $("#sim_tag_div").css("display", "none");
          } else if ($("input[name='main_tag']:checked").val() == "0200") {
            check_false();
            $("#action_tag_div").css("display", "none");
            $("#racing_tag_div").css("display", "block");
            $("#fps_tag_div").css("display", "none");
            $("#sim_tag_div").css("display", "none");
          } else if ($("input[name='main_tag']:checked").val() == "0300") {
            check_false();
            $("#action_tag_div").css("display", "none");
            $("#racing_tag_div").css("display", "none");
            $("#fps_tag_div").css("display", "block");
            $("#sim_tag_div").css("display", "none");
          } else if ($("input[name='main_tag']:checked").val() == "0400") {
            check_false();
            $("#action_tag_div").css("display", "none");
            $("#racing_tag_div").css("display", "none");
            $("#fps_tag_div").css("display", "none");
            $("#sim_tag_div").css("display", "block");
          }
        });

        $("#product_insert").on("click", function () {
          var tags = [];
          if ($("input[name='main_tag']:checked").val() == "0100") {
            tags.push("0100");
            $("input:checkbox[name=action_tag]").each(function (index) {
              if ($(this).is(":checked") == true) {
                tags.push($(this).val());
              }
            });
          } else if ($("input[name='main_tag']:checked").val() == "0200") {
            tags.push("0200");
            $("input:checkbox[name=racing_tag]").each(function (index) {
              if ($(this).is(":checked") == true) {
                tags.push($(this).val());
              }
            });
          } else if ($("input[name='main_tag']:checked").val() == "0300") {
            tags.push("0300");
            $("input:checkbox[name=fps_tag]").each(function (index) {
              if ($(this).is(":checked") == true) {
                tags.push($(this).val());
              }
            });
          } else if ($("input[name='main_tag']:checked").val() == "0400") {
            tags.push("0400");
            $("input:checkbox[name=sim_tag]").each(function (index) {
              if ($(this).is(":checked") == true) {
                tags.push($(this).val());
              }
            });
          }
          $("#payPrice").val($("#productPrice"));

          $.ajax({
            type: "POST",
            url: "/test/productInsert",
            data: {
              productName: $("#productName").val(),
              productContent: $("#productContent").val(),
              userSellerId: $("#userSellerId").val(),
              productPrice: $("#productPrice").val(),
              payPrice: $("#productPrice").val(),
              tags: tags,
            },
            datatype: "JSON",
            beforeSend: function (xhr) {
              xhr.setRequestHeader("AJAX", "true");
            },
            success: function (response) {
              if (response.code == 0) {
                alert("성공");
                location.reload();
                return;
              } else if (response.code == 400) {
                alert("파라미터값이 잘못되었습니다");
                return;
              } else if (response.code == 500) {
                alert("인서트중 에러발생");
                return;
              }
            },
            error: function () {
              game.common.error(error);
            },
          });
        });
      });
      function check_false() {
        $("input:checkbox[name='action_tag']").prop("checked", false);
        $("input:checkbox[name='racing_tag']").prop("checked", false);
        $("input:checkbox[name='fps_tag']").prop("checked", false);
        $("input:checkbox[name='sim_tag']").prop("checked", false);
      }
    </script>
    <link rel="stylesheet" href="/resources/css/product-reg-form.css" type="text/css">
  </head>
  <body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  
    <div class="space-adaptive"></div>
    <section class="product_reg_section">
        <span>상품 등록하기</span><button class="product_page_btn" id="product_page_btn">상품페이지</button>
        <div class="space-adaptive"></div>
        <form class="product_reg_form" action="/test/productReg" method="post">
            <input class="product_reg_input" type="text" id="productName" placeholder="상품 이름">
            <div class="space-adaptive"></div>
            <input class="product_reg_input" type="text" id="userSellerId" placeholder="판매자 아이디">
            <div class="space-adaptive"></div>
            <input class="product_reg_input" type="number" id="productPrice" autocomplete="off" placeholder="상품 가격">
            <div class="space-adaptive"></div>
            <div class="tag_div">
                <div class="main_tag_wrapper">
                    <div class="main_tag_div"><input type="radio" name="main_tag" class="main_tag" value="0100">액션</div>
                    <div class="main_tag_div"><input type="radio" name="main_tag" class="main_tag" value="0200">레이싱</div>
                    <div class="main_tag_div"><input type="radio" name="main_tag" class="main_tag" value="0300">FPS</div>
                    <div class="main_tag_div"><input type="radio" name="main_tag" class="main_tag" value="0400">시뮬레이션</div>
                </div>
                <div id="action_tag_div">
                    <div class="sub_tag_wrapper">
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0101">1인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0102">3인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0103">판타지</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0104">귀여운</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0105">픽셀</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0106">탄탄한스토리</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0107">오픈월드</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0108">공포</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0109">솔로플레이</div>
                        <div class="sub_tag_div"><input type="checkbox" name="action_tag" value="0110">협동</div>
                    </div>
                </div>
                <div id="racing_tag_div">
                    <div class="sub_tag_wrapper">
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0201">1인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0202">3인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0203">판타지</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0204">자유로운트랙</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0205">현실적인</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0206">오토바이</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0207">자동차</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0208">멀티플레이</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0209">비행</div>
                        <div class="sub_tag_div"><input type="checkbox" name="racing_tag" value="0210">커스터마이징</div>
                    </div>
                </div>
                <div id="fps_tag_div">
                    <div class="sub_tag_wrapper">
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0301">1인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0302">3인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0303">오픈월드</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0304">PVP</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0305">협동</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0306">배틀로얄</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0307">공포</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0308">탄탄한스토리</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0309">솔로플레이</div>
                        <div class="sub_tag_div"><input type="checkbox" name="fps_tag" value="0310">사실적인</div>
                    </div>
                </div>
                <div id="sim_tag_div">
                    <div class="sub_tag_wrapper">
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0401">1인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0402">3인칭</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0403">스포츠</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0404">전략</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0405">농장</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0406">운전</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0407">생활</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0408">건설</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0409">협동</div>
                        <div class="sub_tag_div"><input type="checkbox" name="sim_tag" value="0410">솔로플레이</div>
                    </div>
                </div>
            </div>
            <div class="space-adaptive"></div>
            <div class="textarea_div">
                <textarea class="product_reg_textarea" id="productContent" placeholder="상품 내용(설명)"></textarea></div>
            <div class="space-adaptive"></div>
            <input class="product_insert_btn" type="button" id="product_insert" value="등록하기">
            <input type="hidden" id="payPrice">
        </form>
    </section>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
  </body>
</html>
