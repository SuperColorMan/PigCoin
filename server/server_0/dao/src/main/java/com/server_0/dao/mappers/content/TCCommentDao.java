package com.server_0.dao.mappers.content;


import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.content.TCComment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TCCommentDao {
    int deleteByPrimaryKey(Long id);

    int insert(TCComment record);

    int insertSelective(TCComment record);

    Long getCount(@Param("contentId") Long contentId);

    TCComment selectByPrimaryKey(@Param("id") Long id, @Param("loginUserId") Long loginUserId);

    /**
     * 获取指定内容的神评论
     */
    List<TCComment> getHotCommentListByContentId(@Param("contentId") Long contentId,
                                                 @Param("loginUserId") Long loginUserId,
                                                 @Param("contentIdList") List<Long> contentIdList);

    /**
     * 获取指定内容的评论列表
     */
    List<TCComment> selectCommentListByContentId(@Param("contentId") Long contentId,
                                                 @Param("page") Long page,
                                                 @Param("pageSize") Long pageSize,
                                                 @Param("loginUserId") Long loginUserId,
                                                 @Param("filterIdList") List<String> filterIdList);

    /**
     * 获取指定商品的评论列表
     */
    List<TCComment> selectCommentListByCommodityId(@Param("commodityId") Long commodityId,
                                                   @Param("page") Long page,
                                                   @Param("pageSize") Long pageSize,
                                                   @Param("loginUserId") Long loginUserId);

    /**
     * 获取指定用户的被评论的列表
     *
     * @param userId      用户id
     * @param loginUserId 登录用户id
     * @param page        页号
     * @param pageSize    页大小
     */
    List<TCComment> selectCommentListByUserId(@Param("userId") Long userId,
                                              @Param("loginUserId") Long loginUserId,
                                              @Param("page") Long page,
                                              @Param("pageSize") Long pageSize);

    int updateByPrimaryKeySelective(TCComment record);

    int updateByPrimaryKey(TCComment record);
}