package com.server_0.dao.mappers.content;


import com.server_0.dao.entity.content.TCContent;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TCContentDao {
    int deleteByPrimaryKey(Long id);

    int insert(TCContent tcContent);

    int insertSelective(TCContent tcContent);

    int isComment(@Param("userId") Long userId, @Param("contentId") Long contentId);

    List<TCContent> getByCollectAndGoodContentListByUserId(@Param("userId") Long userId,
                                                           @Param("page") Long page,
                                                           @Param("pageSize") Long pageSize,
                                                           @Param("loginUserId") Long loginUserId);

    List<TCContent> getByCommentAndAtContentListByUserId(@Param("userId") Long userId,
                                                         @Param("page") Long page,
                                                         @Param("pageSize") Long pageSize,
                                                         @Param("loginUserId") Long loginUserId);

    List<TCContent> getUserAllContentList(@Param("userId") Long userId,
                                          @Param("page") Long page,
                                          @Param("pageSize") Long pageSize,
                                          @Param("loginUserId") Long loginUserId);

    TCContent selectByPrimaryKey(@Param("id") Long id,
                                 @Param("loginUserId") Long loginUserId);

    List<TCContent> getHotCommentContentListByGambitId(@Param("gambitId") Long gambitId,
                                                       @Param("page") Long page,
                                                       @Param("pageSize") Long pageSize,
                                                       @Param("loginUserId") Long loginUserId);

    /**
     * 获取推荐神评列表
     */
    List<TCContent> getRecommendHotCommentContentList(@Param("page") Long page,
                                                      @Param("pageSize") Long pageSize,
                                                      @Param("loginUserId") Long loginUserId);

    List<TCContent> getContentListByGambitIdAndType(@Param("gambitId") Long gambitId,
                                                    @Param("page") Long page,
                                                    @Param("pageSize") Long pageSize,
                                                    @Param("loginUserId") Long loginUserId,
                                                    @Param("type") Integer type);

    List<TCContent> getGoodContentListByUserId(@Param("userId") Long userId,
                                               @Param("page") Long page,
                                               @Param("pageSize") Long pageSize,
                                               @Param("loginUserId") Long loginUserId);

    List<TCContent> getCollectContentListByUserId(@Param("userId") Long userId,
                                                  @Param("page") Long page,
                                                  @Param("pageSize") Long pageSize,
                                                  @Param("loginUserId") Long loginUserId);

    List<TCContent> getByGoodContentListByUserId(@Param("userId") Long userId,
                                                 @Param("page") Long page,
                                                 @Param("pageSize") Long pageSize,
                                                 @Param("loginUserId") Long loginUserId);

    List<TCContent> getByCollectContentListByUserId(@Param("userId") Long userId,
                                                    @Param("page") Long page,
                                                    @Param("pageSize") Long pageSize,
                                                    @Param("loginUserId") Long loginUserId);

    List<TCContent> getUserCommentContentListByUserId(@Param("userId") Long userId,
                                                      @Param("page") Long page,
                                                      @Param("pageSize") Long pageSize,
                                                      @Param("loginUserId") Long loginUserId);

    List<TCContent> getCommentAndAtContentByUserId(@Param("userId") Long userId,
                                                   @Param("page") Long page,
                                                   @Param("pageSize") Long pageSize,
                                                   @Param("loginUserId") Long loginUserId);

    List<TCContent> getContentListByUserId(@Param("userId") Long userId,
                                           @Param("page") Long page,
                                           @Param("pageSize") Long pageSize,
                                           @Param("loginUserId") Long loginUserId);

    List<TCContent> getContentByType(@Param("contentClassify") String contentClassify,
                                     @Param("page") Long page,
                                     @Param("pageSize") Long pageSize,
                                     @Param("loginUserId") Long loginUserId);

    // 获取图文内容
    List<TCContent> getImgAndTextContent(@Param("page") Long page,
                                         @Param("pageSize") Long pageSize,
                                         @Param("loginUserId") Long loginUserId);

    // 获取文字内容
    List<TCContent> getTextContent(@Param("page") Long page,
                                   @Param("pageSize") Long pageSize,
                                   @Param("loginUserId") Long loginUserId);

    // 获取最新内容
    List<TCContent> getNewContent(@Param("page") Long page,
                                  @Param("pageSize") Long pageSize,
                                  @Param("loginUserId") Long loginUserId);

    // 获取最热内容
    List<TCContent> getHotContent(@Param("page") Long page,
                                  @Param("pageSize") Long pageSize,
                                  @Param("loginUserId") Long loginUserId);

    List<TCContent> searchContent(@Param("keyWord") String keyWord,
                                  @Param("page") Long page,
                                  @Param("pageSize") Long pageSize,
                                  @Param("loginUserId") Long loginUserId);

    List<TCContent> searchHotContent(@Param("keyWord") String keyWord,
                                     @Param("page") Long page,
                                     @Param("pageSize") Long pageSize,
                                     @Param("loginUserId") Long loginUserId);

    List<TCContent> searchNewsContent(@Param("keyWord") String keyWord,
                                      @Param("page") Long page,
                                      @Param("pageSize") Long pageSize,
                                      @Param("loginUserId") Long loginUserId);


    List<TCContent> searchTextContent(@Param("keyWord") String keyWord,
                                      @Param("page") Long page,
                                      @Param("pageSize") Long pageSize,
                                      @Param("loginUserId") Long loginUserId);

    List<TCContent> searchImageContent(@Param("keyWord") String keyWord,
                                       @Param("page") Long page,
                                       @Param("pageSize") Long pageSize,
                                       @Param("loginUserId") Long loginUserId);

    List<TCContent> getLookContentHistoryByUserId(@Param("keyWord") String keyWord,
                                                  @Param("page") Long page,
                                                  @Param("pageSize") Long pageSize,
                                                  @Param("loginUserId") Long loginUserId);

    int updateByPrimaryKeySelective(TCContent record);

    int updateByPrimaryKey(TCContent record);

    /**
     * 获取没有互动信息的内容id或类型
     */
    List<Map> getNotInteractionInfoContent();
}