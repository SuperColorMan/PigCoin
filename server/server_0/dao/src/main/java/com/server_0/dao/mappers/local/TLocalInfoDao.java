package com.server_0.dao.mappers.local;


import com.server_0.dao.entity.local.TLocalInfo;
import org.apache.ibatis.annotations.Param;

public interface TLocalInfoDao {

    int isExiset(@Param("srcId") Long srcId,@Param("srcType") Integer srcType);

    int deleteByPrimaryKey(Long id);

    int insert(TLocalInfo record);

    int insertSelective(TLocalInfo record);

    TLocalInfo selectByPrimaryKey(Long id);

    TLocalInfo selectBySrcIdAndSrcType(@Param("srcId") Long srcId,@Param("srcType") Integer srcType);

    int updateByPrimaryKeySelective(TLocalInfo record);

    int updateByPrimaryKey(TLocalInfo record);
}