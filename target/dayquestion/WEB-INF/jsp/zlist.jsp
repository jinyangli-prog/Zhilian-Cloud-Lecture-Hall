<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2024/11/19
  Time: 17:24
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
    <title>作品管理</title>
    <link rel="stylesheet" href="static/css/layui.css">
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
    <ul class="layui-tab-title">
        <li class="layui-this">后台管理 &gt; 作品管理</li>
    </ul>
    <div class="layui-tab-content">
        <div style="padding: 0 15px;">
            <div class="layui-row">
                <div class="layui-col-sm6">
                    <a href="savePhoto?name=${photo.uid}" class="layui-btn layui-btn-sm">
                        <i class="layui-icon">&#xe654;</i> 添加作品
                    </a>
                </div>
            </div>

            <table class="layui-table">
                <colgroup>
                    <col width="120">
                    <col width="360">
                    <col>
                    <col width="270">
                </colgroup>
                <thead>
                <tr>
                    <th>id</th>
                    <th>标题</th>
                    <th>作者</th>
                    <th>品质</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${photos}" var="photo">
                    <tr>
                        <td>${photo.id}</td>
                        <td>${photo.title}</td>
                        <td>${photo.uid}</td>
                        <td>${photo.checked}</td>
                        <td>
                            <a href="updatez?id=${photo.id}" class="layui-btn layui-btn-xs layui-btn-warm"><i class="layui-icon">&#xe642;</i></a>
                            <button class="delete-btn layui-btn layui-btn-xs layui-btn-danger"><i class="layui-icon">&#xe640;</i></button>
                            <input type="hidden" class="photo-id" value="${photo.id}">
                        </td>
                    </tr>
                </c:forEach>


                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="static/layui.js"></script>
<script type="text/javascript">
    layui.use('form', function(){
        var form = layui.form;
        var $=layui.jquery;
        var layer = layui.layer;
        $(document).on('click', '.delete-btn', function () {

            var photoId = $(this).siblings('.photo-id').val();
            layer.confirm('是否删除？', {
                btn: ['确定', '取消'] // 按钮
            }, function(){
                $.ajax({
                    url: 'deletez2',
                    type: 'POST',
                    data: {"id": photoId},
                    dataType: 'json',
                    success: function (res) {
                        if (res.success) {
                            layer.msg('删除成功', { icon: 1 });
                            location.reload();
                        } else {
                            layer.msg('删除失败: ' + res.message, { icon: 2 });
                        }
                    },
                    error: function (error) {
                        console.error('Error:', error);
                        layer.msg('网络请求出错', { icon: 2 });
                    }
                });
            }, function(){
            });
        });
    });
</script>
</body>
</html>

