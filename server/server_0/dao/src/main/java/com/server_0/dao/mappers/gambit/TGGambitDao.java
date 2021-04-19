package com.server_0.dao.mappers.gambit;


import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.gambit.TGGambit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TGGambitDao {

    long isExistData();

    int deleteByPrimaryKey(Long id);

    int insert(TGGambit record);

    int insertSelective(TGGambit record);

    TGGambit selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TGGambit record);

    int updateByPrimaryKey(TGGambit record);

    List<TGGambit> getJoinGambitListByContentId(@Param("contentId") Long contentId);

    /**
     * 获取最热话题
     * */
    List<TGGambit> getHotGambitList();

    List<TGGambit> selectListByClassify(@Param("classifyId") Long classifyId);

    List<TGGambit> searchGambit(@Param("keyWord") String keyWord,
                                @Param("page") Long page,
                                @Param("pageSize") Long pageSize);

    /**
     * 获取指定用户加入的话题
     */
    List<TGGambit> getJoinGambitListByUserId(Long userId);
}