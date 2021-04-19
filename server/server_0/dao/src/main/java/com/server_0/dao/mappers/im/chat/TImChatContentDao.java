package com.server_0.dao.mappers.im.chat;


import com.server_0.dao.entity.im.chat.TImChatContent;

public interface TImChatContentDao {
    int deleteByPrimaryKey(Long id);

    int insert(TImChatContent record);

    int insertSelective(TImChatContent record);

    TImChatContent selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TImChatContent record);

    int updateByPrimaryKey(TImChatContent record);
}