package com.server_0.dao.mappers.message;


import com.server_0.dao.entity.message.TMessSysInform;
import org.apache.ibatis.annotations.Param;

public interface TMessSysInformDao {
    int deleteByPrimaryKey(Long id);

    int insert(TMessSysInform record);

    int insertSelective(TMessSysInform record);

    TMessSysInform selectByPrimaryKey(@Param("id") Long id,@Param("loginUserId") Long loginUserId);

    int updateByPrimaryKeySelective(TMessSysInform record);

    int updateByPrimaryKey(TMessSysInform record);
}