package com.server_0.dao.mappers.cal.content;

import com.server_0.dao.entity.content.TCContent;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ContentCalDao {
    List<TCContent> getContentListByGambitId(@Param("userId") Long userId,
                                          @Param("page") Long page,
                                          @Param("pageSize") Long pageSize,
                                          @Param("contentImgType") int contentImgType,
                                          @Param("commentImgType") int commentImgType,
                                          @Param("contentType") int contentType,
                                          @Param("loginUserId") Long loginUserId);
}
