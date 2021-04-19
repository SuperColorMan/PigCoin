package com.server_0.im.comm;


import javax.websocket.Session;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * @ClassName GlobalConstant
 * @Description 全局常量类
 * @Author SuperColorMan
 * @Date 2021/1/15 10:20 上午
 * @ModifyDate 2021/1/15 10:20 上午
 * @Version 1.0
 */
public class GlobalConstant {
    /**
     * 即时通信连接句柄池,必须保证线程安全
     */
    public static Map<String,Session> IM_CONNECT_POOL = new ConcurrentHashMap<String, Session>();
}
