<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="zxx">
  <head>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <title>상품관리</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
      $(document).ready(function () {
        // 글목록가져오기
        product_ajax();
        main_tag_check()
        if($("input[name='main_tag']:checked").val() != undefined)
        {
            
            if ($(this).hasClass("active")) {
              $(".submenu3").css("display", "none");
              $(this).removeClass("active");
            } else {
              $(this).addClass("active");
              $(".submenu3").css("display", "block");
            }
        }
        //검색종류 변경시 실행
        $(".menu").on("change", function () {
          $("#curPage").val(1);
          product_ajax();
        });

        //정렬방법 변경시 상품검색
        $("#product_status").on("change", function () {
          $("#curPage").val(1);
          product_ajax();
        });

        $(".store__search").on("change", function () {
          $("#curPage").val(1);
          product_ajax();
        });

        //메인태그 선택시 소분류 태그 보이게끔함
        $(".main_tag").on("change", function () {
            main_tag_check()
        });

        //검색 밸류초기화
        $("#search_reset").on("click", function () {
          search_reset();
          product_ajax();
        });

      });

      //메인태그체크확인 후 디스플레이 변경
      function main_tag_check()
      {
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
      }

      //소분류 체크 초기화
      function check_false() {
        $("input:checkbox[name='action_tag']").prop("checked", false);
        $("input:checkbox[name='racing_tag']").prop("checked", false);
        $("input:checkbox[name='fps_tag']").prop("checked", false);
        $("input:checkbox[name='sim_tag']").prop("checked", false);
      }
      //에이작스 실행 함수
      function product_ajax() {
        const tagParentNum = $("input[name='main_tag']:checked").val();
        const discntCheck = $("input[name='discntCheck']:checked").val();
        const productName = $("#productName").val();
        const minPrice = $("#minPrice").val();
        const maxPrice = $("#maxPrice").val();
        const curPage = $("#curPage").val();
        const productStatus = $("#product_status").val();
        var tagNum = [];
        if (tagParentNum == "0100") {
          $("input:checkbox[name=action_tag]").each(function (index) {
            if ($(this).is(":checked") == true) {
              tagNum.push($(this).val());
            }
          });
        } else if (tagParentNum == "0200") {
          $("input:checkbox[name=racing_tag]").each(function (index) {
            if ($(this).is(":checked") == true) {
              tagNum.push($(this).val());
            }
          });
        } else if (tagParentNum == "0300") {
          $("input:checkbox[name=fps_tag]").each(function (index) {
            if ($(this).is(":checked") == true) {
              tagNum.push($(this).val());
            }
          });
        } else if (tagParentNum == "0400") {
          $("input:checkbox[name=sim_tag]").each(function (index) {
            if ($(this).is(":checked") == true) {
              tagNum.push($(this).val());
            }
          });
        }
        if (tagNum.length == 0) {
          tagNum.push(" ");
        }

        $.ajax({
          type: "GET",
          url: "/admin/productForm",
          data: {
            productName: productName,
            discntCheck: discntCheck,
            productStatus: productStatus,
            minPrice: minPrice,
            maxPrice: maxPrice,
            curPage: curPage,
            tagParentNum: tagParentNum,
            tagNum: tagNum,
          },
          datatype: "JSON",
          beforeSend: function (xhr) {
            xhr.setRequestHeader("AJAX", "true");
          },
          success: function (response) {
            var productList = response.data.productList;
            var paging = response.data.paging;
            var tagParentNum = response.data.tagParentNum;
            const main_tag_html = $(".main_tag_name");
            main_tag_html.empty();
            var html;
            if (tagParentNum == "0100") {
              html = "액션";
            } else if (tagParentNum == "0200") {
              html = "레이싱";
            } else if (tagParentNum == "0300") {
              html = "FPS";
            } else if (tagParentNum == "0400") {
              html = "시뮬레이션";
            } else {
              html = "전체";
            }
            main_tag_html.append(html);
            product_print(productList);
            paging_print(paging);
          },
          error: function () {
            game.common.error(error);
          },
        });
      }

      function grade_check(a)
      {
        if(!isFinite(a))
        {
          a = 0;
          return a;
        }
        return a;
      }

      //body에 상품목록 띄워주는 함수
      function product_print(productList) {
        const products = $("#products");

        products.empty();

        if (productList.length != 0) {
          for (const t of productList) {
            var count = 0;
            const productGrade = parseInt(t.productGrade);
            const productStatus = t.productStatus == "Y" ? "승인 완료" : "승인 대기";
           
            grade_a = parseInt(productGrade/10);
            grade_b = productGrade%10;

            
            grade_a = grade_check(grade_a);
            grade_b = grade_check(grade_b);
            grade_c = grade_a+ "." + grade_b


            var product_list = `
            <div class="col-lg-4 col-md-6 col-sm-6">
                  <div class="product__item">
                    <a href="javascript:void(0)" onclick="fn_detail(${"${t.productSeq}"})">
                    <div
                      class="product__item__pic__store set-bg"
                      style="background-image : url(/resources/img_gamemain/${"${t.productImgName}"}.jpg)"
                    >
                      <div class="comment">
                        <i class="fa fa-comments"></i> ${"${t.reviewCnt}"} 
                      </div>
                      <div class="view"><i class="fa fa-download"></i> ${"${t.productBuyCnt}"}</div>
                    </div>
                </a>
                    <div class="product__item__text">
                      <ul>        
            `;

            for (const a of t.tagName) {
              count++;
              product_list =
                product_list +
                `<li>${"${a}"}</li>
              `;
              if (count == 3) break;
            }
            product_list =
              product_list +
              `</ul>
                      <h5>
                        <a href="javascript:void(0)" onclick="fn_detail(${"${t.productSeq}"})">
                          ${"${t.productName}"}    <br/> 승인상태 : ${"${productStatus}"}<div class="review_rating"><div class="rating" id="rating">`;
             
            if(grade_a > 0)
            {
              for(var i = 0; i < 5; i++)
              {
                if(grade_a>i)
                {
                  product_list =
                  product_list +   `<i class="fa fa-star"></i>`;         
                }
                else
                {
                  if(grade_b > 0)
                  {
                    product_list =
                    product_list +   `<i class="fa fa-star-half-o"></i>` ;   
                    grade_b = 0; 
                  }
                  else
                  {
                    product_list =
                    product_list +   `<i class="fa fa-star-o"></i>`;
                  }
                }
              }            
                          
            }  
            else
            {
              product_list =
                product_list +   `<i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i><i class="fa fa-star-o"></i>` ;
            }      
              
              product_list =
              product_list +`</div></div>
                          ₩${"${t.printProductPrice}"}
                        </a>
                      </h5>
                    </div>
                  </div>
                </div>`;

            products.append(product_list);
          }
        } else {
          var product_list = `<h1>상품이 존재하지 않습니다.<h1>`;

          products.append(product_list);
        }
      }

      

      //페이징 넘버 띄워주는 함수
      function paging_print(paging) {
        if (paging != null) {
          var paging_html = $(".product__pagination");
          paging_html.empty();
          var html = `<ul>
            `;
          if (paging.prevBlockPage != 0) {
            html =
              html +
              `
              <a href="javascript:void(0)" onclick="fn_list(${"${paging.prevBlockPage}"})"><i class="fa fa-angle-double-left"></i></a>
              `;
          }

          for (var i = paging.startPage; i <= paging.endPage; i++) {
            if (paging.curPage != i) {
              html = html + `<a href="javascript:void(0)"  onclick="fn_list(${"${i}"})">${"${i}"}</a>`;
            } else {
              html = html + ` <a class="current-page">${"${i}"}</a>`;
            }
          }
          if (paging.nextBlockPage != 0) {
            html =
              html +
              `
              <a href="javascript:void(0)" onclick="fn_list(${"${paging.nextBlockPage}"})"><i class="fa fa-angle-double-right"></i></a>
              `;
          }

          paging_html.append(html);
        }
      }
      //검색종류 초기화 함수
      function search_reset() {
        check_false();
        $("input[name='main_tag']").prop("checked", false);

        $("#minPrice").val("");

        $("#maxPrice").val("");

        $("input[name='discntCheck']").prop("checked", false);

        $("#action_tag_div").css("display", "none");

        $("#racing_tag_div").css("display", "none");

        $("#fps_tag_div").css("display", "none");

        $("#sim_tag_div").css("display", "none");

        $("#curPage").val(1);

        $("#productName").val("");

        // $("#order_value").option(0);
        // $("#order_value").val("").prop("selected", true);
        $("select[name='order_value'] option:eq(0)").prop("selected", true);
        $(".current").html(" ");
      }

      //메인페이지 이동 함수
      function fn_index()
      {
        location.href = "/index";
      }

      //로그인 페이지 이동 함수
      function fn_login()
      {
        location.href = "/user/login";
      }

      //페이지 이동 함수
      function fn_list(curPage) {
        $("#curPage").val(curPage);
        window.scrollTo(0,0);
        product_ajax();
      }

      //디테일 페이지 이동 함수
      function fn_detail(product_seq)
      {
        const url = "/admin/productDetail?productSeq=" + product_seq;
        var popup = window.open(url, "_blank", 'width=1000, height=1200, scrollbars=yes, resizable =no');

      }
    </script>
    <style>
      body {
        min-height: 100vh;
        max-width: 100%;

        margin: 0 auto;
      }
      /*소분류 기본 none*/
      #action_tag_div,
      #racing_tag_div,
      #fps_tag_div,
      #sim_tag_div {
        display: none;
      }

      h1 {
        color: white;
      }

      input[type="number"]::-webkit-outer-spin-button,
      input[type="number"]::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
      }
      input[type="number"] {
        width: 145px;
      }

      .paging {
        font-size: 25px;
      }
      h5{
        color:blueviolet;
      } 

      .review_rating
      {
        width: 150px;
      }

      .review_rating i 
      {
        width: 20px;
        font-size: 20px;
        color: #e89f12;
        display: inline-block;
      }
      .product-page
    {
      display: flex;
    }
    .store__side
    {
      position: unset;
      margin-right: 250px;
    }
    </style>
  </head>
  <body>
    <%@ include file="/WEB-INF/views/include/navigationAdmin.jsp" %>

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="breadcrumb__links">
              <a href="/index"><i class="fa fa-home"></i> Home</a>
              <a href="/store">스토어</a>
              <span class="main_tag_name"></span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Breadcrumb End -->
    <!-- Product Section Begin -->
    <!-- section class="product-page spad" -->
    <section class="product-page spad">
      <div class="container">
        <div class="row">
          <div class="col-lg-11">
            <div class="product__page__content">
              <div class="product__page__title">
                <div class="row">
                  <div class="col-lg-8 col-md-8 col-sm-6">
                    <div class="section-title">
                      <h4 class="main_tag_name"></h4>
                    </div>
                  </div>
                  <div class="col-lg-4 col-md-4 col-sm-6">
                    <div class="product__page__filter">
                      <p>정렬방법:</p>
                      <select name="product_status" id="product_status">
                        <option value="">상품 상태</option>
                        <option value="N">승인대기</option>
                        <option value="Y">승인완료</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row" id="products"></div>
            </div>
            <div class="product__pagination"></div>
          </div>
        </div>
      </div>
      <div class="store__side">
        <div class="store__search">
          <input type="text" placeholder="제목 검색" id="productName" <c:if test="${productName ne ''}"> value="<c:out value='${productName}'/>"</c:if> />
          <img
            src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"
            id="nameSearch"
          />
          <!-- <span class="icon"><i class="fa fa-search"></i></span> -->
        </div>
        <hr color="#f5f5f5" ; />
        <div class="menu">
          <div class="menu__div" id="li1">
            할인 <input type="checkbox" name="discntCheck" value="Y"/>
          </div>
          <hr color="#f5f5f5" ; />
          <div class="menu__div" id="li2">가격검색</div>
          <ul class="submenu2">
            <li>
              최소 가격<br />
              <input type="number" id="minPrice" />
              <br />
            </li>
            <li>최대 가격 <br /></li>
            <input type="number" id="maxPrice" />
          </ul>
          <hr color="#f5f5f5" ; />
          <div class="menu__div" id="li3">장르</div>
          <ul class="submenu3">
            <li>
              <input
                type="radio"
                name="main_tag"
                class="main_tag"
                value="0100" 
              />액션
            </li>
            <br />
            <div id="action_tag_div">
              <input
                type="checkbox"
                name="action_tag"
                value="0101"
              />1인칭<br />
              <input
                type="checkbox"
                name="action_tag"
                value="0102"
              />3인칭<br />
              <input
                type="checkbox"
                name="action_tag"
                value="0103"
              />판타지<br />
              <input
                type="checkbox"
                name="action_tag"
                value="0104"
              />귀여운<br />
              <input type="checkbox" name="action_tag" value="0105" />픽셀<br />
              <input
                type="checkbox"
                name="action_tag"
                value="0106"
              />탄탄한스토리<br />
              <input
                type="checkbox"
                name="action_tag"
                value="0107"
              />오픈월드<br />
              <input type="checkbox" name="action_tag" value="0108" />공포<br />
              <input
                type="checkbox"
                name="action_tag"
                value="0109"
              />솔로플레이<br />
              <input type="checkbox" name="action_tag" value="0110" />협동<br />
            </div>
            <hr color="#f5f5f5" />
            <li>
              <input
                type="radio"
                name="main_tag"
                class="main_tag"
                value="0200"
              />레이싱
            </li>

            <br />
            <div id="racing_tag_div">
              <input
                type="checkbox"
                name="racing_tag"
                value="0201"
              />1인칭<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0202"
              />3인칭<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0203"
              />판타지<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0204"
              />자유로운트랙<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0205"
              />현실적인<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0206"
              />오토바이<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0207"
              />자동차<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0208"
              />멀티플레이<br />
              <input type="checkbox" name="racing_tag" value="0209" />비행<br />
              <input
                type="checkbox"
                name="racing_tag"
                value="0210"
              />커스터마이징<br />
            </div>
            <hr color="#f5f5f5" />
            <li>
              <input
                type="radio"
                name="main_tag"
                class="main_tag"
                value="0300"
              />FPS
            </li>

            <br />
            <div id="fps_tag_div">
              <input type="checkbox" name="fps_tag" value="0301" />1인칭<br />
              <input type="checkbox" name="fps_tag" value="0302" />3인칭<br />
              <input
                type="checkbox"
                name="fps_tag"
                value="0303"
              />오픈월드<br />
              <input type="checkbox" name="fps_tag" value="0304" />PVP<br />
              <input type="checkbox" name="fps_tag" value="0305" />협동<br />
              <input
                type="checkbox"
                name="fps_tag"
                value="0306"
              />배틀로얄<br />
              <input type="checkbox" name="fps_tag" value="0307" />공포<br />
              <input
                type="checkbox"
                name="fps_tag"
                value="0308"
              />탄탄한스토리<br />
              <input
                type="checkbox"
                name="fps_tag"
                value="0309"
              />솔로플레이<br />
              <input
                type="checkbox"
                name="fps_tag"
                value="0310"
              />사실적인<br />
            </div>
            <hr color="#f5f5f5" />
            <li>
              <input
                type="radio"
                name="main_tag"
                class="main_tag"
                value="0400"
              />시뮬레이션
            </li>

            <br />
            <div id="sim_tag_div">
              <input type="checkbox" name="sim_tag" value="0401" />1인칭<br />
              <input type="checkbox" name="sim_tag" value="0402" />3인칭<br />
              <input type="checkbox" name="sim_tag" value="0403" />스포츠<br />
              <input type="checkbox" name="sim_tag" value="0404" />전략<br />
              <input type="checkbox" name="sim_tag" value="0405" />농장<br />
              <input type="checkbox" name="sim_tag" value="0406" />운전<br />
              <input type="checkbox" name="sim_tag" value="0407" />생활<br />
              <input type="checkbox" name="sim_tag" value="0408" />건설<br />
              <input type="checkbox" name="sim_tag" value="0409" />협동<br />
              <input
                type="checkbox"
                name="sim_tag"
                value="0410"
              />솔로플레이<br />
            </div>
          </ul>
          <hr color="#f5f5f5" ; />
          <div class="menu__div" id="li3">
            <a id="search_reset">초기화</a>
          </div>

          <hr color="#f5f5f5" ; />
        </div>
      </div>
      <input type="hidden" id="curPage" />
    </section>
    <!-- Product Section End -->

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>

    <script>
      $("#li1").click(function () {
        if ($(this).hasClass("active")) {
          $(".submenu1").css("display", "none");
          $(this).removeClass("active");
        } else {
          $(this).addClass("active");
          $(".submenu1").css("display", "block");
        }
      });

      $("#li2").click(function () {
        if ($(this).hasClass("active")) {
          $(".submenu2").css("display", "none");
          $(this).removeClass("active");
        } else {
          $(this).addClass("active");
          $(".submenu2").css("display", "block");
        }
      });

      $("#li3").click(function () {
        if ($(this).hasClass("active")) {
          $(".submenu3").css("display", "none");
          $(this).removeClass("active");
        } else {
          $(this).addClass("active");
          $(".submenu3").css("display", "block");
        }
      });
    </script>
  </body>
</html>
