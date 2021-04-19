package com.server_0.dao.mappers.record;


import com.server_0.dao.entity.record.TRecGood;
import com.server_0.dao.entity.record.TRecLook;
import org.apache.ibatis.annotations.Param;

public interface TRecLookDao {

    int isExiset(@Param("userId") Long userId,
                 @Param("resId") Long resId,
                 @Param("type") String type);

    Long getCount(@Param("resId") Long resId,
                  @Param("type") String srcId);

    int deleteByPrimaryKey(Long id);

    int deleteSelective(TRecLook record);

    int insert(TRecLook record);

    int insertSelective(TRecLook record);

    TRecLook selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TRecLook record);

    int updateByPrimaryKey(TRecLook record);
}