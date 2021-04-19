package com.server_0.controller.comm;

import com.server_0.comm.web.ServerResponse;
import com.server_0.service.comm.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName CommController
 * @Description 公共控制器
 * @Author SuperColorMan
 * @Date 2021/1/27 10:54 上午
 * @ModifyDate 2021/1/27 10:54 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/comm/")
public class CommController {
    @Autowired
    SystemService systemService;
    /**
     * 获取系统内容分类规则
     */
    @PostMapping("getContentType")
    public ServerResponse getContentType() {
        return systemService.getContentType();
    }

    /**
     * 获取系统图片分类规则
     */
    @PostMapping("getImgType")
    public ServerResponse getImgType() {
        return systemService.getImgType();
    }
}
