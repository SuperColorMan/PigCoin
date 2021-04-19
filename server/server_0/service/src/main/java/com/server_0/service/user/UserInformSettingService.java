package com.server_0.service.user;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.user.TUInformSetting;

/**
 * @ClassName UserInformSettingService
 * @Description 用户通知设置服务层
 * @Author SuperColorMan
 * @Date 2021/1/7 5:00 下午
 * @ModifyDate 2021/1/7 5:00 下午
 * @Version 1.0
 */
public interface UserInformSettingService {
    /**
     * 获取指定用户的通知设置信息
     */
    ServerResponse getUserInformSettingById(Long userId);

    /**
     * 设置指定用户的通知设置信息
     */
    ServerResponse setUserInformSettingById(TUInformSetting tuInformSetting);
}
