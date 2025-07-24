<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/23
  Time: 21:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>发布帖子</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css">
</head>
<body>
<h1>发布新帖子</h1>
<input type="hidden"  id="uid" name="uid" value="${name}">
<form id="postForm">
    <label>标题：</label><br>
    <input type="text" id="title" name="title" required style="width: 100%; padding: 8px;"><br><br>

    <label>内容：</label>
    <div id="editor"></div><br>
    <select name="clazz" class="custom-select">
        <option value="技术问题">技术问题</option>
        <option value="人文社科问题">人文社科问题</option>
        <option value="数学问题">数学问题</option>
        <option value="科学问题">科学问题</option>
    </select>
    <button type="submit">发布</button>
</form>

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="static/layui.js"></script>
<script>
    var $=layui.jquery;
    const editor = new toastui.Editor({
        el: document.querySelector('#editor'),
        height: '400px',
        initialEditType: 'markdown',
        previewStyle: 'vertical'
    });

    document.getElementById('postForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const title = document.getElementById('title').value;
        const content = editor.getMarkdown();
        const clazz = document.querySelector('.custom-select').value; // 确保选择器正确
        // TODO: 通过 AJAX 或 fetch 提交到服务器
        $.ajax({
            url: 'ad', // 确保后端接口路径正确
            type: 'POST',
            data: {
                "uid": $("#uid").val(),
                "content": content,
                "title": title,
                "clazz": clazz
            },
            dataType: 'json',
            success: function(res) {
                if (res.success) {
                    layer.msg('添加成功', { icon: 1 });
                } else {
                    layer.msg('添加失败: ' + res.message, { icon: 2 });
                }
            },
            error: function(error) {
                console.error('Error:', error);
                layer.msg('网络请求出错', { icon: 2 });
            }
        });
        console.log('发布内容:', { title, content });
    });
</script>
</body>
</html>
