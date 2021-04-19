package com.server_0.im.service.chat;

import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.dao.entity.im.chat.TImChatImage;
import org.springframework.stereotype.Service;

/**
 * @ClassName ChatService
 * @Description 私信服务类
 * @Author SuperColorMan
 * @Date 2021/2/20 5:40 下午
 * @ModifyDate 2021/2/20 5:40 下午
 * @Version 1.0
 */
public interface ChatService {
    /**
     * 单独上传基于Base64
     */
    TImChatImage imgUpLoadByOnleyAndBase64(
            String file,
            Long chatId,
            Long userId);
}
