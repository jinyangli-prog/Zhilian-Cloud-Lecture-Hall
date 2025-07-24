<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/23
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>查看帖子</title>
    <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css">
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            display: flex;
            font-family: sans-serif;
            background-color: #f9f9f9;
        }

        #toc {
            width: 250px;
            padding: 20px;
            border-right: 1px solid #ccc;
            height: 100vh;
            overflow-y: auto;
            position: sticky;
            top: 0;
            background: #fff;
        }

        #toc ul {
            list-style: none;
            padding-left: 0;
        }

        #toc li {
            margin: 5px 0;
        }

        #toc a {
            text-decoration: none;
            color: #0066cc;
        }

        #content {
            flex: 1;
            padding: 20px 40px;
            background: #fff;
        }

        .post-section {
            padding-bottom: 40px;
            border-bottom: 2px solid #eee;
        }

        .top-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
            z-index: 1000;
        }

        #comments {
            padding-top: 30px;
        }

        .comment {
            display: flex;
            border-bottom: 1px solid #eee;
            padding: 15px 0;
        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #ccc;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .comment-body {
            flex: 1;
        }

        .comment-header {
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
        }

        .comment-user {
            font-weight: bold;
        }

        .comment-time {
            color: #999;
            font-size: 12px;
            margin-left: 10px;
        }

        .comment-text {
            margin-bottom: 8px;
        }

        .like-btn {
            background: none;
            border: none;
            color: #0066cc;
            cursor: pointer;
            font-size: 14px;
        }

        .like-btn:hover {
            text-decoration: underline;
        }

        #commentInput {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #addCommentBtn {
            margin-top: 10px;
            padding: 8px 12px;
            font-size: 14px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .shuru {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        background-color: #f9f9f9;
        padding: 10px;
        box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        justify-content: space-between;
        z-index: 1000;
    }

    .shuru input {
        width: calc(100% - 120px);
        margin-right: 10px;
    }

    .shuru button {
        width: 100px;
    }

    .container {
        width: 100%;
        height: 100vh;
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 300px;
    }

    .xiao {
        width: 100%;
        display: flex;
        align-items: center;
        margin-top: 50px;
        padding: 10px;
        border: 1px solid #ccc;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

    }

    .xiao img {
        margin-right: 10px;
    }

    .xiao p {
        flex: 1;
    }

    .like-container {
        margin-left: 15px;
        margin-top: 22px;
    }

    .like-button {
        background: none;
        border: none;
        cursor: pointer;
        outline: none;
        padding: 0;
    }

    .like-icon {
        display: inline-block;
        width: 15px;
        height: 15px;
        background-image: url('photo/wdian.png');
        background-size: cover;
    }

    .like-button.liked .like-icon {
        background-image: url('photo/dian.png');
    }

    .like-count {
        font-size: 15px;
    }
    </style>
</head>
<body>
<div id="toc">
    <h2>目录</h2>
    <ul id="tocList"></ul>
</div>
<div id="content">
<h1 id="postTitle">帖子标题</h1>
<div id="viewer"></div>
<img src="${photo.uphoto}" style="width: 600px;height: 350px;" onerror="this.style.display='none';"/>
    <div id="comments">
        <h2>评论</h2>
<div class="container " style="margin-bottom: 300px">
    <c:forEach items="${remarks}" var="remark2"  varStatus="status">
        <div class="xiao" style="margin-top: 10px;margin-bottom: 10px">
            <img class="userPhoto" src="${photosu[status.index]}" style="width: 50px; height: 50px" alt="User Photo">
            <div>${remark2.uname}
                <p>${remark2.remark}
                </p></div>
            <div class="like-container">
                <button class="like-button"data-id="${remark2.id}" data-zan="${remark2.zan}">
                    <span class="like-icon"></span>
                    <span class="like-count">${remark2.zan}</span>
                </button>
            </div>
        </div>
    </c:forEach>
</div>
</div>
<form class="layui-form" id="remarkForm">
    <input type="hidden" name="pid" value="${photo.id}">
    <input type="hidden" name="uname" value="${name}">
    <div class="layui-form-item">
        <div class="shuru">
            <input type="text" name="remark" required placeholder="发表您的看法吧！"
                   autocomplete="off" class="layui-input">
            <button class="layui-btn layui-btn-normal" lay-submit lay-filter="remark">发送</button>
        </div>
    </div>
</form>
</div>
<script src="static/layui.js"></script>
<script>
    setTimeout(() => {
        const headings = document.querySelectorAll('#viewer h1, #viewer h2, #viewer h3');
        const tocList = document.getElementById('tocList');
        tocList.innerHTML = '';

        headings.forEach((heading, index) => {
            const tag = heading.tagName.toLowerCase();
            const text = heading.textContent;
            const id = `heading-${index}`;
            heading.id = id;

            const li = document.createElement('li');
            if (tag === 'h2') li.style.marginLeft = '20px';
            else if (tag === 'h3') li.style.marginLeft = '40px';

            const a = document.createElement('a');
            a.href = `#${id}`;
            a.textContent = text;

            li.appendChild(a);
            tocList.appendChild(li);
        });
    }, 100);

</script>
<script>
    // 默认图片路径
    const defaultPhoto = "photo/user2.png";

    // 获取所有图片元素
    const imgElements = document.querySelectorAll(".userPhoto");

    // 遍历所有图片元素
    imgElements.forEach(imgElement => {
        // 获取原始的 src 属性
        const src = imgElement.getAttribute("src");

        // 检查 src 是否为空或无效路径
        if (!src || src.trim() === "") {
            // 如果 src 是空的，设置默认图片
            imgElement.src = defaultPhoto;
        } else {
            // 如果 src 不为空，检查图片是否加载成功
            const img = new Image(); // 创建一个新的 Image 对象
            img.src = src; // 设置图片路径

            // 监听图片加载失败事件
            img.onerror = () => {
                // 如果图片加载失败，设置默认图片
                imgElement.src = defaultPhoto;
            };
        }
    });
</script>
<script>
    layui.use(['form', 'layer', 'jquery'], function () {
        var form = layui.form;
        var layer = layui.layer;
        var $ = layui.jquery;

        form.on('submit(remark)', function (data) {
            $.ajax({
                url: 'talk',
                type: 'POST',
                data: data.field,
                dataType: 'json',
                success: function (res) {
                    if (res.success) {
                        location.reload();
                    } else {
                        layer.msg('注册失败: ' + res.message, { icon: 2 });
                    }
                },
                error: function (error) {
                    console.error('Error:', error);
                    layer.msg('网络请求出错', { icon: 2 });
                }
            });
            return false;
        });
        document.addEventListener('DOMContentLoaded', function () {
            const img = document.querySelector('img');
            if (img.src.trim() === null) {
                img.style.display = 'none'; // 如果 src 是空值，直接隐藏图片
            }
        });
        $(document).ready(function () {
            $('.like-button').each(function () {
                var $this = $(this);
                var $likeCountSpan = $this.find('.like-count');
                var likeCount = parseInt($likeCountSpan.text());
                if (isNaN(likeCount)) {
                    likeCount = 0;
                }
                var isLiked = false;

                $this.on('click', function () {
                    if (isLiked) {
                        likeCount--;
                        $this.data('zan', likeCount);
                        $this.removeClass('liked');
                    } else {
                        likeCount++;
                        $this.data('zan', likeCount);
                        $this.addClass('liked');
                    }
                    $likeCountSpan.text(likeCount);
                    isLiked = !isLiked;
                    var commentId = $this.data('id');
                    var count=$this.data('zan');
                    $.ajax({
                        url: 'Zan',
                        method: 'POST',
                        data: { id: commentId,count:count },
                        success: function (res) {

                        },
                        error: function () {
                            alert('网络错误');
                        }
                    });
                });
            });
        });
    });
</script>
<!-- 引入完整版本的 JS -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script>
    const post = {
        title: " ${photo.title}",
        content: ` ${photo.wz}
`
    };

    document.getElementById('postTitle').innerText = post.title;


    const viewer = toastui.Editor.factory({
        el: document.querySelector('#viewer'),
        viewer: true,
        initialValue: post.content
    });
</script>
</body>
</html>