package com.server_0.im.service.chat.impl;

import com.server_0.comm.config.FileConfigProperties;
import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.global.GlobalConstant;
import com.server_0.dao.entity.im.chat.TImChatImage;
import com.server_0.dao.mappers.im.chat.TImChatImageDao;
import com.server_0.im.service.chat.ChatService;
import com.server_0.utils.encryption.Base64Util;
import com.server_0.utils.file.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.util.Objects;

/**
 * @ClassName ChatServiceImpl
 * @Description 私信服务实现类
 * @Author SuperColorMan
 * @Date 2021/2/20 5:41 下午
 * @ModifyDate 2021/2/20 5:41 下午
 * @Version 1.0
 */
@Service
public class ChatServiceImpl implements ChatService {

    /**
     * 日志工具
     */
    private static Logger logger = LoggerFactory.getLogger(ChatServiceImpl.class);

    @Autowired
    FileConfigProperties fileConfigProperties;
    @Autowired
    TImChatImageDao tImChatImageDao;

    /**
     * 单独上传基于Base64
     */
    @Override
    public TImChatImage imgUpLoadByOnleyAndBase64(
            String file,
            Long chatId,
            Long userId) {

        if (Objects.isNull(file)) {
            return null;
        }
        //后缀
        String postfix = "png";
        postfix = postfix.substring(postfix.lastIndexOf(".") + 1);
        //输出文件名
        String fileOutName = userId + "_" + System.currentTimeMillis();
        //输出文件夹路径
        String fileOutFolder = GlobalConstant.CHAT_IMG_OUT_PUT_FILE_PATH;
        //文件输出路径
        String fileOutPath = fileOutFolder + "/" + fileOutName + "." + postfix;
        // 输入流
        ByteArrayInputStream in = null;
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
        TImChatImage tImChatImage = new TImChatImage();
        tImChatImage.setFileSize(Integer.parseInt(fileSize));
        tImChatImage.setFileName(fileName);
        tImChatImage.setFilePath(filePath);
        tImChatImage.setFileType(postfix);
        tImChatImage.setChatId(chatId);
        tImChatImageDao.insertSelective(tImChatImage);
        return tImChatImage;
    }

}
