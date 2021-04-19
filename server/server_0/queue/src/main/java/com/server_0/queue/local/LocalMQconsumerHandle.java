package com.server_0.queue.local;

import com.server_0.comm.callback.QueueCallBack;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * @ClassName LocalMQconsumerHandle
 * @Description 本地消息队列消费处理
 * @Author SuperColorMan
 * @Date 2021/1/4 3:06 下午
 * @ModifyDate 2021/1/4 3:06 下午
 * @Version 1.0
 */
@Component
public class LocalMQconsumerHandle {
    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(LocalMQconsumerHandle.class);

    /**
     * 处理
     */
    public static void handle(QueueCallBack callBack) {
        // 处理回调
        callBack.callBack();
    }
}
