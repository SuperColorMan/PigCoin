package com.server_0.dao.mappers.record;

import com.server_0.dao.entity.record.TRecAttention;
import com.server_0.dao.entity.record.TRecColl;
import com.server_0.dao.entity.record.TRecGood;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TRecCollDao {

    int isExiset(@Param("resId") Long resId,
                 @Param("type") String srcId,
                 @Param("userId") Long userId);

    Long getCount(@Param("resId") Long resId,
                  @Param("type") String srcId);

    int deleteByPrimaryKey(Long id);

    int deleteSelective(TRecColl record);

    int insert(TRecColl record);

    int insertSelective(TRecColl record);

    TRecColl selectByPrimaryKey(Long id);

    List<TRecColl> getByCollectContentListByUserId(@Param("userId") Long userId,
                                                        @Param("loginUserId") Long loginUserId,
                                                        @Param("page") Long page,
                                                        @Param("pageSize") Long pageSize);

    int updateByPrimaryKeySelective(TRecColl record);

    int updateByPrimaryKey(TRecColl record);
}