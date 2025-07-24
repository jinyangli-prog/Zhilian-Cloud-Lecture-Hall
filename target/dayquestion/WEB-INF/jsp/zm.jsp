<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/20
  Time: 14:05
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>账号信息管理</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <script src="static/layui.js"></script>
</head>
<body class="layui-container" style="padding-top: 30px;">
<a href="index.jsp">返回登录</a>
<fieldset class="layui-elem-field">
    <legend>账号信息</legend>
    <div class="layui-field-box">
        <form class="layui-form" id="accountForm">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="name" value="${user.name}" id="name" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-block">
                    <input type="text" name="password" value="${user.password}" id="password" class="layui-input">
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button type="submit" lay-submit lay-filter="zm" class="layui-btn layui-btn-normal">确定修改</button>
                </div>
            </div>
        </form>
    </div>
</fieldset>

<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var $ = layui.$;

        form.on('submit(zm)', function (data) {
            $.post('zm', {
                id: '${user.id}',
                name: $("#name").val(),
                password: $("#password").val()
            }, function (res) {
                if (res.success) {
                    layer.msg('修改成功', {icon: 6});
                } else {
                    layer.msg('修改失败: ' + res.message, {icon: 5});
                }
            });
            return false; // 防止表单自动提交
        });
    });
</script>

</body>
</html>
