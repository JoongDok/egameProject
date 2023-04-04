<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="description" content="Game Template" />
    <meta name="keywords" content="Game, unica, creative, html" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Store eGame : 신고 등록</title> -->

<!-- Google Font -->
<link
  href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
  rel="stylesheet"
/>
<link
  href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
  rel="stylesheet"
/>

<!-- Css Styles -->
<link
  rel="stylesheet"
  href="/resources/css/report-reg-form.css"
  type="text/css"
/>
<link
  rel="stylesheet"
  href="/resources/css/bootstrap.min.css"
  type="text/css"
/>
<link rel="stylesheet" href="/resources/css/style.css" type="text/css" />
<link
  rel="stylesheet"
  href="/resources/css/elegant-icons.css"
  type="text/css"
/>

<!-- Js -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<script>
  $(document).ready(function () {
    $.load = function () {
      $("#detail_kategori").css("display", "block");
      if ($("#reportPr").val() == "상품") {
        $("#review_kategori").css("display", "none");
        $("#product_kategori").css("display", "block");
      }
      if ($("#reportPr").val() == "리뷰") {
        $("#product_kategori").css("display", "none");
        $("#review_kategori").css("display", "block");
      }
    };

    $(document).on("change", "#product_report_Tag", function () {
      console.log(1);
      $("#reportProductTag").val($("#product_report_Tag").val());
    });

    $(document).on("change", "#review_report_Tag", function () {
      console.log(2);
      $("#reportReviewTag").val($("#review_report_Tag").val());
    });

    $("#reportPr").change(function () {
      $.load();
    });

    $("#btnWrite").on("click", function () {
      $("#btnWrite").prop("disabled", true);
      var report_tag;

      if ($("#reportPr").val() == "상품") {
        if (
          $.trim($("#product_report_Tag").val()).length <= 0 ||
          $.trim($("#product_report_Tag").val()).length == null
        ) {
          alert("신고 옵션을 선택하세요.");
          $("#btnWrite").prop("disabled", false);
          return;
        }
        report_tag = $("#product_report_Tag").val();
      } else if ($("#reportPr").val() == "리뷰") {
        if (
          $.trim($("#review_report_Tag").val()).length <= 0 ||
          $.trim($("#review_report_Tag").val()).length == null
        ) {
          alert("신고 옵션을 선택하세요.");
          $("#btnWrite").prop("disabled", false);
          return;
        }
        report_tag = $("#review_report_Tag").val();
      } else {
        alert("메인태그를 선택해주세요");
        return;
      }

      if ($.trim($("#reportContent").val()).length <= 0) {
        alert("내용을 입력하세요.");
        $("#reportContent").val("");
        $("#reportContent").focus();
        $("#btnWrite").prop("disabled", false);
        return;
      }

      var form = $("#reportRegForm")[0];
      var formData = new FormData(form);

      $.ajax({
        type: "POST",
        url: "/board/reportWriteProc",
        data: formData,
        processData: false,
        contentType: false,
        cache: false,
        beforeSend: function (xhr) {
          xhr.setRequestHeader("AJAX", "true");
        },
        success: function (response) {
          if (response.code == 0) {
            alert("신고가 정상적으로 접수 되었습니다.");
            location.reload();
          } else if (response.code == 400) {
            alert("파라미터 값이 올바르지 않습니다.");
            $("#btnWrite").prop("disabled", false);
          } else {
            alert("신고 접수 중 오류가 발생하였습니다.");
            $("#btnWrite").prop("disabled", false);
          }
        },
        error: function (error) {
          game.common.error(error);
          alert("신고 접수 중 오류가 발생하였습니다.");
          $("#btnWrite").prop("disabled", false);
        },
      });
    });
  });
</script>
<style>
  #detail_kategori,
  #product_kategori,
  #review_kategori {
    display: none;
  }
  *,
  ::after,
  ::before {
    margin-bottom: 0;
  }
</style>
<!-- </head> -->

<!-- <body>
     -->

<!-- Report Section Start -->
<section class="report_section">
  <form name="reportRegForm" id="reportRegForm" method="post">
    <div class="report_form">
      <div class="report_context">
        <a
          style="color: white"
          href="javascript:void(0)"
          onclick="fn_modal_off()"
          >x</a
        >
        <h2 style="margin-bottom: 20px">신고하기</h2>
        <div class="report_wrapper">
          <select required class="report_pr" name="reportPr" id="reportPr">
            <option selected disabled hidden>신고 구분</option>
            <option value="상품">상품</option>
            <option value="리뷰">리뷰</option>
          </select>
        </div>
        <div class="report_wrapper" id="detail_kategori">
          <div id="product_kategori">
            <select
              required
              class="report_tag"
              name="reportTag"
              id="product_report_Tag"
            >
              <option value="">상품신고 태그</option>
              <option value="저작권위반">저작권위반</option>
              <option value="아동학대">아동학대</option>
              <option value="법률위반">법률위반</option>
              <option value="악성코드">악성코드</option>
              <option value="사기">사기</option>
              <option value="카테고리">카테고리</option>
              <option value="기타">기타</option>
            </select>
          </div>
          <div id="review_kategori">
            <select
              required
              class="report_tag"
              name="reportTag"
              id="review_report_Tag"
            >
              <option value="">리뷰신고 태그</option>
              <option value="홍보글">홍보글</option>
              <option value="음란성">음란성</option>
              <option value="혐오">혐오</option>
            </select>
          </div>
        </div>
        <div class="report_context_tbox">
          <textarea
            class="report_context_text"
            name="reportContent"
            id="reportContent"
            maxlength="500"
            placeholder="자세한 내용을 적어주세요(500자 이내)"
          ></textarea>
        </div>
        <input type="hidden" id="report_product_seq" />
        <input type="hidden" id="report_review_seq" />
        <input type="hidden" id="reportProductTag" />
        <input type="hidden" id="reportReviewTag" />
        <button class="report_btn" id="btnWrite">제출</button>
      </div>
    </div>
  </form>
</section>
<!-- Report Section End -->

<!-- 
  </body> -->
<!-- </html> -->
