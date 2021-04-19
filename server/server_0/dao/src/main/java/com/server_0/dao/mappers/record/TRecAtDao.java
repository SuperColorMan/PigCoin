package com.server_0.dao.mappers.record;


import com.server_0.dao.entity.record.TRecAt;
import org.apache.ibatis.annotations.Param;

public interface TRecAtDao {

    int isExiset(@Param("userId") Long userId,
                 @Param("byUserId") Long byUserId,
                 @Param("srcId") Long srcId,
                 @Param("srcType") String srcType
                 );

    int deleteByPrimaryKey(Long id);

    int insert(TRecAt record);

    int insertSelective(TRecAt record);

    TRecAt selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TRecAt record);

    int updateByPrimaryKey(TRecAt record);
}