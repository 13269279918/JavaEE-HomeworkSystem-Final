<%@ page import="java.util.List" %>
<%@ page import="com.sun.xml.internal.bind.v2.model.core.ID" %>
<%@ page import="com.homework.model.TeacherHomework" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: 22141
  Date: 2020/3/10
  Time: 19:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<TeacherHomework> list = (List<TeacherHomework>)request.getAttribute("list");
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
                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="">提交作业</a>
                </li>

                <li class="layui-nav-item">
                    <a class="javascript:;" href="http://localhost:8080/student/checkScore?userName=<%=userName%>">查看分数</a>
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
                                <td style="font-size: 20px">发布日期</td>
                                <td style="font-size: 20px">截止日期</td>
                                <td style="font-size: 20px">进行操作</td>
                            </tr>

                            <%
                                if(list == null || list.size()<=0){
                                    //out.print("No Data");
                                }else{
                                    int index = 1;
                                    for(TeacherHomework th : list){
                            %>

                            <tr align="center">
                                <td><%=th.getHomeworkId()%></td>
                                <td><%=th.getHomeworkTitle()%></td>
                                <td><%=th.getPublishDate()%></td>
                                <td><%=th.getDeadline()%></td>
                                <td align="center">
                                    <button type="button" class="layui-btn layui-btn-sm detail" id="<%="btn_d"+index%>">要求</button>
                                    <%
                                        Date deadline = th.getDeadline();
                                        Date today = new Date();
                                        if(deadline.after(today) || deadline.equals(today)){
                                    %>
                                    <button type="button" class="layui-btn layui-btn-sm submit" id="<%="btn_s"+index%>">提交</button>
                                    <%}%>
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
    </div>

    <div class="layui-footer footer footer-demo">
        <div class="layui-main">

        </div>
    </div>

    <div class="site-mobile-shade"></div>
</div>

<div id="div-submit" style="display: none; padding: 10px;" >
    <form class="layui-form">
        <div class="layui-form-item">
            <fieldset class="layui-field-title" >
                <legend>作业标题</legend>
                <input type="text" class="layui-input"  required  lay-verify="required" autocomplete="off"
                       id="HomeworkTitle" placeholder="请输入：作业题目-学号-姓名">
            </fieldset>
        </div>

        <div class="layui-form-item layui-form-text">
            <fieldset class="layui-field-title">
                <legend>作业内容</legend>
                <textarea type="text" class="layui-textarea"  required lay-verify="required"  style="height: 400px;"
                          id="HomeworkContent" placeholder="请输入内容，现仅支持文本，1000字内"></textarea>
            </fieldset>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="button" class="layui-btn" id="layer-submit">提交</button>
                <button type="button" class="layui-btn layui-btn-primary" id="layer-cancel">返回</button>
            </div>
        </div>

    </form>
</div>

<script src="<%=path%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery','form','layer','laydate','element'],function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var index;
        var homeworkId;
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
                url:"http://localhost:8080/student/requirement",
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

        $(".submit").click(function () {
            var rowNumber = this.id.slice(5);
            var tb = document.getElementById("table");
            var rows = tb.rows;

            for(var i=1;i<rows.length;i++){
                if(i!=rowNumber)
                    continue;
                var cells = rows[i].cells;
                homeworkId = cells[0].innerHTML;
            }

            index = layer.open({
                type : 1,
                title : "提交作业",
                content : $("#div-submit"),
                anim : 2,
                area : '450px'
            })
        })

        $("#layer-cancel").click(function () {
            layer.close(index)
        })

        $("#layer-submit").click(function () {
            var title = $("#HomeworkTitle").val();
            var content = $("#HomeworkContent").val();
            var today = new Date();
            var date = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();

            $.ajax({
                url:"http://localhost:8080/student/submit",
                async:false,
                data:{
                    'homeworkId' : homeworkId,
                    'studentName' : userName,
                    'homeworkTitle' : title,
                    'homeworkContent' : content,
                    'submitDate' : date
                },
                type : "POST",
                dataType:"json",
                success:function () {
                    layer.msg("提交成功",{icon:1});
                }
            });

            layer.close(index);
            location.href = "http://localhost:8080/student/enter?userName="+userName;
        })

    })
</script>
</body>
</html>