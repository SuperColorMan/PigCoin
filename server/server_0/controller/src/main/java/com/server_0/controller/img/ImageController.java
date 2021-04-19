package com.server_0.controller.img;

import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.service.img.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @ClassName ImgController
 * @Description 图片控制器
 * @Author SuperColorMan
 * @Date 2021/1/4 11:35 上午
 * @ModifyDate 2021/1/4 11:35 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/img/")
public class ImageController {
    @Autowired
    ImageService imageService;

    /**
     * ---------------------------------
     * 获取用户头像图片
     * ---------------------------------
     *
     * @param id 图片来源id
     */
    @GetMapping("getUserHeadPic")
    public void getUserHeadPic(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgBySId(id, ImgTypeEnum.USERPIC, spon);
    }

    /**
     * ---------------------------------
     * 获取用户壁纸图片
     * ---------------------------------
     *
     * @param id 图片来源id
     */
    @GetMapping("getUserBgPic")
    public void getUserBgPic(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgBySId(id, ImgTypeEnum.USERBGPIC, spon);
    }


    /**
     * ---------------------------------
     * 获取话题头像图片
     * ---------------------------------
     *
     * @param id 图片来源id
     */
    @GetMapping("getGambitHeadPic")
    public void getGambitHeadPic(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgBySId(id, ImgTypeEnum.GAMBITHEADPIC, spon);
    }

    /**
     * ---------------------------------
     * 获取商品分类头像
     * ---------------------------------
     *
     * @param id 图片来源id
     */
    @GetMapping("getCommodityHeadPic")
    public void getCommodityHeadPic(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgBySId(id, ImgTypeEnum.COMMODITYCLASSIFYPIC, spon);
    }

    /**
     * ---------------------------------
     * 获取商品相关图片
     * ---------------------------------
     *
     * @param id 商品图片id
     */
    @GetMapping("getCommodityPic")
    public void getCommodityPic(Long id, HttpServletResponse spon) throws IOException {
        imageService.getCommodityPic(id, spon);
    }

    /**
     * ---------------------------------
     * 获取内容图片
     * ---------------------------------
     *
     * @param id 图片id
     */
    @GetMapping("getContentImg")
    public void getContentImg(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgById(id, ImgTypeEnum.CONTENTIMG, spon);
    }

    /**
     * ---------------------------------
     * 获取评论图片
     * ---------------------------------
     *
     * @param id 图片id
     */
    @GetMapping("getCommentImg")
    public void getCommentImg(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgById(id, ImgTypeEnum.COMMENTIMG, spon);
    }

    /**
     * ---------------------------------
     * 获取回复图片
     * ---------------------------------
     *
     * @param id 图片id
     */
    @GetMapping("getReplyImg")
    public void getReplyImg(Long id, HttpServletResponse spon) throws IOException {
        imageService.getImgById(id, ImgTypeEnum.REPLYIMG, spon);
    }

    /**
     * ---------------------------------
     * 获取私信图片,根据id
     * ---------------------------------
     *
     * @param id id
     */
    @GetMapping("getChatImgById")
    public void getChatImgById(Long id, HttpServletResponse spon) throws IOException {
        imageService.getChatImgById(id, spon);
    }

    /**
     * ---------------------------------
     * 获取私信图片,根据私信id
     * ---------------------------------
     *
     * @param chatId 私信id
     */
    @GetMapping("getChatImgByChatId")
    public void getChatImgByChatId(Long chatId, HttpServletResponse spon) throws IOException {
        imageService.getChatImgByChatId(chatId, spon);
    }

}
