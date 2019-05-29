<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="title">
    <h3>근태신청서</h3>
</div>
<form id="signForm">
    <div class="selWrap">
        <label for="sel">선택</label>
        <select id="sel">
            <option>휴가신청서</option>
            <option>출장신청서</option>
            <option>훈련신청서</option>
            <option>조퇴신청서</option>
            <option>지각사유서</option>
            <option>시말서</option>
        </select>
        <button type="button" id="insertSign">상신</button>
        <button type="button" class="signMem">결재라인지정</button>
    </div>
    <div class="formWrite">
        <table id="formTable">
            <tr>
                <th>품의번호</th>
                <td colspan="2">(주)누리앱-2019-05-27-SI/SM 3팀-xxxxx</td>
                <th>기안일자</th>
                <td class="today" colspan="2"></td>
            </tr>
            <tr>
                <th>기안부서</th>
                <td colspan="2">
                    <select>
                        <option>SI/SM 3팀</option>
                        <option>SI/SM 2팀</option>
                        <option>SI/SM 1팀</option>
                    </select>
                </td>
                <th>기안자</th>
                <td colspan="2">${memberVO.name}</td>
                <input type="hidden" name="memNum" value="${memberVO.memNum}">
            </tr>
            <tr>
                <th>구분</th>
                <td colspan="5">
                    <select name="selection" id="selection">
                        <option value="연차휴가">연차휴가</option>
                        <option value="월차휴가">월차휴가</option>
                        <option value="병가">병가</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>기 간</th>
                <td colspan="5">
                    <input type="date" id="startDate" class="inputText" name="startDate" value="">
                    <input type="date" id="endDate" class="inputText" name="endDate" value="">
                    <span>[신청 연차</span>
                    <input type="text" id="totalDate" class="inputText" readonly>
                    <span>일]</span>
                </td>
            </tr>
            <tr>
                <th>결재</th>
                <td class="signMemWrap">
                    <input type="text" class="signs" id="sign1" name="sign1" value="" readonly>
                    <input type="hidden" class="signMems" id="signMem1" name="signMem1" value="0">
                </td>
                <td class="signMemWrap">
                    <input type="text" class="signs" id="sign2" name="sign2" value="" readonly>
                    <input type="hidden" class="signMems" id="signMem2" name="signMem2" value="0">
                </td>
                <td class="signMemWrap">
                    <input type="text" class="signs" id="sign3" name="sign3" value=""  readonly>
                    <input type="hidden" class="signMems" id="signMem3" name="signMem3" value="0">
                </td>
                <td class="signMemWrap">
                    <input type="text" class="signs" id="sign4" name="sign4" value=""  readonly>
                    <input type="hidden" class="signMems"  id="signMem4" name="signMem4" value="0">
                </td>
                <td class="signMemWrap">
                    <input type="text" class="signs" id="sign5" name="sign5" value=""  readonly>
                    <input type="hidden" class="signMems" id="signMem5" name="signMem5" value="0">
                </td>
            </tr>
            <tr>
                <th>제 목</th>
                <td colspan="5">
                    <input type="text" name="title" id="docTitle" class="inputText">
                </td>
            </tr>
        </table>
    </div>
    <input type="hidden" id="content" name="content">
    <div id="summernote"></div>
</form>
<script type="text/javascript">

    $(document).ready(function () {

        $('#startDate').val(new Date().format('yyyy-MM-dd'));
        $('.today').html(new Date().format('yyyy-MM-dd'));
        $('#endDate').val(new Date().format('yyyy-MM-dd'));
        $('#totalDate').val(0);

        $('#startDate, #endDate').change(function () {

            var day = 1000 * 60 * 60 * 24;

            var startDate = new Date($('#startDate').val());
            var endDate = new Date($('#endDate').val());
            alert(startDate)
            alert(endDate)
            $('#totalDate').val((endDate-startDate)/day +1);
        });

        //섬머노트 생성
        $('#summernote').summernote({
            height: 350,                 // set editor height
            witdth: 1000,
            minHeight: 300,             // set minimum height of editor
            maxHeight: 800,             // set maximum height of editor
            focus: true,                  // set focus to editable area after initializing summernote
            callbacks: {
                onImageUpload: function (files, editor, welEditable) {
                    for (var i = files.length - 1; i >= 0; i--) {
                        sendFile(files[i], this);
                    }
                }
            }
        });

        //submit
        $('#insertSign').click(function () {

            $('#content').val($('#summernote').summernote('code'));

            var docVO = $('#signForm').serialize();
            $.ajax({
                url: '<%=request.getContextPath()%>/doc/insertDoc',
                data: docVO,
                type: 'POST',
                error: function (error) {
                    alert('입력되지 않은 값이 있습니다!');
                },
                success: function (data) {
                    if (data == '등록 완료!') {
                        alert(data);
                        location.href = '<%=request.getContextPath()%>/doc';
                    } else {
                        alert(data);
                    }
                }
            });

        });

        // 팝업창 띄우기
        $('.signMem, .signMemWrap input').click(function () {

            // 만들 화면 크기
            var X = 700;
            var Y = 500;
/*
            // 화면의 정 중앙으로 팝업 정렬시키기
            // 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
            var popupX = (window.screen.width / 2) - (X / 2);
            // 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
            var popupY = (window.screen.height / 2) - (Y / 2);*/

            // 브라우저의 정 중앙으로 팝업 정렬시키기
            //&nbsp;만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
            var popupX = (document.body.offsetWidth / 2) - (X / 2);
            //&nbsp;만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
            var popupY = (document.body.offsetHeight / 2) - (Y / 2);

            window.open('<%=request.getContextPath()%>/doc/popUp', '결재라인', 'status=no, height='+ Y + ', width=' + X + ', left=' + popupX + ', top=' + popupY);
        });

    });
</script>