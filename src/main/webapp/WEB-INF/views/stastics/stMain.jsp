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
            총 방문자수
        </div>
        <table>
            <tr>
                <td>방문자수</td>
                <td id="totalCount">${totalCount}건</td>
            </tr>
        </table>
    </div>
    <div class="signWrap">
        <div class="head">
            오늘의 방문자수
        </div>
        <table>
            <tr>
                <td>방문자수</td>
                <td id="todayCount">${todayCount}건</td>
            </tr>
        </table>
    </div>
</div>
<div id="bottom">
    <div id="chart">

    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {

        var nowDate = new Date().format('yyyy-MM-dd');

        //차트에 들어갈 데이터 - 컨트롤러에서 JSON 문자열로 받아서 파싱해서 자바스크립트 객체로 변환
        var fifthVisit;

        //ajax로 차트에 사용할 데이터를 가져온다.
        $.ajax({
            url : '<%=request.getContextPath()%>/stastics/chart?nowDate=' + nowDate,
            error : function(error) {
                alert("Error!");
            },
            success : function(data) {
                fifthVisit = JSON.parse(data);
                //차트를 그린다.
                var chart = jui.include("chart.builder");

                chart("#chart", {
                    axis : {
                        x : {
                            type : "fullblock",
                            domain : "visitDate",
                            line : true,
                            textRotate : -30
                        },
                        y : {
                            type : "range",
                            domain : "visitCount",
                            step : 10
                        },
                        data : fifthVisit
                    },
                    brush : [{
                        type : "line",
                        animate : true
                    }, {
                        type : "scatter",
                        hide : true
                    }],
                    widget : [
                        { type : "title", text : "최근 15일간 접속 통계" },
// 			    	{ type : "legend" },
                        { type : "tooltip", brush : 1 }
                    ]
                });
            }
        });

    });
</script>