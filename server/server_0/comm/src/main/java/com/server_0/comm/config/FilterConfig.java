package com.server_0.comm.config;

import com.server_0.comm.filters.OverAllFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @ClassName FilterConfig
 * @Description 过滤器配置
 * @Author SuperColorMan
 * @Date 2020/6/5 11:39 上午
 * @ModifyDate 2020/6/5 11:39 上午
 * @Version 1.0
 */
@Configuration
public class FilterConfig {
    @Bean
    public FilterRegistrationBean registFilter() {
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(new OverAllFilter());
        registration.addUrlPatterns("/*");
        registration.setName("LogCostFilter");
        registration.setOrder(1);
        return registration;
    }
}