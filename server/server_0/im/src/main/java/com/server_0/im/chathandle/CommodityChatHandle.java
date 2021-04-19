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
 * @ClassName CommodityChatHandle
 * @Description 商品私信处理
 * @Author SuperColorMan
 * @Date 2021/2/20 4:52 下午
 * @ModifyDate 2021/2/20 4:52 下午
 * @Version 1.0
 */
@Component
public class CommodityChatHandle {
    private static ChatService chatService;
    private static TImChatContentDao tImChatContentDao;
    private static TImChatImageDao tImChatImageDao;

    @Autowired
    public CommodityChatHandle(TImChatContentDao tImChatContentDao,
                               ChatService chatService,
                               TImChatImageDao tImChatImageDao) {
        CommodityChatHandle.tImChatContentDao = tImChatContentDao;
        CommodityChatHandle.chatService = chatService;
        CommodityChatHandle.tImChatImageDao = tImChatImageDao;
    }

    public static void handle(Map chatParam, Session toSession) {
        try {
            Long userId = Long.parseLong(chatParam.get("userId").toString());
            Long byUserId = Long.parseLong(chatParam.get("byUserId").toString());
            /// 商品id列表,格式:[id,id,id,id,id,id]
            String commodityIdArr = chatParam.get("content").toString();
            // -------------- 上传私信内容 start --------------
            TImChatContent tImChatContent = new TImChatContent();
            tImChatContent.setUserId(userId);
            tImChatContent.setByUserId(byUserId);
            tImChatContent.setBody("");
            tImChatContent.setType(String.valueOf(ChatContentTypeEnum.COMMODITY.getType()));
            tImChatContentDao.insertSelective(tImChatContent);
            // -------------- 上传私信内容 end --------------
            ChatModel chatModel = new ChatModel();
            chatModel.setType(String.valueOf(ChatContentTypeEnum.COMMODITY.getType()));
            Object obj = JSONObject.toJSON(chatModel);
            String messageJson = obj.toString();
            toSession.getBasicRemote().sendText(messageJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
