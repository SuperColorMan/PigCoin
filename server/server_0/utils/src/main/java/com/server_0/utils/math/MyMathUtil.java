package com.server_0.utils.math;

import java.util.Random;

/**
 * @ClassName MyMathUtil
 * @Description 数学工具类
 * @Author SuperColorMan
 * @Date 2021/1/16 8:04 下午
 * @ModifyDate 2021/1/16 8:04 下午
 * @Version 1.0
 */
public class MyMathUtil {
    /**
     * 获取指定位数随机数
     */
    public static String getRandomNumByLength(int len) {
        Random r = new Random();
        StringBuilder rs = new StringBuilder();
        for (int i = 0; i < len; i++) {
            rs.append(r.nextInt(10));
        }
        return rs.toString();
    }
}
