package com.server_0.service.message;

import com.server_0.comm.web.ServerResponse;

/**
 * @ClassName MessageService
 * @Description 消息服务层接口
 * @Author SuperColorMan
 * @Date 2021/2/18 10:53 上午
 * @ModifyDate 2021/2/18 10:53 上午
 * @Version 1.0
 */
public interface MessageService {
    /**
     * 获取指定用户的消息列表
     * */
    ServerResponse getMessageByUserId(Long userId,Long loginUserId);
}
