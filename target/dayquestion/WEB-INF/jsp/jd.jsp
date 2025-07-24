<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文章分类展示</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
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
            height: 160px;
            background-color: #cbd5e0; /* Gray background */
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
<body class="bg-gray-100">

<!-- 分类导航栏 -->
<div class="bg-white shadow-md p-4 flex space-x-4 justify-center">
    <a href="shouye?name=${name}"  class="px-4 py-1 rounded-full bg-blue-100 text-blue-700 hover:bg-blue-200" style="margin-right: 500px;margin-left: -600px">返回</a>
    <c:forEach items="${categories}" var="cat">
        <a href="jd?category=${cat}&name=${name}" class="px-4 py-1 rounded-full bg-blue-100 text-blue-700 hover:bg-blue-200">
                ${cat}
        </a>
    </c:forEach>
</div>

<!-- 内容区域 -->
<main class="max-w-7xl mx-auto px-4 py-6 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
    <c:forEach items="${wzChecked}" var="photod">
        <a href="talk3?id=${photod.id}&name=${name}">
            <figure class="product">
                <h1 class="show_title">${photod.title}</h1>
                <p class="show_tip">${photod.wz}</p>
            </figure>
        </a>
    </c:forEach>
</main>

</body>
</html>