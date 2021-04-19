package com.server_0.root.task;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.server_0.comm.enums.CommodityClassifyLvlEnum;
import com.server_0.comm.global.GlobalConstant;
import com.server_0.dao.entity.gambit.TGClassify;
import com.server_0.dao.entity.gambit.TGGambit;
import com.server_0.dao.entity.shop.TShopCommodityClassify;
import com.server_0.dao.mappers.gambit.TGClassifyDao;
import com.server_0.dao.mappers.gambit.TGGambitDao;
import com.server_0.dao.mappers.shop.TShopCommodityClassifyDao;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.utils.io.IOUtils;
import com.server_0.utils.sql.ExeSQL;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;


/**
 * @ClassName AppStartTask
 * @Description 应用启动任务
 * @Author SuperColorMan
 * @Date 2021/1/3 3:52 下午
 * @ModifyDate 2021/1/3 3:52 下午
 * @Version 1.0
 */
@Component
public class AppStartTask implements ApplicationRunner {

    private static Logger logger = LoggerFactory.getLogger(AppStartTask.class);

    @Autowired
    DataSource dataSource;
    @Autowired
    TGGambitDao tgGambitDao;
    @Autowired
    TGClassifyDao tgClassifyDao;
    @Autowired
    TShopCommodityClassifyDao tShopCommodityClassifyDao;

    @Override
    public void run(ApplicationArguments args) throws Exception {
        //任务
        logger.info("项目启动");
        final Connection connection = DataSourceUtils.getConnection(dataSource);
        final ExeSQL exeSql = new ExeSQL();
        final ClassPathResource resource = new ClassPathResource("");
        //----------------启动本地消息队列 start----------------
        LocalMQconsumerThread.start();
        //----------------启动本地消息队列 end----------------

        //----------------执行建表sql脚本 start----------------
        File f = null;
        try {
            f = GlobalConstant.SYS_TABLE_INIT_FILE_PATH;
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            exeSql.exeSql(connection, f);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        //----------------执行建表sql脚本 end----------------

        //----------------初始化话题数据 start----------------
        if (tgGambitDao.isExistData() == 0) {
            logger.info("开始话题初始化");
            File gambitFile = null;
            try {
                /// 话题头像文件名
                int gambitHeadPicFileName = 0;
                gambitFile = GlobalConstant.GAMBIT_INIT_DATA_FILE_PATH;
                String s = IOUtils.readJsonFile(gambitFile);
                JSONArray gambitArr = JSONArray.parseArray(s);
                for (int i = 0; i < gambitArr.size(); i++) {
                    // 话题分类
                    JSONObject gambitClassify = gambitArr.getJSONObject(i);
                    // 分类下话题列表
                    JSONArray gambitList = gambitClassify.getJSONArray("gambitList");
                    /// 话题分类
                    TGClassify tgClassify = new TGClassify();
                    tgClassify.setName(gambitClassify.getString("name"));
                    tgClassifyDao.insertSelective(tgClassify);
                    for (int j = 0; j < gambitList.size(); j++) {
                        JSONObject gambit = gambitList.getJSONObject(j);
                        TGGambit tgGambit = new TGGambit();
                        tgGambit.setHeadPicName(String.valueOf(gambitHeadPicFileName));
                        tgGambit.setClassifyId(tgClassify.getId());
                        tgGambit.setName(gambit.getString("name"));
                        tgGambitDao.insertSelective(tgGambit);
                        gambitHeadPicFileName++;
                        if (gambitHeadPicFileName == 124) {
                            // 文件名称错位,跳过序号:124
                            gambitHeadPicFileName++;
                        }
                    }
                }
                logger.info("话题初始化完成");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //----------------初始化话题数据 end----------------

        //----------------初始化商品分类数据 start----------------
        if (tShopCommodityClassifyDao.isExistData() == 0) {
            logger.info("不存在商品分类数据");
            File commodityFile = null;
            try {
                commodityFile = GlobalConstant.COMMODITY_CLASSIFY_INIT_DATA_FILE_PATH;
                String s = IOUtils.readJsonFile(commodityFile);
                // 商品大类数组
                JSONArray bigClassifyArr = JSONArray.parseArray(s);
                for (int i = 0; i < bigClassifyArr.size(); i++) {
                    // 商品大类
                    JSONObject bigClassJson = bigClassifyArr.getJSONObject(i);
                    TShopCommodityClassify bigClass = new TShopCommodityClassify();
                    bigClass.setName(bigClassJson.getString("bName"));
                    bigClass.setParentId(0L);
                    bigClass.setLvl(CommodityClassifyLvlEnum.BIG.getType());
                    tShopCommodityClassifyDao.insertSelective(bigClass);
                    // 大类所属中类数组,mediumClassifyList
                    JSONArray mediumClassifyArr = bigClassJson.getJSONArray("mediumClassifyList");
                    for (int j = 0; j < mediumClassifyArr.size(); j++) {
                        /// 中类
                        JSONObject mediumClassify = mediumClassifyArr.getJSONObject(j);
                        TShopCommodityClassify mClassify = new TShopCommodityClassify();
                        mClassify.setName(mediumClassify.getString("mName"));
                        mClassify.setParentId(bigClass.getId());
                        mClassify.setLvl(CommodityClassifyLvlEnum.MEDIUM.getType());
                        tShopCommodityClassifyDao.insertSelective(mClassify);
                        // 中类所属小类数组,smallClassifyList
                        JSONArray smallClassifyArr = mediumClassify.getJSONArray("smallClassifyList");
                        for (int z = 0; z < smallClassifyArr.size(); z++) {
                            /// 小类数据
                            JSONObject smallClassify = smallClassifyArr.getJSONObject(z);
                            TShopCommodityClassify sClassify = new TShopCommodityClassify();
                            sClassify.setName(smallClassify.getString("sName"));
                            sClassify.setParentId(mClassify.getId());
                            sClassify.setLvl(CommodityClassifyLvlEnum.SMALL.getType());
                            tShopCommodityClassifyDao.insertSelective(sClassify);
                        }
                    }
                }
                logger.info("商品分类数据完成");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //----------------初始化商品分类数据 end----------------

        //----------------图片输出文件夹初始化 end----------------
        File contentImgOutputFilePath = new File(GlobalConstant.CONTENT_IMG_OUT_PUT_FILE_PATH);
        File commodityImgOutputFilePath = new File(GlobalConstant.COMMODITY_IMG_OUT_PUT_FILE_PATH);
        File chatImgOutputFilePath = new File(GlobalConstant.CHAT_IMG_OUT_PUT_FILE_PATH);
        if (!contentImgOutputFilePath.exists()) {
            contentImgOutputFilePath.mkdirs();
        }
        if (!commodityImgOutputFilePath.exists()) {
            commodityImgOutputFilePath.mkdirs();
        }
        if (!chatImgOutputFilePath.exists()) {
            chatImgOutputFilePath.mkdirs();
        }
        //----------------图片输出文件夹初始化 end----------------


    }
}
