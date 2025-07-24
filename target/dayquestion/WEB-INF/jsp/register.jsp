<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/1
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>注册页面</title>
    <!-- 引入 Layui 的 CSS 文件 -->
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            background: url('https://picsum.photos/1920/1080') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .register-container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            width: 400px;
        }

        .register-container h2 {
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
<div class="register-container">
    <h2>注册</h2>
    <form class="layui-form" id="registerForm">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="name"  lay-verify="required" placeholder="请输入用户名"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" name="password" lay-verify="required|minLength"
                       placeholder="请输入密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-block">
                <input type="password" name="confirmPassword"  lay-verify="required|confirmPassword"
                       placeholder="请确认密码" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn layui-btn-normal" lay-submit lay-filter="register">注册</button>
                <a href="index.jsp" class="layui-btn layui-btn-normal" style="margin-left: 100px">返回</a>
            </div>
        </div>
    </form>
</div>
<script src="static/layui.js"></script>
<script>
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var $=layui.jquery;
        form.verify({
            minLength: function (value) {
                if (value.length < 6) {
                    return '密码长度不能少于6位';
                }
            },
            confirmPassword: function (value) {
                if (value!== $('input[name="password"]').val()) {
                    return '两次输入的密码不一致';
                }
            }
        });
        
        form.on('submit(register)', function (data) {
            $.ajax({
                url: 'register',
                type: 'POST',
                data: data.field,
                dataType: 'json',
                success: function (res) {
                    if (res.success) {
                        layer.msg('注册成功', { icon: 1 });
                        window.location.href='index.jsp';
                    } else {
                        layer.msg('注册失败: ' + res.message, { icon: 2 });
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
