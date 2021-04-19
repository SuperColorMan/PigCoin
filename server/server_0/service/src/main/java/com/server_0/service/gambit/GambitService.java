package com.server_0.service.gambit;

import com.server_0.comm.web.ServerResponse;
import org.springframework.web.bind.annotation.PostMapping;

/**
 * @ClassName GambitServiceImpl
 * @Description 话题服务层接口
 * @Author SuperColorMan
 * @Date 2021/1/4 9:24 上午
 * @ModifyDate 2021/1/4 9:24 上午
 * @Version 1.0
 */
public interface GambitService {

    /**
     * 获取指定id的话题信息
     *
     * @param id 话题id
     */
    ServerResponse getGambitById(Long id);

    /**
     * 获取指定话题中的优秀贡献者
     */
    ServerResponse getExcellentUserListByGambitId(Long gambitId);

    /**
     * 获取指定内容加入的话题列表
     */
    ServerResponse getJoinGambitListByContentId(Long contentId);

    /**
     * 获取话题与下属话题的树形结构
     */
    ServerResponse getGambitClassifyTree(Long loginUserId);

    /**
     * 搜索话题并构建话题树
     */
    ServerResponse searchGambitBuildTree(Long loginUserId, String keyWord);

    /**
     * 搜索话题
     */
    ServerResponse searchGambit(Long loginUserId, String keyWord);

    /**
     * 获取最热的话题列表
     */
    ServerResponse getHotGambitList();

    /**
     * 获取指定用户加入的话题
     */
    ServerResponse getJoinGambitListByUserId(Long userId);
}
