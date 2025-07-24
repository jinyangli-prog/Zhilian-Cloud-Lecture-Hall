<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/4
  Time: 18:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>天问百科</title>
    <!-- 引入 Layui 的 CSS 文件 -->
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            font-family:"Microsoft YaHei",微软雅黑,"MicrosoftJhengHei",华文细黑,STHeiti,MingLiu;
            font-weight: bold;
        }
        .layui-header {
            margin-top: -40px;
        }

        .layui-logo {
            color: white;
            font-size: 28px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .layui-nav .layui-nav-item a:hover {
            color: royalblue;
        }
        .layui-nav{
            margin-left: 200px;
        }
        .layui-nav .layui-nav-item a {
            margin-left: 50px;
            color: white;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .layui-carousel{
            margin-left: 100px;
        }
    </style>
</head>

<body>
    <div class="layui-header">
        <div class="layui-logo">天问百科</div>
            <ul class="layui-nav layui-bg-gray">
                <li class="layui-nav-item"><a href="">首页</a></li>
                <li class="layui-nav-item"><a href="">论坛</a></li>
                <li class="layui-nav-item"><a href="">心得</a></li>
            </ul>
    </div>
<div class="layui-carousel" id="ID-carousel-demo-image">
    <a href="savePhoto?name=${name}" class="layui-btn layui-btn-normal">添加</a>
    <div carousel-item>
        <c:forEach items="${photos}" var="photo">
            <img src="${photo.uphoto}">
        </c:forEach>
    </div>
</div>
<script src="static/layui.js"></script>
<script>
    layui.use(function(){
        var carousel = layui.carousel;
        carousel.render({
            elem: '#ID-carousel-demo-image',
            width: '720px',
            height: '360px',
            interval: 3000
        });
    });
</script>

</body>

</html>
