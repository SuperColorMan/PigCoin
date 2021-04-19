package com.server_0.dao.entity.cal.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @ClassName UserToDayIncrement
 * @Description 用户今日增量数据量
 * @Author SuperColorMan
 * @Date 2021/1/12 2:42 下午
 * @ModifyDate 2021/1/12 2:42 下午
 * @Version 1.0
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserToDayIncrement {
    /**
     * 今日主页访问量
     */
    private Long pageVisitCount;
    /**
     * 今日新增内容查看量
     */
    private Long lookCount;
    /**
     * 今日获赞量
     */
    private Long goodCount;
    /**
     * 今日新增收藏量
     */
    private Long collCount;
    /**
     * 今日新增评论量
     */
    private Long commentCount;
}
