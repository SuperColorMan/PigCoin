package com.server_0.dao.mappers.cal.user;

import org.apache.ibatis.annotations.Param;

public interface UserCalDao {
    Long getToDayCollCount(@Param("userId") Long userId, @Param("contentType") int contentType);
    Long getToDayGoodCount(@Param("userId") Long userId, @Param("contentType") int contentType);
    Long getToDayContentLookCount(@Param("userId") Long userId, @Param("contentType") int contentType);
}
