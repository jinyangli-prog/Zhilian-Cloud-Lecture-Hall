<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>talk</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <style>
        body {
            margin: 0;
            overflow-y: auto;
            overflow-x:hidden;
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
<a href="shouye?name=${name}"  class="px-4 py-1 rounded-full bg-blue-100 text-blue-700 hover:bg-blue-200" style="font-size: 20px;color: #00bcd4">返回</a>
<h3 style="font-size: 30px">${photo.title}</h3>
<p style="font-size: 20px;margin-top: 15px">${photo.wz}</p>
<img src="${photo.uphoto}" style="width: 600px;height: 350px;" onerror="this.style.display='none';"/>
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
<script src="static/layui.js"></script>
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

</body>
</html>