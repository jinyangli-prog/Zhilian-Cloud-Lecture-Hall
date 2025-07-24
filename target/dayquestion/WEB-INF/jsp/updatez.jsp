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
            width: 100%; /* 宽度 */
            padding: 10px; /* 内边距 */
            font-size: 16px; /* 字体大小 */
            border: 2px solid #5FB878; /* 绿色边框 */
            border-radius: 5px; /* 圆角 */
            background-color: #f8f8f8; /* 背景颜色 */
            margin-bottom: 10px; /* 与其他元素的间距 */
        }
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <div class="layui-tab-content">
        <div style="padding: 0 15px;">
            <br/>
            <br/><br/>
            <form class="layui-form">
                <div class="layui-form-item">
                    <img id="photoView" src="${photo.uphoto}" style="max-width: 800px;">
                </div>
                <input type="hidden" name="id" value="${photo.id}">
                <label class="layui-form-label">作者</label>
                <div class="layui-input-block">
                    <input type="text" name="uid" value="${photo.uid}" readonly autocomplete="off" class="layui-input">
                </div>
                <label class="layui-form-label">标题</label>
                    <textarea   name="title"  placeholder="${photo.title}" readonly class="layui-textarea"></textarea>
                <label class="layui-form-label">内容</label>
                <div class="layui-form">
                    <textarea   name="wz"  placeholder="${photo.wz}" readonly class="layui-textarea"></textarea>
                </div>
                <div style="margin-top: 10px;margin-bottom: 10px;font-size: 20px">品质类型</div>
                <label >轮播图
                <input type="radio" name="checked" class="fj" value="lun" >
                </label>
                <label >普通文章
                    <input type="radio" name="checked" class="fj"  value="jj" >
                </label>
                <label >精选文章
                    <input type="radio" name="checked" class="fj" value="wz" >
                </label>
                <label >普通解答
                    <input type="radio" name="checked" class="fj" value="jd" >
                </label>
                <label >精选解答
                    <input type="radio" name="checked" class="fj" value="yes">
                </label>
                <label >
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="update">修改</button>
                </label>
            </form>
        </div>
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
                url: 'updatez2',
                type: 'POST',
                data: data.field,
                dataType: 'json',
                success: function (res) {
                    if (res.success) {
                        layer.msg('修改成功', { icon: 1 });
                        window.location.href='zlist';
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

