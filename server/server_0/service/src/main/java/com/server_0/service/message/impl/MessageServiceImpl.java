package com.server_0.service.message.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.message.TMessMessage;
import com.server_0.dao.mappers.message.TMessMessageDao;
import com.server_0.service.message.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName MessageServiceImpl
 * @Description 消息服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/2/18 10:54 上午
 * @ModifyDate 2021/2/18 10:54 上午
 * @Version 1.0
 */
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    TMessMessageDao tMessMessageDao;
    /**
     * 获取指定用户的消息列表
     * */
    @Override
    public ServerResponse getMessageByUserId(Long userId,Long loginUserId) {
        // 用户消息列表
        List<TMessMessage> userMessageList=tMessMessageDao.getMessageByUserId(userId,loginUserId);
        return ServerResponse.success("ok", userMessageList);
    }
}
