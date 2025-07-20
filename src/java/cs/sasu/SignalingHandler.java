package cs.sasu;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
@ComponentScan(basePackages = "cs.sasu")
@Component
@EnableWebSocket
public class SignalingHandler extends TextWebSocketHandler {

    private final Map<String, WebSocketSession> sessions = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();

    private String getUserId(WebSocketSession session) {
        String uri = session.getUri().toString();
        return uri.substring(uri.lastIndexOf("=") + 1);
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        try {
            String userId = getUserId(session);
            sessions.put(userId, session);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) {
        try {
            JsonNode json = objectMapper.readTree(message.getPayload());
            String to = json.get("to").asText();

            WebSocketSession target = sessions.get(to);
            if (target != null && target.isOpen()) {
                target.sendMessage(new TextMessage(message.getPayload()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        try {
            String userId = getUserId(session);
            sessions.remove(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}