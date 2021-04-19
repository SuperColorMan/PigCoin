package com.server_0.service.comm;

import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.dao.entity.img.TImgInfo;
import com.server_0.utils.file.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName CommService
 * @Description 公共服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/22 9:14 上午
 * @ModifyDate 2021/1/22 9:14 上午
 * @Version 1.0
 */
public interface CommService {
    /**
     * 批量上传
     */
    void imgUpLoadByArr(MultipartFile[] imgs, Long srcId, Long userId, Map<Integer, InputStream> imgSteamMap, ImgTypeEnum srcType);

    /**
     * 单独上传
     */
    void imgUpLoadByOnley(MultipartFile img, Long srcId, Long userId, Map<Integer, InputStream> imgSteamMap, ImgTypeEnum srcType);

    /**
     * 单独上传基于Base64
     */
    void imgUpLoadByOnleyAndBase64(
            String file,
            String filePostfix,
            Long srcId,
            Long userId,
            ImgTypeEnum srcType,
            boolean isImgRep);

    /**
     * 商品图片批量上传
     */
    void commodityImgUpLoadByArr(MultipartFile[] imgs, Long srcId, Long userId, Map<Integer, InputStream> imgSteamMap);

}
