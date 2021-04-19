package com.server_0.utils.io;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName IOUtils
 * @Description 读写工具类
 * @Author SuperColorMan
 * @Date 2021/1/6 10:45 上午
 * @ModifyDate 2021/1/6 10:45 上午
 * @Version 1.0
 */
public class IOUtils {

    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(IOUtils.class);

    /**
     * 读取json文件
     * */
    public static String readJsonFile(File jsonFile) {
        if (Objects.isNull(jsonFile)) {
            return "";
        }
        String jsonStr = "";
        try {
            FileReader fileReader = new FileReader(jsonFile);
            Reader reader = new InputStreamReader(new FileInputStream(jsonFile), "utf-8");
            int ch = 0;
            StringBuffer sb = new StringBuffer();
            while ((ch = reader.read()) != -1) {
                sb.append((char) ch);
            }
            fileReader.close();
            reader.close();
            jsonStr = sb.toString();
            return jsonStr;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 文件上传实体与读流转换,数组处理
     */
    public static Map<Integer, InputStream> mFileArr2StreamByArr(MultipartFile[] imgs) {
        Map<Integer, InputStream> inputStreamMap = Maps.newHashMap();
        try {
            for (MultipartFile m : imgs) {
                inputStreamMap.put(m.hashCode(), m.getInputStream());
            }
            return inputStreamMap;
        } catch (Exception e) {
            logger.error("异常:", e);
            return inputStreamMap;
        }
    }

    /**
     * 文件上传实体与读流转换,唯一处理
     */
    public static Map<Integer, InputStream> mFileArr2StreamByOnly(MultipartFile img) {
        Map<Integer, InputStream> inputStreamMap = Maps.newHashMap();
        try {
            inputStreamMap.put(img.hashCode(), img.getInputStream());
            return inputStreamMap;
        } catch (Exception e) {
            logger.error("异常:", e);
            return inputStreamMap;
        }
    }
}
