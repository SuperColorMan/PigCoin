package com.server_0.dao.mappers.content;


import com.server_0.dao.entity.content.TCComment;
import com.server_0.dao.entity.content.TCReply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TCReplyDao {
    int deleteByPrimaryKey(Long id);

    int insert(TCReply record);

    int insertSelective(TCReply record);

    Long getCount(@Param("contentId") Long contentId);

    /**
     * 获取指定用户的被回复的列表
     * */
    List<TCReply> selectReplyListByUserId(
            @Param("userId") Long userId,
            @Param("page") Long page,
            @Param("pageSize") Long pageSize,
            @Param("loginUserId") Long loginUserId);

    TCReply selectByPrimaryKey(@Param("id") Long id,
                               @Param("contentId") Long contentId,
                               @Param("commentId") Long commentId,
                               @Param("replyType") int replyType,
                               @Param("loginUserId") Long loginUserId);

    List<TCReply> selectReplyListByCommentId(
            @Param("contentId") Long contentId,
            @Param("commentId") Long commentId,
            @Param("page") Long page,
            @Param("pageSize") Long pageSize,
            @Param("loginUserId") Long loginUserId);

    List<TCReply> getHotReplyByCommentId(@Param("commentId") Long commentId,
                                         @Param("loginUserId") Long loginUserId,
                                         @Param("commentIdList") List<Long> commentIdList);

    List<TCReply> getHotReplyListByContentAndCommentId(
            @Param("userIdList") List<Long> userIdList,
            @Param("contentIdList") List<Long> contentIdList,
            @Param("commentIdList") List<Long> commentIdList,
            @Param("loginUserId") Long loginUserId);


    int updateByPrimaryKeySelective(TCReply record);

    int updateByPrimaryKey(TCReply record);
}