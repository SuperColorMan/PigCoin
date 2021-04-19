package com.server_0.service.user.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.user.TUInformSetting;
import com.server_0.dao.mappers.user.TUInformSettingDao;
import com.server_0.queue.local.LocalMQconsumerThread;
import com.server_0.service.user.UserInformSettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ClassName UserInformSettingServiceImpl
 * @Description 用户通知设置服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/7 5:00 下午
 * @ModifyDate 2021/1/7 5:00 下午
 * @Version 1.0
 */
@Service
public class UserInformSettingServiceImpl implements UserInformSettingService {
    @Autowired
    TUInformSettingDao tuInformSettingDao;

    /**
     * 获取指定用户的通知设置信息
     */
    @Override
    public ServerResponse getUserInformSettingById(Long userId) {
        TUInformSetting tuInformSetting = tuInformSettingDao.selectByPrimaryKey(userId);
        return ServerResponse.success("ok", tuInformSetting);
    }

    /**
     * 设置指定用户的通知设置信息
     */
    @Override
    public ServerResponse setUserInformSettingById(TUInformSetting tuInformSetting) {
        LocalMQconsumerThread.addQueueItem(() -> {
            tuInformSettingDao.updateByPrimaryKeySelective(tuInformSetting);
        });
        return ServerResponse.success("ok");
    }

}
