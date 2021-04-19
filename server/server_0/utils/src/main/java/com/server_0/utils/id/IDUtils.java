package com.server_0.utils.id;

import java.util.Objects;

/**
 * @ClassName IDUtil
 * @Description id工具
 * @Author SuperColorMan
 * @Date 2021/1/20 10:54 上午
 * @ModifyDate 2021/1/20 10:54 上午
 * @Version 1.0
 */
public class IDUtils {
    /**
     * 判断id是否为空
     *
     * @param ids id数组
     */
    public static boolean idIsNull(Long... ids) {
        for (Long id : ids) {
            if (Objects.isNull(id)) {
                return true;
            }
            if (id <= 0) {
                return true;
            }
        }
        return false;
    }
}
