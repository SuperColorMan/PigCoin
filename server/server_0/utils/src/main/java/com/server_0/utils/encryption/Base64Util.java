package com.server_0.utils.encryption;


import org.apache.commons.codec.binary.Base64;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

/**
 * @ClassName Base64Util
 * @Description Base64工具
 * @Author SuperColorMan
 * @Date 2021/1/23 5:30 下午
 * @ModifyDate 2021/1/23 5:30 下午
 * @Version 1.0
 */
public class Base64Util {


    /**
     * 将base64字符串转换为byte数组
     */
    public static byte[] str2ByteArray(String input) {
        return Base64.decodeBase64(input);
    }

    /**
     * 将base64字符串转换为文件读流
     */
    public static ByteArrayInputStream str2Input(String input) {
        byte[] bytes = str2ByteArray(input);
        ByteArrayInputStream in = new ByteArrayInputStream(bytes);
        return in;
    }

    /**
     * 将文件读流转换成Base64编码
     */
    public static String input2Base64(InputStream in) {
        String base64 = null;
        try {
            byte[] bytes = new byte[in.available()];
            int length = in.read(bytes);
            base64 = Base64.encodeBase64String(bytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return base64;
    }


}
