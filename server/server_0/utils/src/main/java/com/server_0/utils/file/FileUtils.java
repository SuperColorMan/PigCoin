package com.server_0.utils.file;

import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;

/**
 * @ClassName FileUtils
 * @Description 文件工具
 * @Author SuperColorMan
 * @Date 2020/6/2 9:50 上午
 * @ModifyDate 2020/6/2 9:50 上午
 * @Version 1.0
 */
public class FileUtils {

    /**
     * ------------------------
     * 保存文件
     * ------------------------
     *
     * @param in   文件读流
     * @param path 文件的保存路径,包含文件文件名
     */
    public static boolean saveFile(InputStream in, String path) {
        try {
            // io流
            FileOutputStream outPut = new FileOutputStream(new File(path));
            FileInputStream inPut = (FileInputStream) in;
            // 管道
            FileChannel inChannel = inPut.getChannel();
            FileChannel outChannel = outPut.getChannel();
            // 缓冲区
            ByteBuffer byteBuffer = ByteBuffer.allocateDirect(1024);
            while (true) {
                int eof = inChannel.read(byteBuffer);
                if (eof == -1) {
                    break;
                }
                byteBuffer.flip();
                outChannel.write(byteBuffer);
                byteBuffer.clear();
            }
            inChannel.close();
            outChannel.close();
            System.gc();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean saveImgFile(ByteArrayInputStream inPut, String path) {
        try {
            OutputStream outPut = new FileOutputStream(new File(path));
            int len = 0;
            int bufSize = 1024 * 2;
            byte[] bArr = new byte[bufSize];
            while ((len = inPut.read(bArr)) != -1) {
                outPut.write(bArr, 0, len);
            }
            inPut.close();
            outPut.close();
            inPut = null;
            outPut = null;
            System.gc();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
