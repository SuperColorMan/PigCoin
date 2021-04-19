package com.server_0.dao.mappers.user;

import com.server_0.dao.entity.user.TUInteractionInfo;

public interface TUInteractionInfoDao {
    int deleteByPrimaryKey(Long userId);

    int insert(TUInteractionInfo record);

    int insertSelective(TUInteractionInfo record);

    TUInteractionInfo selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(TUInteractionInfo record);

    int updateByPrimaryKey(TUInteractionInfo record);

    int updateCountByPrimaryKeySelective(TUInteractionInfo record);

    int updateSubCountByPrimaryKeySelective(TUInteractionInfo record);
}