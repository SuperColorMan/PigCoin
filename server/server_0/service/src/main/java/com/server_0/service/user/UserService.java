package com.server_0.service.user;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.user.TUInformSetting;
import com.server_0.dao.entity.user.TUUser;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.Map;

/**
 * @ClassName UserService
 * @Description 用户服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/3 2:02 下午
 * @ModifyDate 2021/1/3 2:02 下午
 * @Version 1.0
 */
public interface UserService {
    /**
     * 获取用户信息
     *
     * @param userId 用户id
     */
    ServerResponse getUserInfoById(Long userId);

    /**
     * 获取用户信息
     *
     * @param userName 用户名称
     */
    ServerResponse getUserInfoByName(String userName);

    /**
     * 获取指定用户的粉丝列表
     *
     * @param userId 用户id
     */
    ServerResponse getFansListByUserId(Long userId, Long page, Long pageSize);

    /**
     * 获取用户信息
     *
     * @param userId 用户id
     */
    ServerResponse deleteUser(Long userId);

    /**
     * 获取用户今日内容查看量
     *
     * @param userId 用户id
     */
    ServerResponse getUserToDayLookCount(Long userId);

    /**
     * 获取用户今日获赞量
     *
     * @param userId 用户id
     */
    ServerResponse getUserToDayGoodCount(Long userId);

    /**
     * 获取用户今日收藏数
     *
     * @param userId 用户id
     */
    ServerResponse getUserToDayCollectCount(Long userId);

    /**
     * 获取用户内容分类
     */
    ServerResponse getUserContentType();

    /**
     * 搜索用户
     */
    ServerResponse searchUser(String keyWord, Long page, Long pageSize);

    /**
     * 搜索用户
     */
    ServerResponse getUserAttentionListById(Long userId, Long page, Long pageSize);

    /**
     * ------------------------ 用户相关信息编辑 start ------------------------
     * */
    /**
     * 编辑用户信息
     */
    ServerResponse editUserInfo(TUUser tuUser, String localInfo);

    /**
     * 编辑用户个人设置
     *
     * @param tuInformSetting 用户个人设置
     */
    ServerResponse editUserSetting(TUInformSetting tuInformSetting);

    /**
     * 上传用户头像
     *
     * @param userId  用户id
     * @param headPic 头像
     */
    ServerResponse upUserHeadPic(Long userId, String headPic);


    /**
     * 上传用户背景
     *
     * @param userId 用户id
     * @param gbPic  头像
     */
    ServerResponse upUserBgPic(Long userId, String gbPic);
    /**
     * ------------------------ 用户相关信息编辑 end ------------------------
     * */
}
