package com.server_0.service.img.impl;

import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.global.GlobalConstant;
import com.server_0.dao.entity.gambit.TGGambit;
import com.server_0.dao.entity.im.chat.TImChatImage;
import com.server_0.dao.entity.img.TImgInfo;
import com.server_0.dao.entity.shop.TShopCommodity;
import com.server_0.dao.entity.shop.TShopCommodityClassify;
import com.server_0.dao.entity.shop.TShopImgInfo;
import com.server_0.dao.mappers.gambit.TGGambitDao;
import com.server_0.dao.mappers.im.chat.TImChatImageDao;
import com.server_0.dao.mappers.img.TImgInfoDao;
import com.server_0.dao.mappers.shop.TShopCommodityClassifyDao;
import com.server_0.dao.mappers.shop.TShopCommodityDao;
import com.server_0.dao.mappers.shop.TShopImgInfoDao;
import com.server_0.utils.file.ImageFileUtils;
import com.server_0.service.img.ImageService;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.Objects;

/**
 * @ClassName ImageServiceImpl
 * @Description 图片服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/4 11:36 上午
 * @ModifyDate 2021/1/4 11:36 上午
 * @Version 1.0
 */
@Service
public class ImageServiceImpl implements ImageService {
    @Autowired
    TImgInfoDao tImgInfoDao;
    @Autowired
    TImChatImageDao tImChatImageDao;
    @Autowired
    TGGambitDao tgGambitDao;
    @Autowired
    TShopCommodityDao tShopCommodityDao;
    @Autowired
    TShopCommodityClassifyDao tShopCommodityClassifyDao;
    @Autowired
    TShopImgInfoDao tShopImgInfoDao;

    /**
     * 获取指定id的图片
     *
     * @param id 图片主键id
     */
    @Override
    public void getChatImgById(Long id, HttpServletResponse spon) throws IOException {
        TImChatImage img = tImChatImageDao.selectByPrimaryKey(id);
        File file;
        file = new File(img.getFilePath());
        ImageFileUtils.getFile(file, spon);
    }


    /**
     * 获取指定id的图片
     *
     * @param chatId 图片信息主键id
     */
    @Override
    public void getChatImgByChatId(Long chatId, HttpServletResponse spon) throws IOException {
        TImChatImage img = tImChatImageDao.selectBychatId(chatId);
        File file;
        file = new File(img.getFilePath());
        ImageFileUtils.getFile(file, spon);
    }

    /**
     * 获取指定id的图片
     *
     * @param id 图片信息主键id
     */
    @Override
    public void getImgById(Long id, ImgTypeEnum imgTypeEnum, HttpServletResponse spon) throws IOException {
        TImgInfo img = tImgInfoDao.selectByPrimaryKey(id, String.valueOf(imgTypeEnum.getType()));
        File file;
        file = new File(img.getFilePath());
        ImageFileUtils.getFile(file, spon);
    }

    /**
     * ---------------------------------
     * 获取商品相关图片
     * ---------------------------------
     *
     * @param id 商品图片id
     */
    @Override
    public void getCommodityPic(Long id, HttpServletResponse spon) throws IOException {
        TShopImgInfo tShopImgInfo = tShopImgInfoDao.selectByPrimaryKey(id);
        File file;
        file = new File(tShopImgInfo.getFilePath());
        ImageFileUtils.getFile(file, spon);
    }

    /**
     * 获取指定来源id的图片
     *
     * @param sid 图片来源id
     */
    @Override
    public void getImgBySId(Long sid, ImgTypeEnum imgTypeEnum, HttpServletResponse spon) throws IOException {
        TImgInfo img = tImgInfoDao.selectBySrcIdAndType(sid, String.valueOf(imgTypeEnum.getType()));
        File file;
        if (Objects.isNull(img) && imgTypeEnum == ImgTypeEnum.USERPIC) {
            // 不存在用户头像,使用默认头像
            file = GlobalConstant.DEFAULT_USER_HEAD_PIC;
            ImageFileUtils.getFile(file, spon);
        } else if (Objects.isNull(img) && imgTypeEnum == ImgTypeEnum.USERBGPIC) {
            // 不存在用户壁纸,使用默认壁纸
            file = GlobalConstant.DEFAULT_USER_BG_PIC;
            ImageFileUtils.getFile(file, spon);
        } else if (imgTypeEnum == ImgTypeEnum.GAMBITHEADPIC) {
            TGGambit tgGambit = tgGambitDao.selectByPrimaryKey(sid);
            // 话题头像
            String gambitHeadPic = GlobalConstant.GAMBIT_HEAD_PIC + tgGambit.getHeadPicName() + ".png";
            file = new File(gambitHeadPic);
            ImageFileUtils.getFile(file, spon);
        } else if (imgTypeEnum == ImgTypeEnum.COMMODITYCLASSIFYPIC) {
            TShopCommodityClassify tShopCommodityClassify = tShopCommodityClassifyDao.selectByPrimaryKey(sid);
            // 话题头像
            String commodityClassifyHeadPic = GlobalConstant.COMMODITY_CLASSIFY_HEAD_PIC + tShopCommodityClassify.getName() + ".png";
            file = new File(commodityClassifyHeadPic);
            ImageFileUtils.getFile(file, spon);

        } else {
            file = new File(img.getFilePath());
            ImageFileUtils.getFile(file, spon);
        }
    }

}
