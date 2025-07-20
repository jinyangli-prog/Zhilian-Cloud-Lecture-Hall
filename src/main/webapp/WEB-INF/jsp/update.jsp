<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改页面</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            background: url('photo/90.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            width: 400px;
        }

        .login-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .layui-form-label {
            width: 100px;
        }
    </style>
</head>
<body>
<div id="app">
    <div class="login-container">
            <h2>修改</h2>
            <form class="layui-form" id="loginForm">
                <input type="hidden" name="id" value="${user.id}" >
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <i class="layui-icon layui-icon-user"></i>
                        <input type="text" name="name" id="name2" value="${user.name}"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <i class="layui-icon layui-icon-password"></i>
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="password" required lay-verify="required|minLength"
                               value="${user.password}" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="update">修改</button>
                    </div>
                </div>
            </form>
    </div>
</div>
<script src="static/layui.js"></script>
<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var $=layui.jquery;
        form.on('submit(update)', function (data) {
            $.ajax({
                url: 'updatenp2',
                type: 'POST',
                data: data.field,
                dataType: 'json',
                success: function (res) {
                    if (res.success) {
                        layer.msg('修改成功', { icon: 1 });
                        window.location.href='houtai';
                    } else {
                        layer.msg('修改失败: ' + res.message, { icon: 2 });
                    }
                },
                error: function (error) {
                    console.error('Error:', error);
                    layer.msg('网络请求出错', { icon: 2 });
                }
            });
            return false;
        });

    });
</script>
</body>
</html>