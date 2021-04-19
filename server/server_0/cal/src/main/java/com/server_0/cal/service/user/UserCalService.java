package com.server_0.service.cal.user;

import com.server_0.comm.web.ServerResponse;

/**
 * @ClassName UserCalService
 * @Description 用户计算服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/12 2:34 下午
 * @ModifyDate 2021/1/12 2:34 下午
 * @Version 1.0
 */
public interface UserCalService {
    /**
     * 获取指定用户今日增量数据
     * */
     ServerResponse getToDatInfoByUserId(Long userId);
}
