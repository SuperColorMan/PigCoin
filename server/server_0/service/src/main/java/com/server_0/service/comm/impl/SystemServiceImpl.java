package com.server_0.service.comm.impl;

import com.google.common.collect.Lists;
import com.server_0.comm.enums.ContentTypeEnum;
import com.server_0.comm.enums.ImgTypeEnum;
import com.server_0.comm.web.ServerResponse;
import com.server_0.service.comm.SystemService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName SystemServiceImpl
 * @Description 该后台系统相关服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/27 10:56 上午
 * @ModifyDate 2021/1/27 10:56 上午
 * @Version 1.0
 */
@Service
public class SystemServiceImpl implements SystemService {
    /**
     * 获取系统图片分类规则
     */
    @Override
    public ServerResponse getImgType() {
        List<ImgTypeEnum> imgTypeList = Lists.newArrayList();
        for (ImgTypeEnum type : ImgTypeEnum.values()) {
            imgTypeList.add(type);
        }
        return ServerResponse.success("ok", imgTypeList);
    }

    /**
     * 获取系统内容分类规则
     */
    @Override
    public ServerResponse getContentType() {
        List<ContentTypeEnum> contentTypeList = Lists.newArrayList();
        for (ContentTypeEnum type : ContentTypeEnum.values()) {
            contentTypeList.add(type);
        }
        return ServerResponse.success("ok", contentTypeList);
    }

}
