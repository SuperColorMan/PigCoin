package com.server_0.service.comm.impl;

import com.server_0.comm.config.FileConfigProperties;
import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.global.GlobalConstant;
import com.server_0.dao.entity.img.TImgInfo;
import com.server_0.dao.entity.shop.TShopImgInfo;
import com.server_0.dao.mappers.img.TImgInfoDao;
import com.server_0.dao.mappers.shop.TShopImgInfoDao;
import com.server_0.queue.local.LocalMQconsumerHandle;
import com.server_0.service.comm.CommService;
import com.server_0.utils.encryption.Base64Util;
import com.server_0.utils.file.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Base64;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName CommServiceImpl
 * @Description 公共服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/22 9:14 上午
 * @ModifyDate 2021/1/22 9:14 上午
 * @Version 1.0
 */
@Service
public class CommServiceImpl implements CommService {
    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(CommServiceImpl.class);
    @Autowired
    TImgInfoDao tImgInfoDao;
    @Autowired
    FileConfigProperties fileConfigProperties;
    @Autowired
    TShopImgInfoDao tShopImgInfoDao;

    /**
     * 图片批量上传
     */
    @Override
    public void imgUpLoadByArr(MultipartFile[] imgs, Long srcId, Long userId, Map<Integer, InputStream> imgSteamMap, ImgTypeEnum srcType) {
        if (Objects.isNull(imgs)) {
            return;
        }
        for (int i = 0; i < imgs.length; i++) {
            MultipartFile img = imgs[i];
            //后缀
            String postfix = img.getOriginalFilename();
            postfix = postfix.substring(postfix.lastIndexOf(".") + 1);
            //输出文件名
            String fileOutName = userId + "_" + System.currentTimeMillis();
            //输出文件夹路径
            String fileOutFolder = GlobalConstant.CONTENT_IMG_OUT_PUT_FILE_PATH;
            //文件输出路径
            String fileOutPath = fileOutFolder + "/" + fileOutName + "." + postfix;
            // 输入流
            InputStream in = null;
            try {
                in = imgSteamMap.get(img.hashCode());
                // 文件输出
                FileUtils.saveFile(in, fileOutPath);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("图片输入流获取异常:", e);
            }
            BufferedImage b = null;
            //增加图片记录
            //来源类型
            int sourceType = srcType.getType();
            //文件大小
            String fileSize = "0";
            try {
                fileSize = String.valueOf(in.available());
            } catch (Exception e) {
                logger.error("获取文件大小异常:", e);
            }
            //文件名
            String fileName = fileOutName + "." + postfix;
            //文件路径
            String filePath = fileOutPath;
            //图片数据映射对象
            TImgInfo tImgInfo = new TImgInfo();
            tImgInfo.setSrcId(srcId);
            tImgInfo.setSrcType(String.valueOf(sourceType));
            tImgInfo.setFileSize(Integer.parseInt(fileSize));
            tImgInfo.setFileName(fileName);
            tImgInfo.setFilePath(filePath);
            tImgInfo.setFileType(postfix);
            tImgInfoDao.insertSelective(tImgInfo);
        }
    }

    /**
     * 图片独立上传
     */
    @Override
    public void imgUpLoadByOnley(MultipartFile img, Long srcId, Long userId, Map<Integer, InputStream> imgSteamMap, ImgTypeEnum srcType) {
        if (Objects.isNull(img)) {
            return;
        }
        //后缀
        String postfix = img.getOriginalFilename();
        postfix = postfix.substring(postfix.lastIndexOf(".") + 1);
        //输出文件名
        String fileOutName = userId + "_" + System.currentTimeMillis();
        //输出文件夹路径
        String fileOutFolder = GlobalConstant.CONTENT_IMG_OUT_PUT_FILE_PATH;
        //文件输出路径
        String fileOutPath = fileOutFolder + "/" + fileOutName + "." + postfix;
        // 输入流
        InputStream in = null;
        try {
            in = imgSteamMap.get(img.hashCode());
            // 文件输出
            FileUtils.saveFile(in, fileOutPath);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("图片输入流获取异常:", e);
        }
        BufferedImage b = null;
        //增加图片记录
        //来源类型
        int sourceType = srcType.getType();
        //文件大小
        String fileSize = "0";
        try {
            fileSize = String.valueOf(in.available());
        } catch (Exception e) {
            logger.error("获取文件大小异常:", e);
        }
        //文件名
        String fileName = fileOutName + "." + postfix;
        //文件路径
        String filePath = fileOutPath;
        //图片数据映射对象
        TImgInfo tImgInfo = new TImgInfo();
        tImgInfo.setSrcId(srcId);
        tImgInfo.setSrcType(String.valueOf(sourceType));
        tImgInfo.setFileSize(Integer.parseInt(fileSize));
        tImgInfo.setFileName(fileName);
        tImgInfo.setFilePath(filePath);
        tImgInfo.setFileType(postfix);
        tImgInfoDao.insertSelective(tImgInfo);
    }

    /**
     * 单独上传基于Base64
     *
     * @param isImgRep 是否开启图片信息替换 ture:图片信息新增时判断是否存在,存在则替换,否则新增;false:直接新增图片信息。
     */
    @Override
    public void imgUpLoadByOnleyAndBase64(
            String file,
            String filePostfix,
            Long srcId,
            Long userId,
            ImgTypeEnum srcType,
            boolean isImgRep) {

        if (Objects.isNull(file)) {
            return;
        }
        //后缀
        String postfix = filePostfix != null ? filePostfix : "png";
        postfix = postfix.substring(postfix.lastIndexOf(".") + 1);
        //输出文件名
        String fileOutName = userId + "_" + System.currentTimeMillis();
        //输出文件夹路径
        String fileOutFolder = GlobalConstant.CONTENT_IMG_OUT_PUT_FILE_PATH;
        //文件输出路径
        String fileOutPath = fileOutFolder + "/" + fileOutName + "." + postfix;
        // 输入流
        ByteArrayInputStream in = null;
        // ------------------ 针对用户头像或用户壁纸的处理策略(替换已有图片) start ------------------
        TImgInfo imgInfo = null;
        if (ImgTypeEnum.USERPIC.getType() == srcType.getType() || ImgTypeEnum.USERBGPIC.getType() == srcType.getType()) {
            imgInfo = tImgInfoDao.selectBySrcIdAndType(srcId, String.valueOf(srcType.getType()));
            if (!Objects.isNull(imgInfo)) {
                fileOutPath = fileOutFolder + "/" + imgInfo.getFileName();
            }
        }
        // ------------------ 针对用户头像或用户壁纸的处理策略(替换已有图片) end ------------------

        try {
            in = Base64Util.str2Input(file);
            // 文件输出
            FileUtils.saveImgFile(in, fileOutPath);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("图片输入流获取异常:", e);
        }
        BufferedImage b = null;
        //增加图片记录
        //来源类型
        int sourceType = srcType.getType();
        //文件大小
        String fileSize = "0";
        try {
            fileSize = String.valueOf(in.available());
        } catch (Exception e) {
            logger.error("获取文件大小异常:", e);
        }
        //文件名
        String fileName = fileOutName + "." + postfix;
        //文件路径
        String filePath = fileOutPath;
        //图片数据映射对象
        TImgInfo tImgInfo = new TImgInfo();
        tImgInfo.setSrcId(srcId);
        tImgInfo.setSrcType(String.valueOf(sourceType));
        tImgInfo.setFileSize(Integer.parseInt(fileSize));
        tImgInfo.setFileName(fileName);
        tImgInfo.setFilePath(filePath);
        tImgInfo.setFileType(postfix);
        if (isImgRep) {
            if (!Objects.isNull(imgInfo)) {
                // 替换
                tImgInfoDao.updateByPrimaryKeySelective(tImgInfo);
            } else {
                // 新增
                tImgInfoDao.insertSelective(tImgInfo);
            }
        } else {
            tImgInfoDao.insertSelective(tImgInfo);
        }
    }


    /**
     * 商品图片批量上传
     */
    @Override
    public void commodityImgUpLoadByArr(MultipartFile[] imgs, Long srcId, Long userId, Map<Integer, InputStream> imgSteamMap) {
        if (Objects.isNull(imgs)) {
            return;
        }
        for (int i = 0; i < imgs.length; i++) {
            MultipartFile img = imgs[i];
            //后缀
            String postfix = img.getOriginalFilename();
            postfix = postfix.substring(postfix.lastIndexOf(".") + 1);
            //输出文件名
            String fileOutName = userId + "_" + System.currentTimeMillis();
            //输出文件夹路径
            String fileOutFolder = GlobalConstant.COMMODITY_IMG_OUT_PUT_FILE_PATH;
            //文件输出路径
            String fileOutPath = fileOutFolder + "/" + fileOutName + "." + postfix;
            // 输入流
            InputStream in = null;
            try {
                in = imgSteamMap.get(img.hashCode());
                // 文件输出
                FileUtils.saveFile(in, fileOutPath);
            } catch (Exception e) {
                e.printStackTrace();
                logger.error("图片输入流获取异常:", e);
            }
            BufferedImage b = null;
            //增加图片记录
            //文件大小
            String fileSize = "0";
            try {
                fileSize = String.valueOf(in.available());
            } catch (Exception e) {
                logger.error("获取文件大小异常:", e);
            }
            //文件名
            String fileName = fileOutName + "." + postfix;
            //文件路径
            String filePath = fileOutPath;
            //图片数据映射对象
            TShopImgInfo tShopImgInfo = new TShopImgInfo();
            tShopImgInfo.setCommodityId(srcId);
            tShopImgInfo.setFileSize(Integer.parseInt(fileSize));
            tShopImgInfo.setFileName(fileName);
            tShopImgInfo.setFilePath(filePath);
            tShopImgInfo.setFileType(postfix);
            tShopImgInfoDao.insertSelective(tShopImgInfo);
        }
    }

}
