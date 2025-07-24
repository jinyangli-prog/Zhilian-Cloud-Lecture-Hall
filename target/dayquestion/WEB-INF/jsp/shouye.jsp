<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/8
  Time: 20:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8"/>
    <title>智链云讲堂</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <script src="static/jquery-1.3.2.min.js"></script>
    <script src="static/home_page_circle.js"></script>
    <script src="static/header_model_js.js"></script>
    <script src="static/layui.js"></script>
</head>
<style>
    body {
       background-color: skyblue;
    }
    .suggestionsList{
        background-color: #fbfbfb;
    }
    .suggestionsList li:hover{
       color: #00bcd4;
    }
    #searchInput {
        width: 200px;
        padding: 10px;
    }
    .featured-container {
        display: flex;
        flex-direction: column;
        width: 94%;
        margin-left: 4%;
        gap: 2em;
        position: relative;
        margin-top: 700px;
    }

    .featured_products {
        width: 100%;
        padding-bottom: 2em;
        height: 520px;
        background-color: white;
        box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.3);
        border-radius: 10px;
        position: relative;
    }
    .featured_products2{
        width: 100%;
        padding-bottom: 2em;
        height: 420px;
        background-color: white;
        box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.3);
        border-radius: 10px;
        position: relative;
    }

    .featured_products h2 {
        margin-left: 43.5%;
        margin-top: 2%;
        margin-bottom: 3%;
    }
    .featured_products2 h2 {
        margin-left: 43.5%;
        margin-top: 2%;
        margin-bottom: 3%;
    }
    .featured_products h2 a:hover{
        color: #16baaa;
    }
    .featured_products2 h2 a:hover{
        color: #16baaa;
    }
    .featured_products .product {
        position: relative;
        float: left;
        margin-left: 2%;
        margin-right: 1%;
        display: block;
        text-align: center;
        line-height: 2em;
        width: 14.5%;
        height: 390px;
        border-radius: 6px;
        padding: 1em;
        box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.3);
    }

    .featured_products2 .product {
        position: relative;
        float: left;
        margin-left: 2%;
        margin-right: 1%;
        display: block;
        text-align: center;
        line-height: 2em;
        width: 14.5%;
        height: 300px;
        border-radius: 6px;
        padding: 1em;
        box-shadow: 1px 1px 10px rgba(0, 0, 0, 0.3);
    }

    .featured_products .product .product_img_div {
        display: block;
        vertical-align:middle;
        width: 100%;
        height: 50%;
        margin: auto;
        text-align: center;

    }
    .featured_products2 .product .product_img_div {
        display: block;
        vertical-align:middle;
        width: 100%;
        height: 50%;
        margin: auto;
        text-align: center;

    }

    header {
        width: 99%;
        max-height: 80px;
        background-color: blueviolet;
        box-shadow: 5px 5px 10px #888888;
        position: fixed;
        margin-top: -10px;
        display: block;
        z-index: 30;
        border-radius: 5px;
        overflow: hidden;
    }

    .login_or_register_string a {
        color: white;
        text-decoration: none;
    }

    nav.my_nav ul {
        color: slateblue;
        list-style: none;
        padding: 0;
        margin: 0;
        margin-left: 28%;
    }

    nav.my_nav ul li {
        margin-top: 1.5%;
        float: left;
        margin-left: 3%;
        padding-right: 3%;
        border-right: 3px solid slateblue;
        font-size: 1em;
    }
    nav.my_nav ul li a{
        text-decoration: none;
        font-size: 1em;
        color: slateblue;
    }
    nav.my_nav ul li:last-child {
        border-right: none;
    }
    .short_nav_show ul {
        list-style: none;
        padding: 0;
        margin: 0;
        font-size: 1.2em;
        text-align: center;
        margin-top: 10%;
    }

    .short_nav_show ul li {
        margin-bottom: 10%;
        margin-left: 5%;
        margin-right: 5%;
        border-radius: 5px;
        box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.2);
    }

    .short_nav_show ul li:last-child {
        border-bottom: none;
    }
    .short_nav_show ul li a {
        text-decoration: none;
        color: rgba(0, 0, 0, 0.75);
        font-size: 1em;
    }
    .short_nav_show ul li:hover {
        cursor: pointer;
        background-color: slateblue;
    }
    .personal_nav ul {
        list-style: none;
        padding: 0;
        margin: 0;
        font-size: 1.2em;
        text-align: center;
        margin-top: 10%;
    }
    .personal_nav ul li {
        margin-bottom: 10%;
        margin-left: 5%;
        margin-right: 5%;
        border-radius: 5px;
        box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.2);
    }

    .personal_nav ul li:last-child {
        border-bottom: none;
    }
    .personal_nav ul li a {
        text-decoration: none;
        color: rgba(0, 0, 0, 0.75);
        font-size: 1em;
    }
    .personal_nav ul li:hover {
        cursor: pointer;
        background-color: slateblue;
    }
    .my_slider {
        top: 23%;
        left: 2%;
        width: 96%;
        height: 480px;
        position: absolute;
        overflow: hidden;
        background-color: #eb7350;
        box-shadow: 5px 5px 10px #888888;;
        display: block;
        border-radius: 10px;
    }

    .my_slide {
        display: block;
        width: 80%;
        left: 10%;
        top: 0;
        height: 100%;
        position: absolute;
        float: left;
        opacity: 0;
        color: white;
    }

    .my_slide h1 {
        position: absolute;
        left: 10%;
        top: 30%;
        width: 30%;
    }

    .my_slide p {
        position: absolute;
        left: 10%;
        top: 50%;
        width: 30%;
        overflow: inherit;
    }

    .slide_img {
        position: absolute;
        left: 50%;
        top: 25%;
        width: 60%;
    }

    .left_border {
        position: absolute;
        left: 5%;
        top: 50%;
        width: 50px;
        height: 90px;
        border-radius: 6px;
        background-image: url("../../photo/jl.png");
    }

    .left_turn {
        position: absolute;
        left: 8px;
        top: 5px;
        width: 34px;
        height: 80px;
        background-repeat: no-repeat;
        cursor: pointer;
    }

    .right_border {
        position: absolute;
        left: 92%;
        top: 50%;
        width: 50px;
        height: 90px;
        border-radius: 6px;
    }

    .right_turn {
        position: absolute;
        left: 8px;
        top: 5px;
        width: 34px;
        height: 80px;
        background-image: url("../../photo/jr.png");
        background-repeat: no-repeat;
        background-position: -34px 0;
        cursor: pointer;
    }

    .current {
        opacity: 1;
    }
    .product {
        position: relative;
    }

    .show_img {
        max-height: 180px;
        max-width: 100%;
        transition: opacity 0.35s, transform 0.35s;
        opacity: 1;
        cursor: auto;
    }

    .product:hover .show_img {
        opacity: 0;
    }
    .product:hover .show_title {
        opacity: 0;
    }
    .product:hover .show_tip {
        opacity: 1;
    }
    .product:hover .show_title2 {
        opacity: 0;
    }
    .product:hover .show_tip2 {
        opacity: 1;
    }
    .show_tip {
        opacity: 0;
        transition: opacity 0.35s, transform 0.35s;
        position: absolute;
        top: 0px;
        left: 0px;
        cursor: auto;
    }
    .layui-nav .layui-nav-item a:hover {
        color: royalblue;
    }
    .layui-nav{
        margin-left: 200px;
    }
    .show_title2 {
        margin-top: -100px;
        font-size: 18px;
        font-weight: bold;
        color: #333;
        text-align: center;
        height: 50px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .show_tip2 {
        margin-top: 10px;
        height: 80px;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-line-clamp: 4;
        -webkit-box-orient: vertical;
    }
    .show_title3 {
        font-weight: bold;
        text-align: center;
        height: 80px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .show_tip3 {
        height: 80px;
        overflow: hidden;
        text-overflow: ellipsis;
        margin-top: -50px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }
    .layui-nav .layui-nav-item a {
        margin-left: 50px;
        color: white;
        font-size: 20px;
        transition: background-color 0.3s ease;
    }
    .layui-nav .layui-this::after,
    .layui-nav-bar,
    .layui-nav-tree .layui-nav-itemed::after {
        display: none;
    }
    .home_page_info {
        padding: 20px;
        position: relative;
    }
    .bottom_info {
        margin-bottom: 20px;
        padding: 20px;
        position: relative;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .bottom_info h2 {
        font-size: 20px;
        margin-bottom: 10px;
        font-weight: bold;
    }

    .bottom_info p {
        font-size: 14px;
        color: #555;
        line-height: 1.6;
    }

    footer2 {
        background-color: #333;
        color: #fff;
        text-align: center;
        padding: 10px;
        position: relative;
        font-size: 12px;
    }
    .container {
        display: flex;
        justify-content: space-between;
        padding: 20px;
    }

    .title-list {
        list-style-type: none;
        padding: 0;
        width: 48%;
    }

    .title-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 10px;
        padding: 5px 10px;
        background-color: #f0f0f0;
        border-radius: 5px;
        font-size: 16px;
        color: #333;
    }

    .title-item a {
        text-decoration: none;
        color: #333;
        flex-grow: 1;
    }

    .title-item a:hover {
        text-decoration: underline;
    }
    .footer {
        margin-top: 30px;
        background-color: #333;
        color: #fff;
        padding: 20px 0;
        text-align: center;
        font-family: Arial, sans-serif;
    }

    .footer .logo img {
        width: 50px;
        height: 50px;
    }

    .footer a {
        color: #ddd;
        text-decoration: none;
        margin: 0 10px;
    }

    .footer a:hover {
        text-decoration: underline;
    }

    .footer .social-icons {
        margin-left: 1000px;
    }

    .footer .social-icons img {
        width: 30px;
        height: 30px;
        margin: 0 5px;
        border-radius: 50%;
    }

    .footer .copyright {
        margin-top: 10px;
        font-size: 12px;
    }
    .logo-container {
        display: flex;
        align-items: center;

    }
    .logo-container img {
        margin-left: 150px;
        width: 100px;
        height: auto;
        margin-right: 10px;
    }

    .logo-text {
        font-size: 30px;

    }
</style>
<body>
<div class="layui-header">
    <ul class="layui-nav layui-bg-gray" style="margin-left: -10px">
        <img src="photo/logo.png"  style="width: 60px;height: 60px;background-color: skyblue;" />
        <li class="layui-nav-item"><a href="">首页</a></li>
        <li class="layui-nav-item"><a href="jj2?name=${name}">论坛</a></li>
        <li class="layui-nav-item"><a href="jd2?name=${name}">心得</a></li>
        <li class="layui-nav-item"><a href="meeting">进入讲堂</a></li>
        <form action="search2" method="post">
            <div style=" position: absolute;margin-left: 1000px; top: 10px;">
                <input name="name" value="${name}" type="hidden">
                <input type="text" id="searchInput" name="search" value="" placeholder="Search..." >
                <ul id="suggestionsList" class="suggestionsList"></ul>
            </div>
            <button style="position: absolute; margin-left: 1250px;margin-top: -45px" type="submit"><i class="layui-icon layui-icon-search" style="font-size: 25px"></i></button>
        </form>
        <li class="layui-nav-item"  style=" position: absolute;margin-left: 1300px; ;top: 8px;" >
            <a href="" style="margin-top: -10px"> <i class="layui-icon layui-icon-edit" style="font-size: 30px;color: #1E9FFF;"></i></a>
        <dl class="layui-nav-child">
            <dd><a href="savePhoto?name=${name}">编写解答</a></dd>
            <dd><a href="ad?name=${name}">编写心得</a></dd>
        </dl>
        </li>
        <li class="layui-nav-item"  style=" position: absolute;margin-left: 1450px; ;top: 0px;" ><a href="person?name=${name}"> <i class="layui-icon layui-icon-username"style="font-size: 30px; color: #1E9FFF;margin-left: -20px"></i></a></li>
    </ul>
</div>
<div class="my_slider">
    <c:forEach items="${photos}" var="photo">
        <a href="talk?id=${photo.id}&name=${name}"class="my_slide">

            <h1 class="show_title3" style="font-size: 50px;margin-top: -50px">${photo.title}</h1>
            <p class="show_tip3" style="font-size: 25px">${photo.wz}</p>
            <div class="slide_img">
                <img src="${photo.uphoto}" style="width: 600px;height: 350px;margin-top: -50px;margin-left: -50px"/>
            </div>

        </a>
    </c:forEach>
    <div class="my_slide current">
        <h1>欢迎来到智链云讲堂</h1>
        <p>
            在智链云讲堂上，您可以关注自己感兴趣的词条，与其他用户交流和分享知识，希望您能结交志同道合的朋友。 </p>
        <div class="slide_img">
            <img src="photo/logo.png" style="width: 400px;height: 270px"/>
        </div>
    </div>
    <div class="left_border">
        <span class="left_turn"></span>
    </div>
    <div class="right_border">
        <span class="right_turn"></span>
    </div>
</div>
<div class="featured-container">
    <div class="featured_products">
        <h2>课堂解答<a href="jj2?name=${name}" style="margin-left: 650px;font-size: 18px">>>>更多</a></h2>
        <c:forEach items="${photoChecked}" var="photoc">
        <a href="talk?id=${photoc.id}&name=${name}">
            <figure class="product">
                <div class="product_img_div">
                    <img src="${photoc.uphoto}" class="show_img" />
                </div>
                <h1 class="show_title">${photoc.title}</h1>
                <p class="show_tip" style="font-size: 20px;margin-top: 50px">${photoc.wz}</p>
            </figure>
        </a>
        </c:forEach>

    </div>
    <div style="background-color: #fbfbfb;height: 200px;width: 100%;padding-top: 20px; box-shadow: 5px 5px 10px #888888;;
        display: block;border-radius: 10px;">
        <h2 style="margin-left: 700px">课堂心得
            <a href="jd2?name=${name}" style="margin-left: 650px;font-size: 18px">>>>更多</a>
        </h2>
    <div class="container">
        <!-- 第一个列表 -->
        <ul class="title-list">
            <c:forEach items="${wzChecked}" var="photod" varStatus="status">
                <c:if test="${status.count % 2 == 1}">
                    <li class="title-item">
                        <a href="talk3?id=${photod.id}&name=${name}"><i class="layui-icon layui-icon-triangle-r"></i>${photod.title}</a>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
        <!-- 第二个列表 -->
        <ul class="title-list">
            <c:forEach items="${wzChecked}" var="photod" varStatus="status">
                <c:if test="${status.count % 2 == 0}">
                    <li class="title-item">
                        <a href="talk3?id=${photod.id}&name=${name}"><i class="layui-icon layui-icon-triangle-r"></i>${photod.title}</a>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>
    </div>
</div>
<div class="footer">
    <div class="logo-container">
        <img src="photo/logo3.png" alt="Logo" >
        <div class="logo-text">智链云讲堂</div>
        <div style="position: absolute;margin-top: 100px; color: #ddd;margin-left: 160px">通过智能技术链接未来，汇聚各方力量，成就网络学堂</div>
    </div>
    <div class="links" style="margin-top: -80px">
        <h2 style="margin-bottom: 20px;margin-left: -110px">关于我们</h2>
        <a href="#">关于我们</a>
        <a href="#">学校</a>
        <a href="#">合作渠道</a>
    </div>
    <div class="social-icons"  style="margin-top: -80px">
        <h2 style="margin-bottom: 20px;margin-left: -120px">联系我们</h2>
        <a href="#">常见问题</a>
        <a href="#"><i class="layui-icon layui-icon-login-qq" style="font-size: 50px"></i></a>
        <a href="#"><i class="layui-icon layui-icon-login-wechat"style="font-size: 50px"></i></a>
    </div>
    <div class="copyright" style="margin-top: 50px">
        2024-2025 zhilian.com
    </div>
</div>
<script>
    var arr = [
        <%
            String[] arrFromJava = (String[]) request.getAttribute("arr");
            if (arrFromJava != null) {
                for (int i = 0; i < arrFromJava.length; i++) {
                    out.print("'" + arrFromJava[i].replace("'", "\\'") + "'");
                    if (i < arrFromJava.length - 1) {
                        out.print(",");
                    }
                }
            }
        %>
    ];
    var searchInput = document.getElementById("searchInput");
    var suggestionsList = document.getElementById("suggestionsList");

    // 莱文斯坦距离算法
    function levenshteinDistance(a, b) {
        if (a.length === 0) return b.length;
        if (b.length === 0) return a.length;
        var matrix = [];
        for (var i = 0; i <= b.length; i++) {
            matrix[i] = [i];
        }
        for (var j = 0; j <= a.length; j++) {
            matrix[0][j] = j;
        }
        for (var i = 1; i <= b.length; i++) {
            for (var j = 1; j <= a.length; j++) {
                if (b.charAt(i - 1) === a.charAt(j - 1)) {
                    matrix[i][j] = matrix[i - 1][j - 1];
                } else {
                    matrix[i][j] = Math.min(
                        matrix[i - 1][j - 1] + 1,
                        matrix[i][j - 1] + 1,
                        matrix[i - 1][j] + 1
                    );
                }
            }
        }
        return matrix[b.length][a.length];
    }

    searchInput.addEventListener("input", function () {
        var keyword = searchInput.value.toLowerCase();
        var matchedSuggestions = arr.filter(function (item) {
            return levenshteinDistance(keyword, item.toLowerCase()) <= 3;
        });
        suggestionsList.innerHTML = "";
        matchedSuggestions.forEach(function (suggestion) {
            var li = document.createElement("li");
            li.textContent = suggestion;
            li.addEventListener('click', () => {
                searchInput.value = suggestion;
                suggestionsList.innerHTML = '';
            });
            suggestionsList.appendChild(li);
        });
    });
</script>
</body>
</html>
