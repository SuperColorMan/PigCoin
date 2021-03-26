package com.pigcoin.community.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @ClassName IndexController
 * @Description This is Index Page Controller
 * @Author SuperColorMan
 * @Date 2021/3/26 10:48 上午
 * @ModifyDate 2021/3/26 10:48 上午
 * @Version 1.0
 */
@Controller
public class IndexController {
    @GetMapping("/")
    public String index() {
        return "/index/index";
    }
}
