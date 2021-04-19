package com.server_0.im.model;

import com.server_0.dao.entity.im.chat.TImChatImage;
import com.server_0.dao.entity.shop.TShopCommodity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName ChatModel
 * @Description 私信数据模型
 * @Author SuperColorMan
 * @Date 2021/2/20 5:16 下午
 * @ModifyDate 2021/2/20 5:16 下午
 * @Version 1.0
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatModel {
    /**
     * 发送者用户id
     */
    String userId;

    /**
     * 发送对方用户id
     */
    String byUserId;

    /**
     * 内容类型
     */
    String type;

    /**
     * 内容
     */
    String content;

    /**
     * 图片信息
     */
    TImChatImage tImChatImage;

    /**
     * 商品信息
     */
    TShopCommodity tShopCommodity;

}
