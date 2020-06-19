<%@ page import="com.homework.model.TeacherHomework" %>
<%@ page import="java.util.List" %>
<%@ page import="com.homework.model.StudentHomework" %><%--
  Created by IntelliJ IDEA.
  User: 22141
  Date: 2020/6/17
  Time: 16:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<StudentHomework> list = (List<StudentHomework>)request.getAttribute("list");
    String userName = (String) request.getAttribute("userName");
%>
<html>
<head>
    <title>作业管理系统-学生</title>
    <% String path = request.getContextPath();%>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header header header-demo" summer>
        <ul class="layui-nav">
            <li class="layui-nav-item"><a href="">作业管理系统-学生</a></li>
        </ul>
    </div>

    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item">
                    <a class="javascript:;" href="http://localhost:8080/student/enter?userName=<%=userName%>">提交作业</a>
                </li>

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="">查看分数</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="layui-tab">
        <div class="layui-body layui-tab-content">
            <div class="layui-tab-item layui-show">
                <div class="layui-main">
                    <div id="LAY_preview">
                        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
                            <legend>待提交作业</legend>
                        </fieldset>

                        <table class="layui-table" align="center" id="table">
                            <tr align="center">
                                <td style="font-size: 20px">作业编号</td>
                                <td style="font-size: 20px">作业题目</td>
                                <td style="font-size: 20px">提交日期</td>
                                <td style="font-size: 20px">分数</td>
                                <td style="font-size: 20px">评语</td>
                            </tr>

                            <%
                                if(list == null || list.size()<=0){
                                    //out.print("No Data");
                                }else{
                                    int index = 1;
                                    for(StudentHomework sh : list){
                                        String max = sh.getScore()==-1?"-":"10";
                                        String score = sh.getScore()==-1?"-":sh.getScore().toString();
                                        String comment = sh.getComment()==null?"-":sh.getComment();
                            %>

                            <tr align="center">
                                <td><%=sh.getKey().getHomeworkId()%></td>
                                <td><%=sh.getHomeworkTitle()%></td>
                                <td><%=sh.getSubmitDate()%></td>
                                <td><%=score%>/<%=max%></td>
                                <td><%=comment%></td>
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
    </div>

    <div class="layui-footer footer footer-demo">
        <div class="layui-main">

        </div>
    </div>

    <div class="site-mobile-shade"></div>
</div>

<script src="<%=path%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','table','layer','element'],function () {
        var $ = layui.jquery;
        var form = layui.form;
        var table = layui.table;
        var layer = layui.layer;
    })
</script>
</body>
</html>
