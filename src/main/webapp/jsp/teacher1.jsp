<%@ page import="java.util.List" %>
<%@ page import="com.homework.model.TeacherHomework" %>
<%--
  Created by IntelliJ IDEA.
  User: 22141
  Date: 2020/3/10
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%
    List<TeacherHomework> list = (List<TeacherHomework>)request.getAttribute("list");
    String userName = (String) request.getAttribute("userName");
%>
<html>
<head>
    <title>作业管理系统-教师</title>
    <% String path = request.getContextPath();%>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header header header-demo" summer>
        <ul class="layui-nav">
            <li class="layui-nav-item"><a href="">作业管理系统-教师</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="">批改作业</a>
                </li>

                <li class="layui-nav-item">
                    <a class="javascript:;" href="http://localhost:8080/teacher/start_publish?userName=<%=userName%>" >发布作业</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-tab">
        <div class="layui-body layui-tab-content">
            <div class="layui-tab-item layui-show">
                <div class="layui-main">
                    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                        <legend>查阅作业</legend>
                    </fieldset>

                    <table class="layui-table" align="center" id="table">
                            <tr align="center">
                                <td style="font-size: 20px">作业编号</td>
                                <td style="font-size: 20px">作业题目</td>
                                <td style="font-size: 20px">发布日期</td>
                                <td style="font-size: 20px">截止日期</td>
                                <td style="font-size: 20px">进行操作</td>
                            </tr>

                            <%

                                if(list == null || list.size()<=0){
                                    //out.print("No Data");
                                }else{
                                    int index = 1;
                                    for(TeacherHomework sh : list){
                            %>

                            <tr align="center">
                                <td><%=sh.getHomeworkId()%></td>
                                <td><%=sh.getHomeworkTitle()%></td>
                                <td><%=sh.getPublishDate()%></td>
                                <td><%=sh.getDeadline()%></td>
                                <td align="center">
                                    <button type="button" class="layui-btn layui-btn-sm detail" id="<%="btn_d"+index%>">要求</button>
                                    <button type="button" class="layui-btn layui-btn-sm check" id="<%="btn_c"+index%>">批阅</button>
                                    <button type="button" class="layui-btn layui-btn-sm statistic" id="<%="btn_s"+index%>">统计</button>
                                </td>
                            </tr>
                            <%
                                        index++;
                                    }
                                }%>

                        </table>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-footer footer footer-demo">
        <div class="layui-main">

        </div>
    </div>

    <div class="site-mobile-shade"></div>
</div>

<script src="<%=path%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','layer','laydate','element'],function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var userName = '<%=userName%>';


        $(".detail").click(function () {
            var rowNumber = this.id.slice(5);
            var tb = document.getElementById("table");
            var rows = tb.rows;
            var homeworkId;

            for(var i=1;i<rows.length;i++){
                if(i!=rowNumber)
                    continue;
                else{
                    var cells = rows[i].cells;
                    homeworkId = cells[0].innerHTML;
                }
            }

            $.ajax({
                url:"http://localhost:8080/teacher/requirement",
                async:false,
                data:{
                    'homeworkId': homeworkId
                },
                type:'GET',
                dataType:'text',
                success:function (result) {
                    layer.open({
                        type:0,
                        title:"作业要求",
                        content:result,
                        anim:2
                    })
                }
            })
        })

        $(".check").click(function () {
            var rowNumber = this.id.slice(5);
            var tb = document.getElementById("table");
            var rows = tb.rows;
            var homeworkId;

            for(var i=1;i<rows.length;i++){
                if(i!=rowNumber)
                    continue;
                else{
                    var cells = rows[i].cells;
                    homeworkId = cells[0].innerHTML;
                }
            }

            location.href = "http://localhost:8080/teacher/check?homeworkId="+homeworkId+"&studentName="+userName;
        })

        $(".statistic").click(function () {
            var rowNumber = this.id.slice(5);
            var tb = document.getElementById("table");
            var rows = tb.rows;
            var homeworkId;

            for(var i=1;i<rows.length;i++){
                if(i!=rowNumber)
                    continue;
                else{
                    var cells = rows[i].cells;
                    homeworkId = cells[0].innerHTML;
                }
            }

            $.ajax({
                url:"http://localhost:8080/teacher/statistic",
                async:false,
                data:{
                    'homeworkId': homeworkId
                },
                type:'GET',
                dataType:'text',
                success:function (result) {
                    layer.open({
                        type:0,
                        title:"作业信息统计",
                        content:result,
                        anim:2
                    })
                }
            })
        })

    })
</script>
</body>
</html>