package com.server_0.comm.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @ClassName FileConfigProperties
 * @Description 文件配置参数
 * @Author SuperColorMan
 * @Date 2020/6/3 3:27 下午
 * @ModifyDate 2020/6/3 3:27 下午
 * @Version 1.0
 */
@Component
@ConfigurationProperties(prefix = "file-config")
@Data
public class FileConfigProperties {
    /**
     * 水印图片路径
     */
    private String waterMarkPath;
    /**
     * 用户默认头像路径
     */
    private String userDefaultHeadImgPath;
    /**
     * 内容图片为空显示图片
     */
    private String contentDefaultImgPath;
}
