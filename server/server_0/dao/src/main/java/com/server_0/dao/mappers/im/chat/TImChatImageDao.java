package com.server_0.dao.mappers.im.chat;


import com.server_0.dao.entity.im.chat.TImChatImage;
import org.apache.ibatis.annotations.Param;

public interface TImChatImageDao {
    int deleteByPrimaryKey(Long id);

    int insert(TImChatImage record);

    int insertSelective(TImChatImage record);

    TImChatImage selectByPrimaryKey(Long id);

    TImChatImage selectBychatId(@Param("chatId") Long chatId);

    int updateByPrimaryKeySelective(TImChatImage record);

    int updateByPrimaryKey(TImChatImage record);
}