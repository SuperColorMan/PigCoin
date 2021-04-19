package com.server_0.dao.mappers.record;

import com.server_0.dao.entity.record.TRecDiss;
import com.server_0.dao.entity.record.TRecGood;
import org.apache.ibatis.annotations.Param;

public interface TRecDissDao {

    int isExiset(@Param("userId") Long userId,
                 @Param("resId") Long resId,
                 @Param("type") String type);

    Long getCount(@Param("resId") Long resId,
                  @Param("type") String type);

    int deleteByPrimaryKey(Long id);

    int deleteSelective(TRecDiss record);

    int insert(TRecDiss record);

    int insertSelective(TRecDiss record);

    TRecDiss selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TRecDiss record);

    int updateByPrimaryKey(TRecDiss record);
}