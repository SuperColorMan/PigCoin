package com.server_0.dao.mappers.content;


import com.server_0.dao.entity.content.TCInteractionInfo;
import org.apache.ibatis.annotations.Param;

public interface TCInteractionInfoDao {
    int deleteByPrimaryKey(Long contentId);

    int insert(TCInteractionInfo record);

    int insertSelective(TCInteractionInfo record);

    TCInteractionInfo selectByPrimaryKey(@Param("contentId") Long contentId, @Param("contentType") int contentType);

    int updateByPrimaryKeySelective(TCInteractionInfo record);

    int updateCountByPrimaryKeySelective(TCInteractionInfo record);

    int updateSubCountByPrimaryKeySelective(TCInteractionInfo record);

    int updateByPrimaryKey(TCInteractionInfo record);
}