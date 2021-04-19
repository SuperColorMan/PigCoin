package com.server_0.dao.mappers.message;


import com.server_0.dao.entity.message.TMessMessage;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TMessMessageDao {
    int deleteByPrimaryKey(Long id);

    int insert(TMessMessage record);

    int insertSelective(TMessMessage record);

    TMessMessage selectByPrimaryKey(@Param("id") Long id);

    List<TMessMessage> getMessageByUserId(@Param("userId") Long userId,@Param("loginUserId") Long loginUserId);

    int updateByPrimaryKeySelective(TMessMessage record);

    int updateByPrimaryKey(TMessMessage record);
}