<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    #formTable td {
        text-align: center;
    }

    #formTable tr th:first-child, #formTable tr td:first-child {
        width: 20px;
    }

    #formTable tr th:nth-child(2), #formTable tr td:nth-child(1) {
        width: 40px;
    }

    #formTable tr th:nth-child(3), #formTable tr td:nth-child(3) {
        width: 120px;
    }

    #formTable tr th:nth-child(4), #formTable tr td:nth-child(4) {
        width: 40px;
    }

    #formTable tr th:nth-child(5), #formTable tr td:nth-child(5) {
        width: 80px;
    }
</style>
<div id="title">
    <h3>결재 완료 문서</h3>
</div>
<div class="selWrap">
</div>
<div class="formWrite">
    <table id="formTable">
        <tr>
            <th><input type="checkbox" class="all-check"></th>
            <th>문서번호</th>
            <th>제목</th>
            <th>문서등급</th>
            <th>기안자</th>
            <th>기안일자</th>
        </tr>
        <c:choose>
            <c:when test="${!empty docVOList}">
                <c:forEach items="${docVOList}" var="docVO">
                    <fmt:parseDate value="${docVO.startDate}" var="startDate" pattern="yyyy-MM-dd"/>
                    <tr>
                        <td><input type="checkbox" class="docNum" name="docNum" value="${docVO.docNum}"></td>
                        <td>${docVO.docNum}</td>
                        <td>${docVO.title}</td>
                        <td>${docVO.level}</td>
                        <td>${docVO.name}</td>
                        <td><fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="6">
                        결재 완료된 문서가 없습니다.
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
    </table>
</div>
<script type="text/javascript">

    $(document).ready(function () {

    })
    ;
</script>