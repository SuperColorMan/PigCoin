package com.server_0.dao.mappers.record;

import com.server_0.dao.entity.record.TRecAttention;
import com.server_0.dao.entity.record.TRecGood;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TRecGoodDao {

    int isExiset(@Param("userId") Long userId,
                 @Param("resId") Long resId,
                 @Param("type") String type);

    Long getCount(@Param("resId") Long resId,
                  @Param("type") Integer srcId);

    int deleteByPrimaryKey(Long id);

    int deleteSelective(TRecGood record);

    int insert(TRecGood record);

    int insertSelective(TRecGood record);

    TRecGood selectByPrimaryKey(Long id);

    List<TRecGood> getByGoodContentListByUserId(@Param("userId") Long userId,
                                                     @Param("loginUserId") Long loginUserId,
                                                     @Param("page") Long page,
                                                     @Param("pageSize") Long pageSize);

    int updateByPrimaryKeySelective(TRecGood record);

    int updateByPrimaryKey(TRecGood record);
}