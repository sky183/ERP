<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>title</title>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css">
    <title>로그인</title>
</head>
<body id="loginWrapper">
<div>
    <form method="post">
        <div id="loginBox">
            <div id="topBox">
                통합 관리자 로그인
            </div>
            <input type="text" id="id" name="id">
            <input type="password" id="pw" name="pw">
            <button id="login">로그인</button>
            <div class="checkWrap">
                <input type="checkbox" id="rememberId" name="rememberId">
                <label for="rememberId">아이디 저장</label>
                <span class="error">${error}</span>
            </div>

        </div>
    </form>

</div>
</body>
<script type="text/javascript">

    $(document).ready(function () {

        $('input[type="text"], input[type="password"]').keyup(function () {

            //엔터 쳤을때
            if (event.keyCode === 13) {
                //엔터의 기본 기능 없애기
                event.preventDefault();
                // 엔터를 쳤을때 로그인 버튼 클릭되게끔
                $('#login').trigger('click');
            }

        });

        var login_id = $.cookie('idcookie');
        if (login_id !== undefined) {
            //아이디에 쿠키값을 담는다.
            $('#id').val(login_id);
            //아이디 저장 체크박스한다.
            $('#rememberId').prop('checked', true);
        }
        // 로그인 버튼 클릭시
        $('#login').click(function () {
            //아이디 미입력시
            if ($.trim($('#id').val()) === "") {
                alert('아이디를 입력해주세요');
                return;
            } else {
                // 아이디저장 체크돼있으면 쿠키저장
                if (!($('rememberId').prop('checked'))) {
                    $.removeCookie('idcookie');
                }

                $('loginForm').submit();
            }

        });


    })

</script>
</html>

