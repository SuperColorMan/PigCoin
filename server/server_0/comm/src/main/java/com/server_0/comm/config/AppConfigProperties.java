package com.server_0.comm.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @ClassName AppConfigProperties
 * @Description 应用相关配置
 * @Author SuperColorMan
 * @Date 2021/1/16 7:59 下午
 * @ModifyDate 2021/1/16 7:59 下午
 * @Version 1.0
 */
@Component
@ConfigurationProperties(prefix = "app-config")
@Data
public class AppConfigProperties {
    /**
     * app名称
     */
    private String name;
}
