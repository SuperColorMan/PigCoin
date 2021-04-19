package com.server_0.cal.service.user.impl;

import com.server_0.comm.enums.ContentTypeEnum;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.cal.user.UserToDayIncrement;
import com.server_0.dao.mappers.cal.user.UserCalDao;
import com.server_0.service.cal.user.UserCalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @ClassName UserCalServiceImpl
 * @Description 用户计算服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/12 2:34 下午
 * @ModifyDate 2021/1/12 2:34 下午
 * @Version 1.0
 */
@Service
public class UserCalServiceImpl implements UserCalService {
    @Autowired
    UserCalDao userCalDao;

    /**
     * 获取指定用户今日增量数据
     */
    @Override
    public ServerResponse getToDatInfoByUserId(Long userId) {
        UserToDayIncrement userToDayIncrement = new UserToDayIncrement();
        Long goodCount = userCalDao.getToDayGoodCount(userId, ContentTypeEnum.CONTENT.getType());
        userToDayIncrement.setGoodCount(goodCount);
        Long collCount = userCalDao.getToDayCollCount(userId, ContentTypeEnum.CONTENT.getType());
        userToDayIncrement.setCollCount(collCount);
        Long lookContentCount = userCalDao.getToDayContentLookCount(userId, ContentTypeEnum.CONTENT.getType());
        userToDayIncrement.setLookCount(lookContentCount);
        return ServerResponse.success("ok", userToDayIncrement);
    }
}
