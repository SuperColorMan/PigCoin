package com.server_0.im.main;

import com.alibaba.fastjson.JSON;
import com.server_0.comm.enums.ChatContentTypeEnum;
import com.server_0.im.chathandle.CommodityChatHandle;
import com.server_0.im.chathandle.ImageChatHandle;
import com.server_0.im.chathandle.TextChatHandle;
import com.server_0.im.comm.GlobalConstant;
import org.springframework.stereotype.Component;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @ClassName MainImServer
 * @Description 即时通信主服务类
 * @Author SuperColorMan
 * @Date 2021/1/15 10:17 上午
 * @ModifyDate 2021/1/15 10:17 上午
 * @Version 1.0
 */
@ServerEndpoint(value = "/im/server")
@Component
public class MainImServer {
    private static Logger logger = LoggerFactory.getLogger(MainImServer.class);

    /**
     * 记录当前在线连接数
     */
    private static AtomicInteger onlineCount = new AtomicInteger(0);

    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) {
        onlineCount.incrementAndGet(); // 在线数加1
        logger.info("有新连接加入：{}，当前在线人数为：{}", session.getId(), onlineCount.get());
        // 保存连接句柄
        GlobalConstant.IM_CONNECT_POOL.put(session.getId(), session);
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        onlineCount.decrementAndGet(); // 在线数减1
        logger.info("有一连接关闭：{}，当前在线人数为：{}", session.getId(), onlineCount.get());
        // 删除连接句柄
        GlobalConstant.IM_CONNECT_POOL.remove(session.getId());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        logger.info("服务端收到客户端[{}]的消息:{}", session.getId(), message);
        Map sessionMap = JSON.parseObject(message, Map.class);
        if (Integer.parseInt(sessionMap.get("type").toString()) == ChatContentTypeEnum.TEXT.getType()) {
            //纯文字私信
            TextChatHandle.handle(sessionMap, session);
        } else if (Integer.parseInt(sessionMap.get("type").toString()) == ChatContentTypeEnum.LOCALIMG.getType()) {
            //图片私信上传
            ImageChatHandle.handle(sessionMap, session);
        } else if (Integer.parseInt(sessionMap.get("type").toString()) == ChatContentTypeEnum.COMMODITY.getType()) {
            //商品私信
            CommodityChatHandle.handle(sessionMap, session);
        }
    }

    @OnError
    public void onError(Session session, Throwable error) {
        logger.error("发生错误");
        error.printStackTrace();
    }

    /**
     * 服务端发送消息给客户端
     */
    private void sendMessage(String message, Session toSession) {
        try {
            logger.info("服务端给客户端[{}]发送消息{}", toSession.getId(), message);
            toSession.getBasicRemote().sendText(message);
        } catch (Exception e) {
            logger.error("服务端发送消息给客户端失败：{}", e);
        }
    }
}
