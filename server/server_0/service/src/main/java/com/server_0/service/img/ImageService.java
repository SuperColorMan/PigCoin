package com.server_0.service.img;

import com.server_0.comm.enums.ImgTypeEnum;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @ClassName ImageService
 * @Description 图片服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/4 11:36 上午
 * @ModifyDate 2021/1/4 11:36 上午
 * @Version 1.0
 */
public interface ImageService {

    /**
     * 获取指定id的图片
     *
     * @param id 图片主键id
     */
    void getChatImgById(Long id, HttpServletResponse spon) throws IOException;


    /**
     * 获取指定id的图片
     *
     * @param chatId 私信id
     */
    void getChatImgByChatId(Long chatId, HttpServletResponse spon) throws IOException;

    /**
     * 获取指定id的图片
     *
     * @param id 图片信息主键id
     */
    void getImgById(Long id, ImgTypeEnum imgTypeEnum, HttpServletResponse spon) throws IOException;

    /**
     * 获取指定来源id的图片
     *
     * @param sid 图片来源id
     */
    void getImgBySId(Long sid, ImgTypeEnum imgTypeEnum, HttpServletResponse spon) throws IOException;

    /**
     * ---------------------------------
     * 获取商品相关图片
     * ---------------------------------
     *
     * @param id 商品图片id
     */
    void getCommodityPic(Long id, HttpServletResponse spon) throws IOException;
}
