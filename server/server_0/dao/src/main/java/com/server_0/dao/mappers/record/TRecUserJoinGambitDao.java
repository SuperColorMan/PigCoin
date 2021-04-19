package com.server_0.dao.mappers.record;


import com.server_0.dao.entity.record.TRecUserJoinGambit;

public interface TRecUserJoinGambitDao {
    int deleteByPrimaryKey(Long id);

    int insert(TRecUserJoinGambit record);

    int insertSelective(TRecUserJoinGambit record);

    TRecUserJoinGambit selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TRecUserJoinGambit record);

    int updateByPrimaryKey(TRecUserJoinGambit record);
}