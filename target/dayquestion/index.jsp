<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录页面</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            background: url('photo/login2.png');
            background-size: 100% 100%;
            display: flex;
            justify-content: left;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            margin-left: 920px;
            margin-top: 20px;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            height: 450px;
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
<div>
    <div class="login-container">
            <h2>登录</h2>
            <form class="layui-form" id="loginForm">
                <div class="layui-form-item">
                    <label class="layui-form-label">用户名</label>
                    <div class="layui-input-block">
                        <i class="layui-icon layui-icon-user" style="display: flex"></i>
                        <input type="text" name="name" id="name2"  style="display: flex" required lay-verify="required" placeholder="请输入用户名"
                               autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <i class="layui-icon layui-icon-password"></i>
                    <label class="layui-form-label">密码</label>
                    <div class="layui-input-block">
                        <input type="password" name="password" required lay-verify="required|minLength"
                               placeholder="请输入密码" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">验证码</label>
                    <div class="layui-input-block">
                        <input type="text" name="captcha" id="captcha" required  placeholder="请输入验证码"
                               autocomplete="off" class="layui-input">
                        <img src="captcha" alt="验证码" id="captchaImg" style="cursor: pointer;" onclick="refreshCaptcha()" />
                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn layui-btn-normal" lay-submit lay-filter="login">登录</button>
                        <a href="register" class="layui-btn layui-btn-normal">注册</a>
                    </div>
                </div>
            </form>
        <div class="third-party-login">
            <a href="#" title="QQ 登录"><i class="fa-brands fa-qq"></i></a>
            <a href="#" title="微信登录"><i class="fa-brands fa-weixin"></i></a>
        </div>
    </div>
</div>
<script src="static/layui.js"></script>
<script>
    function refreshCaptcha() {
        var captchaImg = document.getElementById('captchaImg');
        captchaImg.src = "captcha?rand=" + new Date().getTime();  // 防止缓存
    }
    layui.use(['form', 'layer'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var $=layui.jquery;
        form.verify({
            minLength: function (value) {
                if (value.length < 6) {
                    return '密码长度不能少于6位';
                }
            }
        });
        form.on('submit(login)', function (data) {
            $.ajax({
                url: 'login',
                type: 'POST',
                data: data.field,
                dataType: 'json',
                success: function (res) {
                    if (res.success) {
                        layer.msg('登录成功', { icon: 1 });
                        if (res.houtai)
                            window.location.href='houtai';
                        else
                        window.location.href='shouye?name=' + encodeURIComponent($("#name2").val());
                    } else {
                        layer.msg('登录失败: ' + res.message, { icon: 2 });
                    }
                },
                error: function (error) {
                    console.error('Error:', error);
                    layer.msg('网络请求出错', { icon: 2 });
                }
            });
            return false;
        });
            $("#btn2").click(function () {
                window.location.href = 'register';
            });
    });
</script>
</body>
</html>