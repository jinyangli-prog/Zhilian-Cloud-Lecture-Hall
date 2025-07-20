<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/14
  Time: 14:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>后台管理系统</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            height: 70px;
            background-color: black;
            color: #fff;
            border-bottom: 1px solid #ddd;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        .header-left {
            display: flex;
            align-items: center;
            padding-left: 20px;
        }
        .layui-body {
            position: absolute;
            left: 200px;
            right: 0;
            top: 60px;
            bottom: 0;
            overflow: hidden;
        }
        .layout-admin {
            margin-top: 70px;
            height: calc(100vh - 70px);
        }
        .side {
            position: fixed;
            top: 70px;
            left: 0;
            bottom: 0;
            width: 200px;
            background-color: #393D49;
            overflow-y: auto;
        }
        .tree {
            height: 100%;
        }

        .header-left {
            display: flex;
            align-items: center;
            padding-left: 20px;
        }

        .logo {
            width: 35px;
        }

        .web-title {
            margin: 0 40px 0 10px;
            font-size: 22px;
        }

        .collapse-btn {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 10px;
            cursor: pointer;
            opacity: 0.8;
            font-size: 22px;
        }

        .collapse-btn:hover {
            opacity: 1;
        }

        .header-right {
            display: flex;
            align-items: center;
            padding-right: 50px;
        }

        .btn-icon {
            position: relative;
            width: 30px;
            height: 30px;
            text-align: center;
            cursor: pointer;
            display: flex;
            align-items: center;
            color: #fff;
            margin: 0 5px;
            font-size: 20px;
        }
        .user-avator {
            margin: 0 10px 0 20px;
        }

        .el-dropdown-link {
            color: #fff;
            cursor: pointer;
            display: flex;
            align-items: center;
        }
        .side {
            width: 200px;
            background-color: #4a5568;
        }
        .vertical-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .vertical-menu li a {
            display: block;
            padding: 12px 20px;
            text-decoration: none;
            color: white;
            transition: all 0.3s;
            text-align: left;
            border-left: 3px solid transparent;
            font-size: 14px;
        }
        .vertical-menu li a:hover {
            background-color: #1E9FFF;
            color: white;
            border-left-color: #1E9FFF;
            padding-left: 17px;
        }
        .vertical-menu li a cite {
            display: inline-block;
            padding-left: 10px;
        }


    </style>
</head>
<body>
<div class="header">
    <div class="header-left">
        <img class="logo" src="photo/logo.png" alt=""style="height: 60px;width: 60px;margin-left: -15px">
        <div class="web-title">后台管理系统</div>

    </div>
    <div class="header-right" >
        <div class="btn-icon" >
            <i class="layui-icon layui-icon-set"></i>
        </div>
        <div class="btn-icon" >
            <i class="layui-icon layui-icon-notice"></i>
        </div>
        <div class="btn-icon" onclick="setFullScreen()">
            <i class="layui-icon layui-icon-screen-full"></i>
        </div>
        <img class="user-avator" src="photo/user2.png" style="width: 30px;height: 30px">
        <div class="el-dropdown-link">
            <c:out value="管理员"/>
        </div>
        <a href="index.jsp">
        <i class="layui-icon layui-icon-logout" style="font-size: 20px; margin-left: 10px; margin-right:-40px;color: #1E9FFF;"></i>
        </a>
    </div>
</div>
<div class="layout-admin">
    <div class="side">
            <ul class="vertical-menu" >
                        <li>
                            <a href="houtai">
                                <cite>系统首页</cite>
                            </a>
                            <a href="zlist" target="content">
                                <cite>作品管理</cite>
                            </a>
                            <a href="ulist" target="content">
                                <cite>账号管理</cite>
                            </a>
                        </li>
            </ul>
    </div>
</div>
<div class="layui-body" style="margin-top: 30px">
    <iframe name="content" id="table" src="table"
            frameborder="0" style="width:100%;height:100%;"></iframe>
</div>
<script src="static/layui.js"></script>
<script>
    function setFullScreen() {
        if (document.fullscreenElement) {
            document.exitFullscreen();
        } else {
            document.body.requestFullscreen();
        }
    }
</script>
</body>
</html>