package com.server_0.controller.message;

import com.server_0.comm.enums.ContentTypeEnum;
import com.server_0.comm.web.ServerResponse;
import com.server_0.service.message.MessageService;
import com.server_0.utils.id.IDUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName MessageController
 * @Description 消息控制器
 * @Author SuperColorMan
 * @Date 2021/2/18 10:52 上午
 * @ModifyDate 2021/2/18 10:52 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/message/")
public class MessageController {
    @Autowired
    MessageService messageService;

    /**
     * 获取指定用户的消息列表
     */
    @PostMapping("getMessageByUserId")
    public ServerResponse getMessageByUserId(Long userId,Long loginUserId) {
        return messageService.getMessageByUserId(userId,loginUserId);
    }
}
