package com.server_0.im.chathandle;

import com.alibaba.fastjson.JSONObject;
import com.server_0.comm.enums.ChatContentTypeEnum;
import com.server_0.dao.entity.im.chat.TImChatContent;
import com.server_0.dao.entity.im.chat.TImChatImage;
import com.server_0.dao.mappers.im.chat.TImChatContentDao;
import com.server_0.dao.mappers.im.chat.TImChatImageDao;
import com.server_0.im.model.ChatModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.server_0.im.service.chat.ChatService;

import javax.websocket.Session;
import java.io.IOException;
import java.util.Map;

/**
 * @ClassName ImageChatHandle
 * @Description 图片私信处理
 * @Author SuperColorMan
 * @Date 2021/2/20 4:51 下午
 * @ModifyDate 2021/2/20 4:51 下午
 * @Version 1.0
 */
@Component
public class ImageChatHandle {
    private static ChatService chatService;
    private static TImChatContentDao tImChatContentDao;
    private static TImChatImageDao tImChatImageDao;

    @Autowired
    public ImageChatHandle(TImChatContentDao tImChatContentDao,
                           ChatService chatService,
                           TImChatImageDao tImChatImageDao) {
        ImageChatHandle.tImChatContentDao = tImChatContentDao;
        ImageChatHandle.chatService = chatService;
        ImageChatHandle.tImChatImageDao = tImChatImageDao;
    }

    /**
     * 处理图片私信
     *
     * @param chatParam 格式:
     *                  userId:发送者用户id
     *                  byUserId:发送对方用户id
     *                  type:内容类型
     *                  content:内容
     */
    public static void handle(Map chatParam, Session toSession) {
        try {
            Long userId = Long.parseLong(chatParam.get("userId").toString());
            Long byUserId = Long.parseLong(chatParam.get("byUserId").toString());
            // 纯文字内容
            String fileBase64 = chatParam.get("content").toString();
            // -------------- 上传私信内容 start --------------
            TImChatContent tImChatContent = new TImChatContent();
            tImChatContent.setUserId(userId);
            tImChatContent.setByUserId(byUserId);
            tImChatContent.setBody("");
            tImChatContent.setType(String.valueOf(ChatContentTypeEnum.NETIMG.getType()));
            tImChatContentDao.insertSelective(tImChatContent);
            // -------------- 上传私信内容 end --------------
            // -------------- 上传私信图片 start --------------
            TImChatImage tImChatImage = chatService.imgUpLoadByOnleyAndBase64(fileBase64, tImChatContent.getId(), userId);
            // -------------- 上传私信图片 end --------------
            ChatModel chatModel = new ChatModel();
            chatModel.setType(String.valueOf(ChatContentTypeEnum.NETIMG.getType()));
            // 图片信息
            chatModel.setTImChatImage(tImChatImage);
            chatModel.setUserId(userId.toString());
            chatModel.setByUserId(byUserId.toString());
            Object obj = JSONObject.toJSON(chatModel);
            String messageJson = obj.toString();
            toSession.getBasicRemote().sendText(messageJson);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
