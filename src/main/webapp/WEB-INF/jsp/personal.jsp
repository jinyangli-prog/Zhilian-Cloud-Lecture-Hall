<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/12
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个性化个人展示页面</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* 全局样式 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            color: #333;
        }

        /* 头部导航栏样式 */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 50px;
            background-color: #1a1a1a;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            overflow: hidden;
        }

        .avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .name {
            color: white;
            font-size: 24px;
            font-weight: bold;
        }

        .menu-button {
            display: none;
            flex-direction: column;
            justify-content: space-around;
            width: 30px;
            height: 20px;
            cursor: pointer;
        }

        .menu-button span {
            height: 3px;
            background-color: white;
            transition: all 0.3s ease;
        }

        nav ul {
            list-style-type: none;
            display: flex;
        }

        nav ul li {
            margin-right: 20px;
        }

        nav ul li a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            position: relative;
            transition: color 0.3s ease;
        }

        nav ul li a::before {
            content: "";
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 0;
            background-color: #ff6600;
            transition: width 0.3s ease;
        }

        nav ul li a:hover {
            color: #ff6600;
        }

        nav ul li a:hover::before {
            width: 100%;
        }

        /* 主体内容区样式 */
        main {
            padding: 50px;
        }

        .section {
            margin-bottom: 50px;
        }

        .section h2 {
            font-size: 36px;
            margin-bottom: 20px;
            color: #333;
        }

        .about-me p {
            font-size: 18px;
            line-height: 1.6;
        }

        .work-item {
            margin-bottom: 20px;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .work-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
        }

        .work-item img {
            width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .menu-button {
                display: flex;
            }

            nav ul {
                display: none;
                flex-direction: column;
                position: absolute;
                top: 70px;
                left: 0;
                width: 100%;
                background-color: #1a1a1a;
            }

            nav ul.active {
                display: flex;
            }

            nav ul li {
                margin: 0;
                padding: 10px 20px;
                border-bottom: 1px solid #333;
            }
        }
        .avatar-container img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            cursor: pointer;
        }
        .avatar-container input[type="file"] {
            display: none;
        }
        .product {
            position: relative;
            background: white;
            border-radius: 0.75rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }
        .product:hover {
            transform: scale(1.02);
        }
        .product_img_div {
            background-color: #cbd5e0; /* Gray background */
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
            overflow: hidden; /* 避免图片溢出 */
        }

        .show_img {
            width: 100%;
            height: auto;
            display: block; /* 去除图片下方空隙 */
            border-top-left-radius: 0.75rem;
            border-top-right-radius: 0.75rem;
        }
        .show_title {
            font-size: 1.25rem;
            font-weight: bold;
            padding: 0.75rem;
            color: #1a202c;
        }
        .show_tip {
            padding: 0 0.75rem 0.75rem;
            font-size: 0.875rem;
            color: #4a5568;
        }
    </style>
</head>

<body>
<!-- 头部导航栏 -->
<header>
    <div class="avatar">
        <img id="userPhoto" src="${user.photo}" alt="User Photo">
        <input type="file" id="avatarInput" accept="image/*">
        <textarea id="potoStr" type="hidden" name="photo" placeholder="" class="layui-textarea" style="display: none;"></textarea>
        <input type="hidden" name="name" id="name" value="${user.name}">
    </div>
    <div class="name">${user.name}</div>
    <div class="menu-button" id="menuButton">
        <span></span>
        <span></span>
        <span></span>
    </div>
    <nav>
        <ul id="navMenu">
            <li><a href="shouye?name=${user.name}">首页</a></li>
            <li><a href="zm?name=${user.name}">账号安全</a></li>
            <li><a href="#">作品展示</a></li>
            <li><a href="#">联系我</a></li>
        </ul>
    </nav>
</header>

<!-- 主体内容区 -->
<main>
    <section class="section about-me">
        <h2>关于我</h2>
        <textarea  name="tx" id="tx" class="layui-textarea" placeholder="这里可以详细介绍你的个人经历、兴趣爱好、专业技能等信息，让访问者更好地了解你。">${user.jj}</textarea>
        <button id="jj" class="layui-btn" style="margin-left: 1455px">修改</button>
    </section>
        <h2 style="font-size: 30px" >作品展示</h2>
        <main class="max-w-7xl mx-auto px-4 py-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <c:forEach items="${photos}" var="photod">
                <c:if test="${not empty photod.uphoto}">
                    <a href="talk?id=${photod.id}&name=${user.name}">
                        <figure class="product">
                            <div class="product_img_div" style="height: 300px;margin-top: 20px">
                                <img src="${photod.uphoto}" class="show_img"/>
                            </div>
                            <h1 class="show_title" style="margin-top: 20px">${photod.title}</h1>
                            <p class="show_tip">${photod.wz}</p>
                        </figure>
                    </a>
                </c:if>
                <c:if test="${empty photod.uphoto}">
                    <a href="talk?id=${photod.id}&name=${user.name}">
                        <figure class="product">
                            <h1 class="show_title">${photod.title}</h1>
                            <p class="show_tip">${photod.wz}</p>
                        </figure>
                    </a>
                </c:if>
            </c:forEach>
        </main>
</main>
<script src="static/layui.js"></script>
<script>
    const menuButton = document.getElementById('menuButton');
    const navMenu = document.getElementById('navMenu');

    menuButton.addEventListener('click', () => {
        navMenu.classList.toggle('active');
        const spans = menuButton.querySelectorAll('span');
        spans.forEach(span => {
            span.style.transform = navMenu.classList.contains('active')? 'rotate(45deg)' : 'rotate(0)';
            span.style.marginTop = navMenu.classList.contains('active')? '7px' : '0';
        });
    });

</script>
<script>

    const defaultPhoto = "photo/user.png";


    const imgElement = document.getElementById("userPhoto");


    if (!${user.photo}) {
        imgElement.src = defaultPhoto;
    } else {
        imgElement.src = ${user.photo};
    }
</script>
<script>
    var $ = layui.jquery;

    const userPhoto = document.getElementById("userPhoto");
    const avatarInput = document.getElementById("avatarInput");

    userPhoto.addEventListener("click", () => {
        avatarInput.click();
    });

    avatarInput.addEventListener("change", (event) => {
        const file = event.target.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(event) {
                var base64String = event.target.result;
                $("#potoStr").val(base64String);

                // Send AJAX request
                $.ajax({
                    url: 'saveUserPhoto',
                    type: 'POST',
                    data: {
                        "photo": base64String,
                        "name": $("#name").val()
                    },
                    dataType: 'json',
                    success: function(res) {
                        if (res.success) {
                            userPhoto.src = base64String;
                        } else {
                            console.error('Failed to save photo:', res.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX request failed. Status: " + status + ", Error: " + error);
                    }
                });
            };
            reader.readAsDataURL(file);
        }
    });
</script>
<script>
    var $ = layui.jquery;
    const add=document.getElementById("jj");
    add.addEventListener("click", () => {
        var value = $("#tx").val();
        $.ajax({
            url: 'saveUserJj',
            type: 'POST',
            data: {
                "jj": value,
                "name": $("#name").val()
            },
            dataType: 'json',
            success: function (res) {
            }
        });
    })
</script>
</body>

</html>
