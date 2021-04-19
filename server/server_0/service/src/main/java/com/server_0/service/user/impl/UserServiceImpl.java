package com.server_0.service.user.impl;

import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.enums.LocalInfoTypeEnum;
import com.server_0.comm.enums.UserContentTypeEnum;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.local.TLocalInfo;
import com.server_0.dao.entity.record.TRecAttention;
import com.server_0.dao.entity.record.TRecColl;
import com.server_0.dao.entity.record.TRecGood;
import com.server_0.dao.entity.user.TUInformSetting;
import com.server_0.dao.entity.user.TUUser;
import com.server_0.dao.mappers.content.TCContentDao;
import com.server_0.dao.mappers.local.TLocalInfoDao;
import com.server_0.dao.mappers.record.TRecAttentionDao;
import com.server_0.dao.mappers.record.TRecCollDao;
import com.server_0.dao.mappers.record.TRecGoodDao;
import com.server_0.dao.mappers.user.TUInformSettingDao;
import com.server_0.dao.mappers.user.TUUserDao;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.service.comm.CommService;
import com.server_0.service.user.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName UserServiceImpl
 * @Description 用户服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/3 2:03 下午
 * @ModifyDate 2021/1/3 2:03 下午
 * @Version 1.0
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    TUUserDao tuUserDao;
    @Autowired
    CommService commService;
    @Autowired
    TLocalInfoDao tLocalInfoDao;
    @Autowired
    TUInformSettingDao tuInformSettingDao;
    @Autowired
    TRecAttentionDao tRecAttentionDao;
    @Autowired
    TRecGoodDao tRecGoodDao;
    @Autowired
    TRecCollDao tRecCollDao;
    @Autowired
    TCContentDao tcContentDao;

    /**
     * 获取用户信息
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getUserInfoById(Long userId) {
        if (Objects.isNull(userId)) {
            return ServerResponse.error("id不能为空");
        }
        TUUser tuUser = tuUserDao.selectByPrimaryKey(userId);
        if (Objects.isNull(tuUser)) {
            return ServerResponse.error("用户不存在");
        }
        return ServerResponse.success("ok", tuUser);
    }

    /**
     * 获取用户信息
     *
     * @param userName 用户名称
     */
    @Override
    public ServerResponse getUserInfoByName(String userName) {
        if (Objects.isNull(userName)) {
            return ServerResponse.error("用户名不能为空");
        }
        TUUser tuUser = tuUserDao.selectByName(userName);
        if (Objects.isNull(tuUser)) {
            return ServerResponse.error("用户不存在");
        }
        return ServerResponse.success("ok", tuUser);
    }

    /**
     * 获取指定用户的粉丝列表
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getFansListByUserId(Long userId, Long page, Long pageSize) {
        if (Objects.isNull(userId)) {
            return ServerResponse.error("用户id不能为空");
        }
        List<TRecAttention> tuUserList = tRecAttentionDao.getFansListByUserId(userId, page, pageSize);
        return ServerResponse.success("ok", tuUserList);
    }

    /**
     * 获取用户信息
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse deleteUser(Long userId) {
        return ServerResponse.success("ok");
    }

    /**
     * 获取用户今日内容查看量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getUserToDayLookCount(Long userId) {
        return ServerResponse.success("ok");
    }

    /**
     * 获取用户今日获赞量
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getUserToDayGoodCount(Long userId) {
        return ServerResponse.success("ok");
    }

    /**
     * 获取用户今日收藏数
     *
     * @param userId 用户id
     */
    @Override
    public ServerResponse getUserToDayCollectCount(Long userId) {
        return ServerResponse.success("ok");
    }

    /**
     * 获取用户内容分类
     */
    @Override
    public ServerResponse getUserContentType() {
        List<Map> list = Lists.newArrayList();
        UserContentTypeEnum[] userContentTypeEnumArr = UserContentTypeEnum.values();
        for (UserContentTypeEnum e : userContentTypeEnumArr) {
            Map m = Maps.newHashMap();
            m.put("type", e.getType());
            m.put("des", e.getDes());
            list.add(m);
        }
        return ServerResponse.success("ok", list);
    }

    /**
     * 搜索用户
     */
    @Override
    public ServerResponse searchUser(String keyWord, Long page, Long pageSize) {
        return ServerResponse.success("ok", tuUserDao.searchUser(keyWord, page, pageSize));
    }

    /**
     * 搜索用户
     */
    @Override
    public ServerResponse getUserAttentionListById(Long userId, Long page, Long pageSize) {
        return ServerResponse.success("ok", tuUserDao.getUserAttentionListById(userId, page, pageSize));
    }

    /**
     * ------------------------ 用户相关信息编辑 start ------------------------
     * */
    /**
     * 编辑用户信息
     */
    @Override
    public ServerResponse editUserInfo(TUUser tuUser, String localInfo) {
        LocalMQconsumerThread.addQueueItem(() -> {
            // 内容所在地信息
            if (StringUtils.isNotBlank(localInfo)) {
                JSONObject localInfoJson = JSONObject.parseObject(localInfo);
                TLocalInfo tLocalInfo = new TLocalInfo();
                tLocalInfo.setSrcId(tuUser.getId());
                tLocalInfo.setSrcType(String.valueOf(LocalInfoTypeEnum.USER.getType()));
                if (!localInfoJson.containsKey("country")) {
                    tLocalInfo.setCountry("中国");
                }
                tLocalInfo.setProvincial(localInfoJson.getString("provinceName"));
                tLocalInfo.setCity(localInfoJson.getString("cityName"));
                tLocalInfo.setDistrict(localInfoJson.getString("areaName"));
                if (tLocalInfoDao.isExiset(tuUser.getId(), LocalInfoTypeEnum.USER.getType()) > 0) {
                    tLocalInfoDao.updateByPrimaryKeySelective(tLocalInfo);
                } else {
                    tLocalInfoDao.insertSelective(tLocalInfo);
                }
            }
            tuUserDao.updateByPrimaryKeySelective(tuUser);
        });
        return ServerResponse.success("ok");
    }

    /**
     * 编辑用户个人设置
     *
     * @param tuInformSetting 用户个人设置
     */
    @Override
    public ServerResponse editUserSetting(TUInformSetting tuInformSetting) {
        LocalMQconsumerThread.addQueueItem(() -> {
            if (!Objects.isNull(tuInformSetting) && !Objects.isNull(tuInformSetting.getUserId())) {
                if (tuInformSettingDao.isExiset(tuInformSetting.getUserId()) > 1) {
                    tuInformSettingDao.updateByPrimaryKeySelective(tuInformSetting);
                } else {
                    tuInformSettingDao.insertSelective(tuInformSetting);
                }
            }
        });
        return ServerResponse.success("ok");
    }

    /**
     * 上传用户头像
     *
     * @param userId  用户id
     * @param headPic 头像
     */
    @Override
    public ServerResponse upUserHeadPic(Long userId, String headPic) {
        LocalMQconsumerThread.addQueueItem(() -> {
            commService.imgUpLoadByOnleyAndBase64(headPic, null, userId, userId, ImgTypeEnum.USERPIC, true);
        });
        return ServerResponse.success("ok");
    }

    /**
     * 上传用户背景
     *
     * @param userId 用户id
     * @param gbPic  头像
     */
    @Override
    public ServerResponse upUserBgPic(Long userId, String gbPic) {
        LocalMQconsumerThread.addQueueItem(() -> {
            commService.imgUpLoadByOnleyAndBase64(gbPic, null, userId, userId, ImgTypeEnum.USERBGPIC, true);
        });
        return ServerResponse.success("ok");
    }
    /**
     * ------------------------ 用户相关信息编辑 end ------------------------
     * */
}
