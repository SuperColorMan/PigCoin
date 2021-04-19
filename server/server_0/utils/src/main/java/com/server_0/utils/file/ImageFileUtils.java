package com.server_0.utils.file;


import com.server_0.dao.entity.img.TImgInfo;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * @ClassName ImageFileUtils
 * @Description 图片文件工具
 * @Author SuperColorMan
 * @Date 2020/6/6 2:24 上午
 * @ModifyDate 2020/6/6 2:24 上午
 * @Version 1.0
 */
public class ImageFileUtils {
    /**
     * ------------------------
     * 文件获取器
     * ------------------------
     *
     * @param file  图片文件对象
     * @param spon 图片流输出响应对象
     */
    public static void getFile(File file,
                               HttpServletResponse spon) throws IOException {
        FileInputStream in = new FileInputStream(file);
        OutputStream out = spon.getOutputStream();
        byte[] bS = new byte[1024];
        int len = 0;
        while ((len = in.read(bS)) != -1) {
            out.write(bS, 0, len);
        }
        out.flush();
        out.close();
    }
}
