<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="ko">

<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<title>Store eGame : 회원정보수정</title>
</head>

<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!-- Normal Breadcrumb Begin -->
<section class="normal-breadcrumb set-bg" data-setbg="/resources/img_html/normal-breadcrumb.jpg">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="normal__breadcrumb__text">
                    <h2>회원정보수정</h2>
                    <p>Welcome to the official Game blog.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Normal Breadcrumb End -->

<!-- Signup Section Begin -->
<section class="signup spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="login__form user_update_form" style="padding-left: 370px;">
                    <h3>회원정보수정</h3>
                    <form action="/user/updateProc">
                        <div class="input__item">
                            <input type="text" placeholder="아이디" disabled>
                            <span class="icon_profile"></span>
                        </div>
                        <div class="input__item">
                            <input type="password" placeholder="비밀번호">
                            <span class="icon_lock"></span>
                        </div>
                        <div class="input__item">
                            <input type="password" placeholder="비밀번호 확인">
                            <span class="icon_lock"></span>
                        </div>
                        <div class="input__item">
                            <input type="text" placeholder="이름">
                            <span class="icon_profile"></span>
                        </div>
                        <div class="input__item">
                            <input type="text" placeholder="닉네임">
                            <span class="icon_profile"></span>
                        </div>
                        <div class="input__item">
                            <input type="text" placeholder="이메일">
                            <span class="icon_mail"></span>
                        </div>
                        <div>
                            <input type="checkbox" name="reg_select" />
                            <span style="color: rgb(180, 179, 179);">상품을 판매합니까?</span>
                            <span style="color: rgb(181, 5, 5);">예</span>
                        </div>
                        <div class="input__item">
                            <label style="position: relative;">
                                <input type="text" placeholder="사업자등록번호" style="width: 370px;">
                                <span class="icon_lock"></span>
                                <!-- <button type="button" style="position: absolute; right: 5px; border-radius: 5px; border: none; background-color: #212483; color: white;">인증하기</button> -->
                            </label>
                        </div>
                        
                        <button type="submit" class="site-btn">회원정보수정</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Signup Section End -->

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>