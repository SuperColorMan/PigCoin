package com.server_0.dao.mappers.img;


import com.server_0.dao.entity.img.TImgInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TImgInfoDao {

    int isExiset(@Param("srcId") Long srcId, @Param("srcType") String srcType);

    int deleteByPrimaryKey(Long id);

    int insert(TImgInfo record);

    int insertSelective(TImgInfo record);

    TImgInfo selectByPrimaryKey(@Param("id") Long id,@Param("srcImgType") String srcImgType);

    TImgInfo selectBySrcIdAndType(@Param("srcId") Long srcId,@Param("srcImgType") String srcImgType);

    List<TImgInfo> selectListBySrcIdAndType(@Param("srcId") Long srcId,@Param("srcImgType") String srcImgType);

    int updateByPrimaryKeySelective(TImgInfo record);

    int updateByPrimaryKey(TImgInfo record);
}