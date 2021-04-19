package com.server_0.dao.mappers.record;


import com.server_0.dao.entity.record.TRecJoinGambit;

public interface TRecJoinGambitDao {
    int deleteByPrimaryKey(Long id);

    int insert(TRecJoinGambit record);

    int insertSelective(TRecJoinGambit record);

    TRecJoinGambit selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TRecJoinGambit record);

    int updateByPrimaryKey(TRecJoinGambit record);
}