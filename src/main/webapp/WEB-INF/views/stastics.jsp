<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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

    <!-- 섬머노트 css/js-->
    <!-- include libraries(jQuery, bootstrap) -->
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.4/jquery.js"></script>
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.3/summernote.css" rel="stylesheet">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.3/summernote.js"></script>

    <!-- Basic style components -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jui/jui/dist/ui.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jui/jui/dist/ui-jennifer.min.css" />

    <!-- Grid style components -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jui/jui-grid/dist/grid.min.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/jui/jui-grid/dist/grid-jennifer.min.css" />
    <!-- Required script files -->
    <script src="<%=request.getContextPath()%>/resources/jui/jui/lib/jquery-1.8.0.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/jui/jui-core/dist/core.min.js"></script>

    <!-- Basic script components -->
    <script src="<%=request.getContextPath()%>/resources/jui/jui/dist/ui.min.js"></script>

    <!-- Grid script components -->
    <script src="<%=request.getContextPath()%>/resources/jui/jui-grid/dist/grid.min.js"></script>

    <script src="<%=request.getContextPath()%>/resources/jui/jui-core/dist/core.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/jui/jui-chart/dist/chart.js"></script>
    <script>
        //3자리수마다 콤마 찍어주는 함수
        function comma(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        //콤마풀고 Number로 변환
        function uncomma(str) {
            str = String(str);
            return Number(str.replace(/[^\d]+/g, ''));
        }

        //date포맷 함수
        String.prototype.string = function (len) {
            var s = '', i = 0;
            while (i++ < len) {
                s += this;
            }
            return s;
        };
        String.prototype.zf = function (len) {
            return "0".string(len - this.length) + this;
        };
        Number.prototype.zf = function (len) {
            return this.toString().zf(len);
        };

        Date.prototype.format = function (f) {
            if (!this.valueOf()) return " ";

            var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
            var d = this;

            return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function ($1) {
                switch ($1) {
                    case "yyyy":
                        return d.getFullYear();
                    case "yy":
                        return (d.getFullYear() % 1000).zf(2);
                    case "MM":
                        return (d.getMonth() + 1).zf(2);
                    case "dd":
                        return d.getDate().zf(2);
                    case "E":
                        return weekName[d.getDay()];
                    case "HH":
                        return d.getHours().zf(2);
                    case "hh":
                        return ((h = d.getHours() % 12) ? h : 12).zf(2);
                    case "mm":
                        return d.getMinutes().zf(2);
                    case "ss":
                        return d.getSeconds().zf(2);
                    case "a/p":
                        return d.getHours() < 12 ? "오전" : "오후";
                    default:
                        return $1;
                }
            });
        };

        // 두개의 날짜를 비교하여 차이를 알려준다.
        function dateDiff(_date1, _date2) {
            var diffDate_1 = _date1 instanceof Date ? _date1 : new Date(_date1);
            var diffDate_2 = _date2 instanceof Date ? _date2 : new Date(_date2);

            diffDate_1 = new Date(diffDate_1.getFullYear(), diffDate_1.getMonth() + 1, diffDate_1.getDate());
            diffDate_2 = new Date(diffDate_2.getFullYear(), diffDate_2.getMonth() + 1, diffDate_2.getDate());

            var diff = Math.abs(diffDate_2.getTime() - diffDate_1.getTime());
            diff = Math.ceil(diff / (1000 * 3600 * 24));

            return diff;
        }


    </script>
</head>
<body>
<%@ include file="include/menu.jsp" %>
<div id="wrap">
    <div id="stLeftWrap">
        <div class="menuWrap">
            <div class="title">
                <img src="<%=request.getContextPath()%>/img/left_top01.gif" alt="전자결재">
            </div>
            <ul>
                <li class="head"><a>방문자수 통계</a></li>
            </ul>
        </div>
    </div>
    <div id="stRightWrap">

    </div>
</div>
</body>
</html>
<script>
    $(document).ready(function () {

        $('.stastics').addClass('active');

        $.ajax({
            url: '<%=request.getContextPath()%>/stastics/stMain',
            method: 'GET',
            error: function (error) {
                alert('Error!');
            },
            success: function (data) {

                $('#stRightWrap').html(data);
            }

        });
    });
</script>
