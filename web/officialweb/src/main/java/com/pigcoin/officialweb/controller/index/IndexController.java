package com.pigcoin.officialweb.controller.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @ClassName IndexController
 * @Description Home page controller
 * @Author SuperColorMan
 * @Date 2021/3/25 3:53 下午
 * @ModifyDate 2021/3/25 3:53 下午
 * @Version 1.0
 */
@Controller
public class IndexController {

    @GetMapping("/")
    public String index() {
        return "/index/index";
    }
}
