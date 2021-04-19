package com.server_0.dao.mappers.record;

import com.server_0.dao.entity.record.TRecAttention;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TRecAttentionDao {
    int deleteByPrimaryKey(Long id);

    int insert(TRecAttention record);

    int insertSelective(TRecAttention record);

    int deleteSelective(TRecAttention record);

    TRecAttention selectByPrimaryKey(Long id);

    List<TRecAttention> getFansListByUserId(@Param("userId") Long userId,
                                            @Param("page") Long page,
                                            @Param("pageSize") Long pageSize);

    int updateByPrimaryKeySelective(TRecAttention record);

    int updateByPrimaryKey(TRecAttention record);
}