<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Store eGame : 로그인</title>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- Normal Breadcrumb Begin -->
<section class="normal-breadcrumb set-bg" data-setbg="/resources/img_html/normal-breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="normal__breadcrumb__text">
                    <h2>로그인</h2>
                    <p>Welcome to the official Game store</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Normal Breadcrumb End -->

<!-- Login Section Begin -->
<section class="login spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="login__form">
                    <h3>로그인</h3>
                    <form action="#">
                        <div class="input__item">
                            <input type="text" placeholder="아이디">
                            <span class="icon_profile"></span>
                        </div>
                        <div class="input__item">
                            <input type="password" placeholder="비밀번호">
                            <span class="icon_lock"></span>
                        </div>
                        <button type="submit" class="site-btn">로그인</button>
                    </form>
                    <!-- <a href="#" class="forget_pass">비밀번호 찾기</a> -->
                </div>
            </div>
            <div class="col-lg-6">
                <div class="login__register">
                    <h3>회원가입 하시겠습니까?</h3>
                    <a href="/user/signUp" class="primary-btn">회원가입</a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Login Section End -->

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>