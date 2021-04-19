package com.server_0.controller.user;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.user.TUInformSetting;
import com.server_0.dao.entity.user.TUUser;
import com.server_0.service.user.UserInformSettingService;
import com.server_0.service.user.UserService;
import com.server_0.utils.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName UserController
 * @Description 用户控制器
 * @Author SuperColorMan
 * @Date 2021/1/3 2:27 下午
 * @ModifyDate 2021/1/3 2:27 下午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/user/")
public class UserController {
    @Autowired
    UserService userService;
    @Autowired
    UserInformSettingService userInformSettingService;

    /**
     * 获取指定用户信息
     */
    @PostMapping("getUserInfoById")
    public ServerResponse getUserInfoById(Long id) {
        return userService.getUserInfoById(id);
    }


    /**
     * 获取指定用户信息
     */
    @PostMapping("getUserInfoByName")
    public ServerResponse getUserInfoByName(String userName) {
        return userService.getUserInfoByName(userName);
    }

    /**
     * 获取指定用户的粉丝列表
     *
     * @param userId 用户id
     */
    @PostMapping("getFansListByUserId")
    public ServerResponse getFansListByUserId(Long userId, Long page, Long pageSize) {
        return userService.getFansListByUserId(userId, page, pageSize);
    }

    /**
     * 获取用户内容分类
     */
    @PostMapping("getUserContentType")
    public ServerResponse getUserContentType() {
        return userService.getUserContentType();
    }

    /**
     * 获取指定用户的通知设置信息
     */
    @PostMapping("getUserInformSettingById")
    public ServerResponse getUserInformSettingById(Long userId) {
        return userInformSettingService.getUserInformSettingById(userId);
    }

    /**
     * 设置指定用户的通知设置信息
     */
    @PostMapping("setUserInformSettingById")
    public ServerResponse setUserInformSettingById(TUInformSetting tuInformSetting) {
        return userInformSettingService.setUserInformSettingById(tuInformSetting);
    }

    /**
     * 软删除用户,软销毁用户账号,销毁账号
     */
    @PostMapping("deleteUser")
    public ServerResponse deleteUser(Long userId) {
        return userService.deleteUser(userId);
    }

    /**
     * 获取用户今日内容查看量
     *
     * @param userId 用户id
     */
    @PostMapping("getUserToDayLookCount")
    public ServerResponse getUserToDayLookCount(Long userId) {
        return userService.getUserToDayLookCount(userId);
    }

    /**
     * 获取用户今日获赞量
     *
     * @param userId 用户id
     */
    @PostMapping("getUserToDayGoodCount")
    public ServerResponse getUserToDayGoodCount(Long userId) {
        return userService.getUserToDayGoodCount(userId);
    }

    /**
     * 获取用户今日收藏数
     *
     * @param userId 用户id
     */
    @PostMapping("getUserToDayCollectCount")
    public ServerResponse getUserToDayCollectCount(Long userId) {
        return userService.getUserToDayCollectCount(userId);
    }

    /**
     * 搜索用户
     */
    @PostMapping("searchUser")
    public ServerResponse searchUser(String keyWord, Long page, Long pageSize) {
        return userService.searchUser(keyWord, page, pageSize);
    }

    /**
     * 获取指定用户关注的用户列表
     */
    @PostMapping("getUserAttentionListById")
    public ServerResponse getUserAttentionListById(Long userId, Long page, Long pageSize) {
        return userService.getUserAttentionListById(userId, page, pageSize);
    }

    /**
     * ------------------------ 用户相关信息编辑 start ------------------------
     * */
    /**
     * 编辑用户信息
     *
     * @param tuUser    用户信息
     * @param localInfo 用户地理信息
     */
    @PostMapping("editUserInfo")
    public ServerResponse editUserInfo(TUUser tuUser, String localInfo) {
        return userService.editUserInfo(tuUser, localInfo);
    }

    /**
     * 编辑用户个人设置
     *
     * @param tuInformSetting 用户个人设置
     */
    @PostMapping("editUserSetting")
    public ServerResponse editUserSetting(TUInformSetting tuInformSetting) {
        return userService.editUserSetting(tuInformSetting);
    }

    /**
     * 上传用户头像
     *
     * @param userId        用户id
     * @param headPicBase64 头像
     */
    @PostMapping("upUserHeadPic")
    public ServerResponse upUserHeadPic(Long userId, String headPicBase64) {
        return userService.upUserHeadPic(userId, headPicBase64);
    }

    /**
     * 上传用户背景
     *
     * @param userId      用户id
     * @param gbPicBase64 头像
     */
    @PostMapping("upUserBgPic")
    public ServerResponse upUserBgPic(Long userId, String gbPicBase64) {
        return userService.upUserBgPic(userId, gbPicBase64);
    }
    /**
     * ------------------------ 用户相关信息编辑 end ------------------------
     * */
}

