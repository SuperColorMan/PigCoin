package com.server_0.service.login.impl;

import com.server_0.comm.config.AppConfigProperties;
import com.server_0.comm.global.GlobalConstant;
import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.user.TUInformSetting;
import com.server_0.dao.entity.user.TUInteractionInfo;
import com.server_0.dao.entity.user.TUUser;
import com.server_0.dao.mappers.user.TUInformSettingDao;
import com.server_0.dao.mappers.user.TUInteractionInfoDao;
import com.server_0.dao.mappers.user.TUUserDao;
import com.server_0.service.login.LoginService;
import com.server_0.utils.math.MyMathUtil;
import com.server_0.utils.thread.ThreadPoolUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.concurrent.CountDownLatch;

/**
 * @ClassName LoginServiceImpl
 * @Description 登录注册服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/8 10:25 下午
 * @ModifyDate 2021/1/8 10:25 下午
 * @Version 1.0
 */
@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    TUUserDao tuUserDao;
    @Autowired
    TUInteractionInfoDao tuInteractionInfoDao;
    @Autowired
    TUInformSettingDao tuInformSettingDao;

    /**
     * 注册
     */
    @Override
    public ServerResponse register(String account, String pass, String uid) {
        // 随机用户名
        String randomUserName = null;
        while (true) {
            try {
                randomUserName = GlobalConstant.APP_NAME + "用户@" + MyMathUtil.getRandomNumByLength(8);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (tuUserDao.isExistUserName(randomUserName) == 0) {
                break;
            }
        }
        TUUser tuUser = new TUUser();
        //判断个性化账号
        if (StringUtils.isNotBlank(uid)) {
            if (tuUserDao.isExistUId(uid) == 0) {
                tuUser.setUid(uid);
            }
        }
        tuUser.setAccount(account);
        tuUser.setPass(pass);
        tuUser.setUid(uid);
        tuUser.setName(randomUserName);
        tuUserDao.insertSelective(tuUser);
        ThreadPoolUtils.exe(() -> {
            // 新增用户互动信息
            TUInteractionInfo tuInteractionInfo = new TUInteractionInfo();
            tuInteractionInfo.setUserId(tuUser.getId());
            tuInteractionInfoDao.insertSelective(tuInteractionInfo);
        });
        ThreadPoolUtils.exe(() -> {
            // 新增用户个人设置
            TUInformSetting tuInformSetting = new TUInformSetting();
            tuInformSetting.setUserId(tuUser.getId());
            tuInformSettingDao.insertSelective(tuInformSetting);
        });
        return ServerResponse.success("ok");
    }

    /**
     * 登录
     */
    @Override
    public ServerResponse login(String account, String pass) {
        TUUser tuUser = tuUserDao.selectByPrimaryAccount(account, pass);
        if (!Objects.isNull(tuUser)) {
            return ServerResponse.success("ok", tuUser);
        } else {
            return ServerResponse.error("error");
        }
    }
}
