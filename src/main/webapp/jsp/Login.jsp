<%--
  Created by IntelliJ IDEA.
  User: 22141
  Date: 2020/3/9
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
    <% String path = request.getContextPath();%>
    <link rel="stylesheet" type="text/css" href="<%=path%>/layui/css/layui.css">

    <style type="text/css">
        .container{
            width: 420px;
            height: 200px;
            position: absolute;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
            margin: auto;
            padding: 20px;
            z-index: 130;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 3px 18px rgba(100, 0, 0, .5);
            font-size: 16px;
        }

    </style>
</head>
<body>

<div style="text-align: center;margin-top: 200px;font-size: 30px"> 作 业 系 统 </div>
    <div class="container">
        <fieldset class="layui-elem-field" >
            <legend>欢迎</legend>
            <form class="layui-form" action="">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block" style="margin-right: 4px">
                        <input type="text" id="userName" required maxlength="40" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block" style="margin-right: 4px">
                        <input type="password" id="password" required maxlength="20" lay-verify="required" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </form>
        </fieldset>
        <div align="center">
            <div class="layui-inline">
                <button type="button" class="layui-btn layui-btn-radius layui-btn-warm" style="width:150px; margin: 5px" id="login">登录</button>
                <button type="button" class="layui-btn layui-btn-radius layui-btn-normal" style="width:150px; margin: 5px" id="register">注册</button>
            </div>
        </div>
    </div>


<script src="<%=path%>/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['element','jquery','form'],function () {
        var $ = layui.jquery;
        var element = layui.element;
        var form = layui.form;

        $("#login").click(function () {
            var userName = $("#userName").val();
            var password = $("#password").val();

            if(userName==""){
                layer.msg("请输入用户名");
            }else{
                if(password==""){
                    layer.msg("请输入密码");
                }else{
                    $.ajax({
                        url:"http://localhost:8080/user/login",
                        async:false,
                        data:{
                            'ID': userName,
                            'Password':password
                        },
                        type:'GET',
                        dataType:'text',
                        success:function (result) {
                            if(result == "student"){
                                layer.msg("登录成功，同学你好！",{icon: 1});
                                var command = "location.href='http://localhost:8080/student/enter?userName="+userName+"'";
                                setTimeout(command, 1000);
                            }else if(result == "teacher"){
                                layer.msg("登录成功，老师你好！",{icon: 1});
                                var command = "location.href='http://localhost:8080/teacher/enter?userName="+userName+"'";
                                setTimeout(command, 1000);
                            }else if(result == "wrong"){
                                layer.msg("用户名不存在或密码错误");
                            }
                        }
                    })
                }
            }
        })

        $("#register").click(function () {
            window.location.href='../jsp/Register.jsp';
        })
    })
</script>
</body>
</html>
