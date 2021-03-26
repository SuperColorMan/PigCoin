package com.pigcoin.root;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication 
@ComponentScan(basePackages = {
        "org.pigcoin.controller"
})
//@MapperScan(basePackages = {
//        "org.pigcoin.dao",
//})
public class RootApplication {

    public static void main(String[] args) {
        SpringApplication.run(RootApplication.class, args);
    }

}
