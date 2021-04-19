package com.server_0.root.quartz.config;

import com.server_0.root.quartz.DataCorrectQuartzTask;
import org.quartz.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @ClassName wejioqw
 * @Description
 * @Author SuperColorMan
 * @Date 2021/1/26 7:47 下午
 * @ModifyDate 2021/1/26 7:47 下午
 * @Version 1.0
 */
@Configuration
public class QuartzConfig {
    /**
     *  ------------------------ 数据纠正定时任务 start --------------------------------
     * */
    @Bean
    public JobDetail dataCorrectQuartzTask() {
        //具体任务类
        return JobBuilder.newJob(DataCorrectQuartzTask.class)
                //给 JobDetail 起一个 id, 不写也会自动生成唯一的 TriggerKey
                .withIdentity("downloadJobDetail")
                //JobDetail 内部的一个 map, 可以存储有关 Job 的数据, 这里的数据
                // 可通过 Job 类中executeInternal方法的参数进行获取
                .usingJobData("job_download","download movie")
                .storeDurably()  //即使没有Trigger关联时也不删除该Jobdetail
                .build();
    }
    @Bean
    public Trigger downloadTrigger() {
        return TriggerBuilder.newTrigger()
                //关联上面的 jobDetail
                .forJob(dataCorrectQuartzTask())
                .withIdentity("downloadTrigger")
                .usingJobData("trigger_download","download")
                //cron 表达式设置每隔 5 秒执行一次
                .withSchedule(CronScheduleBuilder.cronSchedule("*/10 * * * * ? *"))
                .build();
    }
    /**
     *  ------------------------ 数据纠正定时任务 end --------------------------------
     * */
}