package com.server_0.root.quartz;

import com.server_0.dao.entity.content.TCContent;
import com.server_0.dao.entity.content.TCInteractionInfo;
import com.server_0.dao.mappers.content.TCContentDao;
import com.server_0.dao.mappers.content.TCInteractionInfoDao;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * @ClassName 数据矫正任务
 * @Description
 * @Author SuperColorMan
 * @Date 2021/1/26 7:49 下午
 * @ModifyDate 2021/1/26 7:49 下午
 * @Version 1.0
 */
public class DataCorrectQuartzTask extends QuartzJobBean {
    @Autowired
    TCContentDao tcContentDao;
    @Autowired
    TCInteractionInfoDao tcInteractionInfoDao;

    @Override
    protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        List<Map> list = tcContentDao.getNotInteractionInfoContent();
        try {
            for (Map info : list) {
                if (!info.containsKey("id") || !info.containsKey("type")) {
                    continue;
                }
                if (Objects.isNull(info.containsKey("id")) || Objects.isNull(info.containsKey("type"))) {
                    continue;
                }
                TCInteractionInfo tcInteractionInfo = new TCInteractionInfo();
                tcInteractionInfo.setContentId(Long.parseLong(info.get("id").toString()));
                tcInteractionInfo.setContentType(Integer.parseInt(info.get("type").toString()));
                tcInteractionInfoDao.insertSelective(tcInteractionInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}