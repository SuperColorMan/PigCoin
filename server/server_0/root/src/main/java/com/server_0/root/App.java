package com.server_0.root;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.util.WebAppRootListener;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;

@SpringBootApplication
@ComponentScan(basePackages = {
        "com.server_0.controller",
        "com.server_0.shop",
        "com.server_0.root",
        "com.server_0.dao",
        "com.server_0.service",
        "com.server_0.comm",
        "com.server_0.queue",
        "com.server_0.im",
        "com.server_0.cal"
})
@MapperScan(basePackages = {
        "com.server_0.dao",
})
@EnableScheduling
public class App implements ServletContextInitializer {

    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }

    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        // 大小
        long webSocketSize = 52428800*5;
        servletContext.addListener(WebAppRootListener.class);
        servletContext.setInitParameter("org.apache.tomcat.websocket.textBufferSize", String.valueOf(webSocketSize));
    }
}
