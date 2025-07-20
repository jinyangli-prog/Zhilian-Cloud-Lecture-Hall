<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>视频会议室</title>
  <style>
    body {
      font-family: sans-serif;
      background-color: #f0f0f0;
      text-align: center;
    }
    .video-conference-card {
      margin-top: 10%;
      padding: 2rem;
      background: white;
      border-radius: 1rem;
      display: inline-block;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    .input-button-group input,
    .input-button-group button {
      margin: 0.5rem;
      padding: 0.5rem;
      font-size: 1rem;
    }
    .video-display-container {
      display: flex;
      justify-content: center;
      gap: 1rem;
      margin-top: 2rem;
    }
    .video-display-container video {
      width: 45%;
      border-radius: 1rem;
      border: 1px solid #ccc;
    }
    .control-buttons {
      margin-top: 1rem;
    }
  </style>
</head>
<body>
<h2>视频会议中</h2>
<div class="video-conference-card">
  <div class="video-display-container">
    <video id="localVideo" autoplay muted></video>
    <video id="remoteVideo" autoplay></video>
  </div>
  <div class="control-buttons">
    <button onclick="startCall()">📞 发起通话</button>
    <button onclick="shareScreen()">🖥️ 共享屏幕</button>
  </div>
</div>

<script>
    const localVideo = document.getElementById("localVideo");
    const remoteVideo = document.getElementById("remoteVideo");

    const urlParams = new URLSearchParams(window.location.search);
    const user = urlParams.get('user') || "1";
    const to = urlParams.get('to') || "2";

    const ws = new WebSocket(`ws://localhost:8080/dayquestions/dayquestions/signal?user=${user}`);
    ws.onopen = function() {
        console.log('WebSocket 连接已打开');
    };

    ws.onerror = function(error) {
        console.error('WebSocket 连接出错:', error);

    };

    ws.onclose = function(event) {
        console.log('WebSocket 连接已关闭');
    };
    const pc = new RTCPeerConnection({
        iceServers: [{ urls: "stun:stun.l.google.com:19302" }]
    });

    let localStream;


    navigator.mediaDevices.getUserMedia({ video: true, audio: true })
        .then(stream => {
            localStream = stream;
            localVideo.srcObject = stream;
            stream.getTracks().forEach(track => pc.addTrack(track, stream));
        })
        .catch(error => {
            console.error('获取本地媒体流失败:', error);
        });


    pc.ontrack = e => remoteVideo.srcObject = e.streams[0];
    pc.onicecandidate = e => {
        if (e.candidate) {
            ws.send(JSON.stringify({ type: "candidate", candidate: e.candidate, to }));
        }
    };

    ws.onmessage = e => {
        const msg = JSON.parse(e.data);
        if (msg.type === "offer") {
            pc.setRemoteDescription(new RTCSessionDescription(msg.offer))
                .then(() => pc.createAnswer())
                .then(answer => {
                    pc.setLocalDescription(answer);
                    ws.send(JSON.stringify({ type: "answer", answer, to }));
                })
                .catch(error => {
                    console.error('处理 offer 消息失败:', error);
                });
        } else if (msg.type === "answer") {
            pc.setRemoteDescription(new RTCSessionDescription(msg.answer))
                .catch(error => {
                    console.error('处理 answer 消息失败:', error);
                });
        } else if (msg.type === "candidate") {
            pc.addIceCandidate(new RTCIceCandidate(msg.candidate))
                .catch(error => {
                    console.error('添加 ICE 候选者失败:', error);
                });
        }
    };

    ws.onopen = () => {
        console.log('WebSocket 连接已打开');
    };

    ws.onerror = error => {
        console.error('WebSocket 连接出错:', error);
    };

    function startCall() {
        pc.createOffer()
            .then(offer => {
                pc.setLocalDescription(offer);
                ws.send(JSON.stringify({ type: "offer", offer, to }));
            })
            .catch(error => {
                console.error('创建 offer 失败:', error);
            });
    }

    function shareScreen() {
        navigator.mediaDevices.getDisplayMedia({ video: true })
            .then(screenStream => {
                const screenTrack = screenStream.getVideoTracks()[0];
                const sender = pc.getSenders().find(s => s.track.kind === "video");
                sender.replaceTrack(screenTrack);
                localVideo.srcObject = screenStream;

                screenTrack.onended = () => {
                    sender.replaceTrack(localStream.getVideoTracks()[0]);
                    localVideo.srcObject = localStream;
                };
            })
            .catch(error => {
                console.error('共享屏幕失败:', error);
            });
    }
</script>
</body>
</html>