package com.server_0.utils.img;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

/**
 * @ClassName ImageUtils
 * @Description 图片工具
 * @Author SuperColorMan
 * @Date 2020/6/3 2:23 下午
 * @ModifyDate 2020/6/3 2:23 下午
 * @Version 1.0
 */
public class ImageUtils {
    private static final ClassPathResource resource = new ClassPathResource("");
    private static Logger logger = LoggerFactory.getLogger(ImageUtils.class);

    /**
     * ------------------------
     * 文件输入流转换成缓冲区
     * ------------------------
     *
     * @param imgIn 文件读流
     */
    public static BufferedImage img2Buf(InputStream imgIn) throws IOException {
        return ImageIO.read(imgIn);
    }

    /**
     * ------------------------
     * 添加水印
     * ------------------------
     *
     * @param imgIn         文件读流
     * @param waterMarkPath 水印文件所在路径
     */
    public static BufferedImage addWaterMark(BufferedImage imgIn, String waterMarkPath) {
        BufferedImage imgBuf = null;
        try {
            String wmFilePath = resource.getFile() + waterMarkPath;
            imgBuf = Thumbnails.of(imgIn)
                    .size(1280, 1024)
                    .watermark(Positions.BOTTOM_RIGHT, ImageIO.read(new File(wmFilePath)), 0.5f)
                    .outputQuality(0.8f)
                    .asBufferedImage();
            return imgBuf;
        } catch (Exception e) {
            logger.error("添加水印失败",e);
            return imgBuf;
        }
    }

}
