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
    <h3>결재 대기 문서</h3>
</div>
<div class="selWrap">
    <button type="button" id="docSign">결재</button>
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
                        결재할 문서가 없습니다.
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
    </table>
</div>
<script type="text/javascript">

    $(document).ready(function () {

        //all-check를 클릭하면 모든 check가 클릭된다.
        $(".all-check").change(function () {
            $('.docNum').prop('checked', $(this).prop("checked"));
        });

        //선택한 문서를 결재처리
        $('#docSign').off('click').on('click', function () {

            //선택한 항목의 배열의 갯수
            var docLength = $("input[name='docNum']:checked").length;


            if (docLength > 0) {
                // 문서번호를 담을 배열
                var docArray = new Array(docLength);

                for (var i = 0; i < docLength; i++) {
                    // 문서 번호를 담는다.
                    docArray[i] = $("input[name='docNum']:checked")[i].value;
                }

                // 결재
                $.ajax({
                    url: '<%=request.getContextPath()%>/doc/updateLevel',
                    method: 'POST',
                    type: 'json',
                    data: JSON.stringify(docArray),
                    contentType: "application/json",
                    error: function (error) {
                        alert('Error!');
                    },
                    success: function (data) {
                        if (data == '결재 완료!') {
                            alert(data);
                            location.href = '<%=request.getContextPath()%>/doc';
                        } else {
                            alert(data);
                        }
                    }
                });

            } else {
                alert("선택된 문서가 없습니다.");
            }
        });


    })
    ;
</script>