<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>进入会议室</title>
  <style>
    body {
      font-family: sans-serif;
      background-color: #f0f0f0;
      text-align: center;
    }
    .card {
      margin-top: 10%;
      padding: 2rem;
      background: white;
      border-radius: 1rem;
      display: inline-block;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    input, button {
      margin: 0.5rem;
      padding: 0.5rem;
      font-size: 1rem;
    }
    .video-container {
      display: flex;
      justify-content: center;
      gap: 1rem;
      margin-top: 2rem;
    }
    video {
      width: 45%;
      border-radius: 1rem;
      border: 1px solid #ccc;
    }
    .controls {
      margin-top: 1rem;
    }

  </style>
</head>
<body>
<div class="card">
<h2>欢迎进入会议</h2>
<form action="room" method="get">
  <input type="text" name="user" placeholder="你的名字" required />
  <input type="text" name="to" placeholder="对方名字" required />
  <button type="submit">开始</button>
</form>
</div>
</body>
</html>
