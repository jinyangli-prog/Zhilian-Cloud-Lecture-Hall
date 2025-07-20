<%--
  Created by IntelliJ IDEA.
  User: 李金阳
  Date: 2025/4/16
  Time: 9:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="static/css/layui.css">
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <style>
        .dashboard-card {
            margin-bottom: 20px;
            border-radius: 4px;
            overflow: hidden;
        }
        .card-icon {
            width: 80px;
            height: 80px;
            line-height: 80px;
            text-align: center;
            font-size: 40px;
            color: #fff;
            float: left;
        }
        .card-content {
            margin-left: 90px;
            padding-top: 10px;
        }
        .card-num {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .card-title {
            color: #999;
            font-size: 14px;
        }
        .bg1 { background-color: #2d8cf0; }
        .bg2 { background-color: #64d572; }
        .bg3 { background-color: #f25e43; }
        .bg4 { background-color: #e9a745; }
        .color1 { color: #2d8cf0; }
        .color2 { color: #64d572; }
        .color3 { color: #f25e43; }
        .color4 { color: #e9a745; }
        .chart-container {
            height: 400px;
            margin-bottom: 20px;
        }
        .map-container {
            height: 350px;
        }
        .card-header {
            padding: 10px;
            margin-bottom: 15px;
            border-bottom: 1px solid #f2f2f2;
        }
        .card-header-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .card-header-desc {
            font-size: 14px;
            color: #999;
        }
        .timeline-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px dashed #eee;
        }
        .timeline-content {
            flex: 1;
        }
        .timeline-time {
            color: #999;
            font-size: 12px;
        }
        .timeline-desc {
            color: #787878;
            font-size: 12px;
            margin-top: 5px;
        }
        .rank-item {
            display: flex;
            margin-bottom: 15px;
            align-items: center;
        }
        .rank-avatar {
            width: 36px;
            height: 36px;
            line-height: 36px;
            text-align: center;
            background: #f2f2f2;
            border-radius: 50%;
            margin-right: 10px;
        }
        .rank-content {
            flex: 1;
        }
        .rank-title {
            display: flex;
            justify-content: space-between;
            margin-bottom: 5px;
        }
        .rank-value {
            color: #999;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <!-- 顶部卡片 -->
        <div class="layui-col-md3">
            <div class="layui-card dashboard-card">
                <div class="card-icon bg1">
                    <i class="layui-icon layui-icon-user"></i>
                </div>
                <div class="card-content">
                    <div class="card-num color1">${ucount}</div>
                    <div class="card-title">用户访问量</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card dashboard-card">
                <div class="card-icon bg2">
                    <i class="layui-icon layui-icon-notice"></i>
                </div>
                <div class="card-content">
                    <div class="card-num color2">168</div>
                    <div class="card-title">系统消息</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card dashboard-card">
                <div class="card-icon bg3">
                    <i class="layui-icon layui-icon-cart"></i>
                </div>
                <div class="card-content">
                    <div class="card-num color3">${zcount}</div>
                    <div class="card-title">作品数量</div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card dashboard-card">
                <div class="card-icon bg4">
                    <i class="layui-icon layui-icon-form"></i>
                </div>
                <div class="card-content">
                    <div class="card-num color4">20</div>
                    <div class="card-title">今日作品量</div>
                </div>
            </div>
        </div>

        <!-- 中间图表行 -->
        <div class="layui-col-md18">
            <div class="layui-card">
                <div class="card-header">
                    <div class="card-header-title">作品动态</div>
                    <div class="card-header-desc">最近一周作品状态，包括解答量和文章量</div>
                </div>
                <div class="layui-card-body">
                    <div id="worksChart" style="width: 100%; height: 400px;"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md7">
            <div class="layui-card">
                <div class="card-header">
                    <div class="card-header-title">排行榜</div>
                    <div class="card-header-desc">热门问题排行榜</div>
                </div>
                <div class="layui-card-body">
                    <div class="rank-item">
                        <div class="rank-avatar">1</div>
                        <div class="rank-content">
                            <div class="rank-title">
                                <div>${categories[3]}</div>
                                <div class="rank-value">作品量：${values[3]}</div>
                            </div>
                            <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                <div class="layui-progress-bar" lay-percent="${percentages[3]}%" style="background-color: #f25e43;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="rank-item">
                        <div class="rank-avatar">2</div>
                        <div class="rank-content">
                            <div class="rank-title">
                                <div>${categories[2]}</div>
                                <div class="rank-value">作品量：${values[2]}</div>
                            </div>
                            <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                <div class="layui-progress-bar" lay-percent="${percentages[2]}%" style="background-color: #00bcd4;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="rank-item">
                        <div class="rank-avatar">3</div>
                        <div class="rank-content">
                            <div class="rank-title">
                                <div>${categories[1]}</div>
                                <div class="rank-value">作品量：${values[1]}</div>
                            </div>
                            <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                <div class="layui-progress-bar" lay-percent="${percentages[1]}%" style=" background-color: #64d572;"></div>
                            </div>
                        </div>
                    </div>
                    <div class="rank-item">
                        <div class="rank-avatar">4</div>
                        <div class="rank-content">
                            <div class="rank-title">
                                <div>${categories[0]}</div>
                                <div class="rank-value">作品量：${values[0]}</div>
                            </div>
                            <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                                <div class="layui-progress-bar" lay-percent="${percentages[0]}%" style="background-color: #e9a745;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="static/layui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script>
    window.onload = function() {

        var worksChart = echarts.init(document.getElementById('worksChart'));


        var option = {
            tooltip: {
                trigger: 'axis',
                formatter: '{b}<br/>{a0}: {c0}篇<br/>{a1}: {c1}个'
            },
            legend: {
                data: ['文章量', '解答量'],
                right: 20
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                type: 'category',
                boundaryGap: false,
                data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
                axisLine: {
                    lineStyle: {
                        color: '#999'
                    }
                },
                axisLabel: {
                    color: '#666'
                }
            },
            yAxis: {
                type: 'value',
                axisLine: {
                    show: true,
                    lineStyle: {
                        color: '#999'
                    }
                },
                axisLabel: {
                    color: '#666'
                },
                splitLine: {
                    lineStyle: {
                        type: 'dashed',
                        color: '#eee'
                    }
                }
            },
            series: [
                {
                    name: '文章量',
                    type: 'line',
                    smooth: true,
                    symbol: 'circle',
                    symbolSize: 8,
                    itemStyle: {
                        color: '#2d8cf0',
                        borderColor: '#fff',
                        borderWidth: 2
                    },
                    lineStyle: {
                        width: 3,
                        color: '#2d8cf0'
                    },
                    areaStyle: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: 'rgba(45, 140, 240, 0.3)' },
                            { offset: 1, color: 'rgba(45, 140, 240, 0.1)' }
                        ])
                    },
                    data: [45, 52, 38, 65, 49, 72, 60]
                },
                {
                    name: '解答量',
                    type: 'line',
                    smooth: true,
                    symbol: 'circle',
                    symbolSize: 8,
                    itemStyle: {
                        color: '#64d572',
                        borderColor: '#fff',
                        borderWidth: 2
                    },
                    lineStyle: {
                        width: 3,
                        color: '#64d572'
                    },
                    areaStyle: {
                        color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: 'rgba(100, 213, 114, 0.3)' },
                            { offset: 1, color: 'rgba(100, 213, 114, 0.1)' }
                        ])
                    },
                    data: [120, 132, 101, 134, 90, 230, 210]
                }
            ]
        };


        worksChart.setOption(option);


        window.addEventListener('resize', function() {
            worksChart.resize();
        });
    };
</script>
</body>
</html>
