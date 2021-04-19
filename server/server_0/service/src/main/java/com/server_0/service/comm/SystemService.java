package com.server_0.service.comm;

import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName SystemService
 * @Description 该后台系统相关服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/27 10:54 上午
 * @ModifyDate 2021/1/27 10:54 上午
 * @Version 1.0
 */
public interface SystemService {
    /**
     * 获取系统内容分类规则
     */
    ServerResponse getContentType();

    /**
     * 获取系统图片分类规则
     */
    ServerResponse getImgType();
}
