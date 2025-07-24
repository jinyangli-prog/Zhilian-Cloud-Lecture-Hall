<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2024/11/17
  Time: 13:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-control" content="no-cache">
    <meta http-equiv="Cache" content="no-cache">
    <title></title>
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        .custom-select {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 2px solid #5FB878;
            border-radius: 5px;
            background-color: #f8f8f8;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<a href="shouye?name=${name}"  style="font-size: 20px">返回</a>

<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <div class="layui-tab-content">
        <div style="padding: 0 15px;">
            <br/>
            <br/><br/>
            <form class="layui-form" action="savePhoto" method="post" enctype="multipart/form-data">
                <div class="layui-form-item">
                    <img id="photoView" src="" style="max-width: 800px;">
                </div>
                <input type="hidden" name="uid" value="${name}">
                <div class="layui-form-item">
                    <label class="layui-form-label">照片</label>
                    <div class="layui-input-inline">
                        <div class="layui-row">
                            <div class="layui-col-xs8">
                                <input type="text" id="filePath" name="path" readonly   placeholder="请选择文件"  class="layui-input">
                            </div>
                            <div class="layui-col-xs4">
                                <button id="btnSelectFile" type="button" class="layui-btn layui-btn-fluid layui-btn-normal"><i class="layui-icon" style="font-size: 20px;">&#xe67d;</i></button>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-mid layui-word-aux"></div>
                </div>
                    <textarea   name="title"  placeholder="标题：" class="layui-textarea"></textarea>
                <div class="layui-form">
                    <textarea   name="wz" placeholder="内容：" class="layui-textarea"></textarea>
                </div>
                <select name="clazz" class="custom-select">
                    <option value="技术问题">技术问题</option>
                    <option value="人文社科问题">人文社科问题</option>
                    <option value="数学问题">数学问题</option>
                    <option value="科学问题">科学问题</option>
                </select>
                <div class="layui-form">
                    <textarea id="potoStr" type="hidden" name="photo" placeholder="" class="layui-textarea" style="display: none;"></textarea>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <input id="selectedFile" type="file" style="display: none;">
                        <button type="submit" class="layui-btn" lay-submit lay-filter="formClazz">保存</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>

<script src="static/layui.js"></script>
<script>
    layui.use(function () {
        var $ = layui.jquery;
        var layer = layui.layer;

        $("#btnSelectFile").click(function () {
            $("#selectedFile").click();
        });

        $("#selectedFile").change(function () {
            if(this.files.length >0){
                var fileName = this.files[0].name.toLowerCase();
                    $("#filePath").val(fileName);
                    var URL = window.URL || window.webkitURL;
                    var imgURL = URL.createObjectURL(this.files[0]);
                    $("#photoView").attr("src",imgURL);


                    var reader = new FileReader();
                    reader.onload=function (event) {
                        var base64String = event.target.result;
                        $("#potoStr").val(base64String);
                    };
                    reader.readAsDataURL(this.files[0]);
            }
        });
    });
</script>
</body>
</html>

