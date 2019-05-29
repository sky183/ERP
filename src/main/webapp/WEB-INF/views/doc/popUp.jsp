<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>title</title>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <style>
        * {
            font-size: 12px;
            font-family: Arial;
        }

        button {
            cursor: pointer;
        }

        input[type="checkbox"] {
            cursor: pointer;
        }

        #wrap {
            margin: 3px;
        }

        .title {
            height: 30px;
            line-height: 30px;
            background-color: #666666;
            padding: 5px;
        }

        .title span {
            font-size: 13px;
            font-weight: bold;
            color: #ffffff;
            float: left;
        }

        .selectWrap {
            margin-top: 10px;
            background-color: #d5d5d5;
            padding: 5px;
        }

        .close {
            font-size: 11px;
            font-weight: bold;
            color: #ffffff;
            background: none;
            border: none;
            float: right;
            cursor: pointer;
        }

        .memberView {
            margin-top: 10px;
        }

        .checkMember {
            height: 200px;
            overflow: auto;
            border: 1px solid #aaaaaa !important;
        }

        #memTable {
            width: 100%;
            margin-top: 10px;
        }

        #memTable, #memTable * {
            border: 1px solid #aaaaaa;
            border-spacing: 0;
            border-collapse: collapse;
            text-align: center;
            font-size: 12px;
            font-family: Arial;
        }

        #signMem {
            float: right;
            margin-right: 20px;
        }

        #memTable th {
            background-color: #d5d5d5;
            padding: 5px;
            height: 30px;
        }

        #memTable tr {
            height: 25px;
        }

        #memTable th:first-child {
            width: 40px;
        }

        #memTable th:nth-child(2) {
            width: 150px;
        }

        #memTable th:nth-child(3) {
            width: 190px;
        }

        .memList {
            width: 100%;
            height: 150px;
            margin-top: 5px;
        }
        .memLabel {
            border: none !important;
            width: 48px;
            height: 22px;
            position: absolute;
            margin-left: -14px;
            margin-top: -1px;
            cursor: pointer;
        }


    </style>
</head>
<body>
<div id="wrap">
    <div class="title">
        <span>결재라인지정</span>
        <button tyep="button" class="close">닫기</button>
    </div>
    <div class="bottom">
        <div class="selectWrap">
            <label for="selMem">사원명</label>
            <input type="text" id="selMem" name="selMem" value="">
            <button type="button" id="selectMember">
                검색
            </button>
            <button type="button" id="signMem">
                결재라인 적용하기
            </button>
        </div>
        <div class="checkMember">
            <table id="memTable">
                <tr>
                    <th>
                        <label for="all-check" class="memLabel"></label>
                        <input type="checkbox" id="all-check" class="all-check">
                    </th>
                    <th class="company">회사</th>
                    <th class="name">사원명</th>
                    <th class="titleNum">직급</th>
                </tr>
                <c:choose>
                    <c:when test="${memberVOList.isEmpty()}">

                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${memberVOList}" var="memberVO">
                            <tr>
                                <td>
                                    <label for="${memberVO.memNum}" class="memLabel"></label>
                                    <input type="checkbox" class="checkMemNum" name="checkMemNum"
                                           value="${memberVO.name}"
                                           id="${memberVO.memNum}">
                                </td>
                                <td class="company">(주)누리앱</td>
                                <td class="name">${memberVO.name}</td>
                                <td class="titleNum">${memberVO.title}</td>

                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </table>
        </div>
        <div class="memberView">
            <span>결재자</span>
            <button type="button" id="moveMember">
                결재
            </button>
            <div>
                <select name="memList[]" class="memList" multiple>

                </select>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function () {

        //all-check를 클릭하면 모든 check가 클릭된다.
        $(".all-check").change(function () {
            $('.checkMemNum').prop('checked', $(this).prop("checked"));
        });

        // 창닫기
        $('.close').click(function () {
            window.close();
        });

        //선택한 회원을 결재라인으로 옮김
        $('#signMem').off('click').on('click', function () {
            signMem();
        })

        // 결재자 등록
        $('#moveMember').off('click').click(function () {

            moveMember();

        });

        // 멤버 검색
        $('#selectMember').click(function () {

            if ($('#selMem').val() != null && $('#selMem').val() != '') {

                var name = $('#selMem').val();

                $.ajax({
                    url: '<%=request.getContextPath()%>/doc/selectMember?name=' + name,
                    method: 'GET',
                    error: function (error) {
                        alert('Error!');
                    },
                    success: function (data) {

                        $('#memTable').html('');

                        $('#memTable').html('<tr>\n' +
                            '<th><input type="checkbox"></th>\n' +
                            '<th class="company">회사</th>\n' +
                            '<th class="name">사원명</th>\n' +
                            '<th class="titleNum">직급</th>\n' +
                            '</tr>' + '<tr>\n' +
                            '<td><input type="checkbox" name="checkMemNum" id="' + data.memNum + '" value="' + data.name + '">\n' +
                            '<td class="company">(주)누리앱</td>\n' +
                            '<td class="name">' + data.name + '</td>\n' +
                            '<td class="titleNum">' + data.title + '</td>\n' +
                            '</td>\n' +
                            ' </tr>'
                        );
                    }
                });
            } else {
                alert('검색할 사원명을 입력하세요!');
            }
        });

        function signMem() {

            //선택한 항목을 배열로 만들어준다.
            var memberlength = $("input[name='checkMemNum']:checked").length;

            if (memberlength > 0) {
                var memNumArray = new Array(memberlength);
                var nameArray = new Array(memberlength);

                for (var i = 0; i < memberlength; i++) {

                    memNumArray[i] = $("input[name='checkMemNum']:checked")[i].id;
                    nameArray[i] = $("input[name='checkMemNum']:checked")[i].value;

                    $('.memList').append('<option value="' + memNumArray[i]
                        + '">' + nameArray[i] + '</option>');
                }
            } else {
                alert("선택된 회원이 없습니다.");
            }

        }

        function moveMember() {

            var memListLength = $('.memList option').length;

            $(opener.document).find(".signs").attr('value', '');
            $(opener.document).find(".signMems").attr('value', 0);


            if (memListLength > 0) {

                for (var i = 0; i < memListLength; i++) {

                    switch (i) {
                        case 0:
                            var memNum = $('.memList option')[i].value;
                            var name = $('.memList option')[i].text;
                            $(opener.document).find("#sign1").attr('value', name);
                            $(opener.document).find("#signMem1").attr('value', memNum);
                            break;
                        case 1:
                            var memNum = $('.memList option')[i].value;
                            var name = $('.memList option')[i].text;
                            $(opener.document).find("#sign2").attr('value', name);
                            $(opener.document).find("#signMem2").attr('value', memNum);
                            break;
                        case 2:
                            var memNum = $('.memList option')[i].value;
                            var name = $('.memList option')[i].text;
                            $(opener.document).find("#sign3").attr('value', name);
                            $(opener.document).find("#signMem3").attr('value', memNum);
                            break;
                        case 3:
                            var memNum = $('.memList option')[i].value;
                            var name = $('.memList option')[i].text;
                            $(opener.document).find("#sign4").attr('value', name);
                            $(opener.document).find("#signMem4").attr('value', memNum);
                            break;
                        case 4:
                            var memNum = $('.memList option')[i].value;
                            var name = $('.memList option')[i].text;
                            $(opener.document).find("#sign5").attr('value', name);
                            $(opener.document).find("#signMem5").attr('value', memNum);
                            break;
                        default:
                            break;
                    }
                }

            } else {
                alert('선택된 회원이 없습니다.')
            }
            window.close();
        }


    })
</script>