<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<div class="top">
    <div class="signWrap">
        <div class="head">
            내가 받은 결재
        </div>
        <table>
            <tr>
                <td>미결재 문서</td>
                <td id="mySignBefore">${mySignBeforeCount}건</td>
            </tr>
            <tr>
                <td>결재완료 문서</td>
                <td id="mySignAfter">${mySignAfterCount}건</td>
            </tr>
        </table>
    </div>
    <div class="signWrap">
        <div class="head">
            내가 올린 결재
        </div>
        <table>
            <tr>
                <td>미결재 문서</td>
                <td id="signBefore">${signBeforeCount}건</td>
            </tr>
            <tr>
                <td>결재완료 문서</td>
                <td id="signAfter">${signAfterCount}건</td>
            </tr>
        </table>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {


    });
</script>