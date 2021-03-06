<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<div class="docMenuNavi">
    <ul class="navTop">
        <li class="title">(주)누리앱</li>
        <li class="logOut"><a href="<%=request.getContextPath()%>/logOut">로그아웃</a></li>
        <li class="myName">${memberVO.name}님</li>
    </ul>
    <ul class="navBottom">
        <li class="left"></li>
        <li class="doc"><a id="doc" class="link">전자결재</a></li>
        <li><a>웹메일</a></li>
        <li><a>인사관리</a></li>
        <li><a>조직도</a></li>
        <li class="stastics"><a id="stastics" class="link">통계관리</a></li>
    </ul>
</div>
<script type="text/javascript">
    $(document).ready(function () {

        $('.link').click(function() {

            var page = $(this).attr('id');

            location.href = '<%=request.getContextPath()%>/' + page
        });
    });

</script>

