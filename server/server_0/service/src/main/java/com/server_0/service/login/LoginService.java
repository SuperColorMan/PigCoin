package com.server_0.service.login;


import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName LoginService
 * @Description 登录注册服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/8 10:25 下午
 * @ModifyDate 2021/1/8 10:25 下午
 * @Version 1.0
 */
public interface LoginService {
    /**
     * 注册
     */
    ServerResponse register(String account, String pass, String uid);

    /**
     * 登录
     */
    ServerResponse login(String account, String pass);
}
