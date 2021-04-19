package com.server_0.dao.mappers.gambit;


import com.server_0.dao.entity.gambit.TGClassify;
import com.server_0.dao.entity.gambit.TGGambit;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TGClassifyDao {
    int deleteByPrimaryKey(Long id);

    int insert(TGClassify record);

    int insertSelective(TGClassify record);

    TGClassify selectByPrimaryKey(Long id);

    List<TGClassify> selectAllClassify();

    List<TGGambit> searchGambitBuildTree(@Param("keyWord") String keyWord);

    int updateByPrimaryKeySelective(TGClassify record);

    int updateByPrimaryKey(TGClassify record);
}