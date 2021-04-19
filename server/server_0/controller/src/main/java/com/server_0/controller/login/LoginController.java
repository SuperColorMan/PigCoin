package com.server_0.controller.login;

import com.server_0.comm.web.ServerResponse;
import com.server_0.service.login.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @ClassName LoginController
 * @Description 登录与注册控制器
 * @Author SuperColorMan
 * @Date 2021/1/7 5:23 下午
 * @ModifyDate 2021/1/7 5:23 下午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/login/")
public class LoginController {
    @Autowired
    LoginService loginService;

    /**
     * 注册
     */
    @PostMapping("register")
    public ServerResponse register(String account, String pass, String uid) {
        return loginService.register(account, pass, uid);
    }

    /**
     * 登录
     */
    @PostMapping("login")
    public ServerResponse login(String account, String pass) {
        return loginService.login(account, pass);
    }
}
