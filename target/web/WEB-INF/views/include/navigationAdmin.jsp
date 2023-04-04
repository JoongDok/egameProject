<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Page Preloder -->
<!-- <div id="preloder">
  <div class="loader"></div>
</div> -->

<!-- Header Section Begin -->
<header class="header">
  <div class="container">
    <div class="row">
      <div class="col-lg-2">
        <div class="header__logo">
          <a href="/index">
            <img src="/resources/icon/logo.png" alt="" />
          </a>
        </div>
      </div>
      <div class="col-lg-8">
        <div class="header__nav">
          <nav class="header__menu mobile-menu">
            <ul>
              <li><a href="/admin/index">유저관리</a></li>
              <li>
                <a href="/admin/product"
                  >상품관리</span
                ></a>
              </li>
              <li><a href="/admin/discnt">할인관리</a></li>
              <li><a href="/board/reportList">신고관리</a></li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
</header>
<!-- Header End -->
