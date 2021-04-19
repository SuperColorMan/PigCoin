package com.server_0.im.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

/**
 * @ClassName WebSocketConfig
 * @Description WS配置类
 * @Author SuperColorMan
 * @Date 2021/1/15 10:11 上午
 * @ModifyDate 2021/1/15 10:11 上午
 * @Version 1.0
 */
@Configuration
public class WebSocketConfig {
    /**
     * 注入一个ServerEndpointExporter,该Bean会自动注册使用@ServerEndpoint注解申明的websocket endpoint
     */
    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }
}
