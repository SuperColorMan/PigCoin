package com.server_0.im.chathandle;

import com.alibaba.fastjson.JSONObject;
import com.server_0.comm.enums.ChatContentTypeEnum;
import com.server_0.dao.entity.im.chat.TImChatContent;
import com.server_0.dao.mappers.im.chat.TImChatContentDao;
import com.server_0.dao.mappers.im.chat.TImChatImageDao;
import com.server_0.im.model.ChatModel;
import com.server_0.im.service.chat.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.websocket.Session;
import java.io.IOException;
import java.util.Map;

/**
 * @ClassName TextChatHandle
 * @Description 文本私信处理
 * @Author SuperColorMan
 * @Date 2021/2/20 4:51 下午
 * @ModifyDate 2021/2/20 4:51 下午
 * @Version 1.0
 */
@Component
public class TextChatHandle {

    private static ChatService chatService;
    private static TImChatContentDao tImChatContentDao;
    private static TImChatImageDao tImChatImageDao;

    @Autowired
    public TextChatHandle(TImChatContentDao tImChatContentDao,
                          ChatService chatService,
                          TImChatImageDao tImChatImageDao) {
        TextChatHandle.tImChatContentDao = tImChatContentDao;
        TextChatHandle.chatService = chatService;
        TextChatHandle.tImChatImageDao = tImChatImageDao;
    }

    public static void handle(Map chatParam, Session toSession) {
        try {
            Long userId = Long.parseLong(chatParam.get("userId").toString());
            Long byUserId = Long.parseLong(chatParam.get("byUserId").toString());
            /// 文字信息
            String content = chatParam.get("content").toString();
            // -------------- 上传私信内容 start --------------
            TImChatContent tImChatContent = new TImChatContent();
            tImChatContent.setUserId(userId);
            tImChatContent.setByUserId(byUserId);
            tImChatContent.setBody(content);
            tImChatContent.setType(String.valueOf(ChatContentTypeEnum.TEXT.getType()));
            tImChatContentDao.insertSelective(tImChatContent);
            // -------------- 上传私信内容 end --------------
            ChatModel chatModel = new ChatModel();
            chatModel.setUserId(userId.toString());
            chatModel.setByUserId(byUserId.toString());
            chatModel.setType(String.valueOf(ChatContentTypeEnum.TEXT.getType()));
            chatModel.setContent(content);
            Object obj = JSONObject.toJSON(chatModel);
            String messageJson = obj.toString();
            toSession.getBasicRemote().sendText(messageJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
