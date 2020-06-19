<%@ page import="com.homework.model.StudentHomework" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 22141
  Date: 2020/6/17
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<StudentHomework> list = (List<StudentHomework>)request.getAttribute("list");
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
                    <a class="javascript:;" href="http://localhost:8080/teacher/start_publish?userName=<%=userName%>">发布作业</a>
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
                            <td style="font-size: 20px">学生编号</td>
                            <td style="font-size: 20px">提交日期</td>
                            <td style="font-size: 20px">进行操作</td>
                        </tr>

                        <%
                            if(list == null || list.size()<=0){
                                //out.print("No Data");
                            }else{
                                int index = 1;
                                for(StudentHomework sh : list){
                        %>

                        <tr align="center">
                            <td><%=sh.getKey().getHomeworkId()%></td>
                            <td><%=sh.getHomeworkTitle()%></td>
                            <td><%=sh.getKey().getStudentName()%></td>
                            <td><%=sh.getSubmitDate()%></td>
                            <td align="center">
                                <button type="button" class="layui-btn layui-btn-sm detail" id="<%="btn_d"+index%>">内容</button>
                                <button type="button" class="layui-btn layui-btn-sm score" id="<%="btn_s"+index%>">打分</button>
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

<div id="div-score" style="display: none; padding: 10px;" >
    <form class="layui-form">
        <div class="layui-form-item">
            <fieldset class="layui-field-title" >
                <legend>作业分值</legend>
                <input type="text" class="layui-input"  required  lay-verify="required" autocomplete="off"
                       id="score" placeholder="请输入：作业分值">
            </fieldset>
        </div>

        <div class="layui-form-item">
            <fieldset class="layui-field-title" >
                <legend>作业评语</legend>
                <input type="text" class="layui-input"  required  lay-verify="required" autocomplete="off"
                       id="comment" placeholder="请输入：评语">
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
        var studentName;

        $(".detail").click(function () {
            var rowNumber = this.id.slice(5);
            var tb = document.getElementById("table");
            var rows = tb.rows;
            var homeworkId;
            var studentName;

            for(var i=1;i<rows.length;i++){
                if(i!=rowNumber)
                    continue;
                else{
                    var cells = rows[i].cells;
                    homeworkId = cells[0].innerHTML;
                    studentName = cells[2].innerHTML;
                }
            }

            $.ajax({
                url:"http://localhost:8080/teacher/content",
                async:false,
                data:{
                    'homeworkId' : homeworkId,
                    'studentName' : studentName
                },
                type:'GET',
                dataType:'text',
                success:function (result) {
                    layer.open({
                        type:0,
                        title:"作业内容",
                        content:result,
                        anim:2
                    })
                }
            })
        })

        $(".score").click(function () {
            var rowNumber = this.id.slice(5);
            var tb = document.getElementById("table");
            var rows = tb.rows;

            for(var i=1;i<rows.length;i++){
                if(i!=rowNumber)
                    continue;
                var cells = rows[i].cells;
                homeworkId = cells[0].innerHTML;
                studentName = cells[2].innerHTML;
            }
            //alert("homeworkId:"+homeworkId+" studentName:"+studentName);
            index = layer.open({
                type : 1,
                title : "批改作业",
                content : $("#div-score"),
                anim : 2,
                area : '450px'
            })
        })

        $("#layer-cancel").click(function () {
            layer.close(index)
        })

        $("#layer-submit").click(function () {
            var score = $("#score").val();
            var comment = $("#comment").val();
            var today = new Date();
            var date = today.getFullYear()+"-"+(today.getMonth()+1)+"-"+today.getDate();

            if(score!=0&&score!=1&&score!=2&&score!=3&&score!=4&&score!=5&&score!=6&&score!=7&&score!=8&&score!=9&&score!=10){
                layer.msg("请输入0-10的数字打分")
            }else{
                $.ajax({
                    url:"http://localhost:8080/teacher/score",
                    async:false,
                    data:{
                        'homeworkId' : homeworkId,
                        'studentName' : studentName,
                        'score' : score,
                        'comment' : comment,
                    },
                    type : "POST",
                    dataType:"json",
                    success:function () {
                        layer.msg("提交成功",{icon:1});
                    }
                });

                layer.close(index);
                location.href = "http://localhost:8080/student/enter?userName="+userName;
            }
        })

    })
</script>
</body>
</html>
