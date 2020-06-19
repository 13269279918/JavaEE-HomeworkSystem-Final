<%@ page import="com.homework.model.StudentHomework" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 22141
  Date: 2020/6/17
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
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
                <li class="layui-nav-item">
                    <a class="javascript:;" href="http://localhost:8080/teacher/enter?userName=<%=userName%>">批改作业</a>
                </li>

                <li class="layui-nav-item layui-nav-itemed">
                    <a class="javascript:;" href="">发布作业</a>
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
                            <legend>发布作业</legend>
                        </fieldset>

                        <div style="padding: 10px;">
                            <form class="layui-form">
                                <div class="layui-form-item">
                                    <fieldset class="layui-field-title" >
                                        <legend>作业标题</legend>
                                        <input type="text" class="layui-input"  required  lay-verify="required" autocomplete="off"
                                               id="HomeworkTitle" placeholder="请输入：作业题目">
                                    </fieldset>
                                </div>

                                <div class="layui-form-item layui-form-text">
                                    <fieldset class="layui-field-title">
                                        <legend>作业要求</legend>
                                        <textarea type="text" class="layui-textarea"  required lay-verify="required"  style="height: 300px;"
                                                  id="HomeworkContent" placeholder="请输入内容，现仅支持文本，200字内"></textarea>
                                    </fieldset>
                                </div>

                                <div class="layui-form-item layui-form-text">
                                    <fieldset class="layui-field-title">
                                        <legend>截止时间</legend>
                                        <input type="text" class="layui-input" id="Deadline" autocomplete="off" placeholder="单击选择截止日期">
                                    </fieldset>
                                </div>

                                <div class="layui-form-item">
                                    <div class="layui-input-block">
                                        <button type="button" class="layui-btn" id="publish" style="width: 1000px">发布</button>
                                    </div>
                                </div>

                            </form>
                        </div>
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
    layui.use(['jquery','form','layer','laydate','element'],function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var laydate = layui.laydate;
        var index;
        var element = layui.element;
        var userName = '<%=userName%>';

        laydate.render({
            elem : '#Deadline',
            trigger : 'click'
        });

        $("#publish").click(function () {
            var title = $("#HomeworkTitle").val();
            var requirement = $("#HomeworkContent").val();
            var deadline = $("#Deadline").val();

            if(title==""){
                layer.msg("请输入作业标题");
            }else{
                if(requirement==""){
                    layer.msg("请输入作业要求");
                }else{
                    if(deadline==""){
                        layer.msg("请输入截止日期");
                    }else{
                        var deadline_date = new Date(deadline.replace(/\-/g, "\/"));
                        var today = new Date();
                        if(deadline_date<=today){
                            layer.msg("截止日期设置错误!");
                        }else{
                            var date = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();
                            $.ajax({
                                url:"http://localhost:8080/teacher/publish",
                                data:{
                                    'teacherName' : userName,
                                    'title' : title,
                                    'requirement' : requirement,
                                    'publishDate' : date,
                                    'deadline' : deadline
                                },
                                type : "POST",
                                success:function () {
                                    layer.msg("发布成功,即将跳转",{icon: 1});
                                    var command = "location.href='http://localhost:8080/teacher/enter?userName="+userName+"'";
                                    setTimeout(command,500);
                                }
                            });
                        }
                    }
                }
            }
        })
    })
</script>
</body>
</html>
