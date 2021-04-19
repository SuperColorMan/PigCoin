package com.server_0.controller.gambit;

import com.server_0.comm.web.ServerResponse;
import com.server_0.service.gambit.GambitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

/**
 * @ClassName GambitController
 * @Description 话题控制器
 * @Author SuperColorMan
 * @Date 2021/1/4 9:21 上午
 * @ModifyDate 2021/1/4 9:21 上午
 * @Version 1.0
 */
@CrossOrigin
@RestController
@RequestMapping("/g/")
public class GambitController {
    @Autowired
    GambitService gambitService;

    /**
     * 获取指定id的话题信息
     *
     * @param id 话题id
     */
    @PostMapping("getGambitById")
    ServerResponse getGambitById(Long id) {
        return gambitService.getGambitById(id);
    }

    /**
     * 获取指定话题中的优秀贡献者
     */
    @PostMapping("getExcellentUserListByGambitId")
    public ServerResponse getExcellentUserListByGambitId(Long gambitId) {
        return gambitService.getExcellentUserListByGambitId(gambitId);
    }


    /**
     * 获取指定内容加入的话题列表
     */
    @PostMapping("getJoinGambitListByContentId")
    ServerResponse getJoinGambitListByContentId(Long contentId) {
        return gambitService.getJoinGambitListByContentId(contentId);
    }

    /**
     * 获取话题与下属话题的树形结构
     */
    @PostMapping("getGambitClassifyTree")
    ServerResponse getGambitClassifyTree(Long loginUserId) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return gambitService.getGambitClassifyTree(loginUserId);
    }


    /**
     * 搜索话题并构建话题树
     */
    @PostMapping("searchGambitBuildTree")
    ServerResponse searchGambitBuildTree(Long loginUserId, String keyWord) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return gambitService.searchGambitBuildTree(loginUserId, keyWord);
    }

    /**
     * 搜索话题
     */
    @PostMapping("searchGambit")
    ServerResponse searchGambit(Long loginUserId, String keyWord) {
        loginUserId = Objects.isNull(loginUserId) ? 0 : loginUserId;
        return gambitService.searchGambit(loginUserId, keyWord);
    }

    /**
     * 获取最热的话题列表
     */
    @PostMapping("getHotGambitList")
    ServerResponse getHotGambitList() {
        return gambitService.getHotGambitList();
    }

    /**
     * 获取指定用户加入的话题
     */
    @PostMapping("getJoinGambitListByUserId")
    ServerResponse getJoinGambitListByUserId(Long userId) {
        return gambitService.getJoinGambitListByUserId(userId);
    }


}
