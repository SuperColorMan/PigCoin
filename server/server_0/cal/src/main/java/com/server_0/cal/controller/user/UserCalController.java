package com.server_0.cal.controller.user;

import com.server_0.comm.web.ServerResponse;
import com.server_0.service.cal.user.UserCalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName UserCalController
 * @Description 用户计算控制器
 * @Author SuperColorMan
 * @Date 2021/1/12 2:33 下午
 * @ModifyDate 2021/1/12 2:33 下午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/cal/user/")
public class UserCalController {
    @Autowired
    UserCalService userCalService;

    /**
     * 获取指定用户今日增量数据
     * */
    @PostMapping("getToDatInfoByUserId")
    public ServerResponse getToDatInfoByUserId(Long userId) {
        return userCalService.getToDatInfoByUserId(userId);
    }
}
