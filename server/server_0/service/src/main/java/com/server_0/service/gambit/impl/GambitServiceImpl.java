package com.server_0.service.gambit.impl;

import com.server_0.comm.web.ServerResponse;
import com.server_0.dao.entity.gambit.TGClassify;
import com.server_0.dao.entity.gambit.TGGambit;
import com.server_0.dao.entity.user.TUUser;
import com.server_0.dao.mappers.gambit.TGClassifyDao;
import com.server_0.dao.mappers.gambit.TGGambitDao;
import com.server_0.dao.mappers.user.TUUserDao;
import com.server_0.service.gambit.GambitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

/**
 * @ClassName GambitServiceImpl
 * @Description 话题服务层接口实现类
 * @Author SuperColorMan
 * @Date 2021/1/4 9:24 上午
 * @ModifyDate 2021/1/4 9:24 上午
 * @Version 1.0
 */
@Service
public class GambitServiceImpl implements GambitService {
    @Autowired
    TGClassifyDao tgClassifyDao;
    @Autowired
    TGGambitDao tgGambitDao;
    @Autowired
    TUUserDao tuUserDao;

    /**
     * 获取指定id的话题信息
     *
     * @param id 话题id
     */
    @Override
    public ServerResponse getGambitById(Long id) {
        TGGambit tgGambit = tgGambitDao.selectByPrimaryKey(id);
        return ServerResponse.success("ok", tgGambit);
    }

    /**
     * 获取指定话题中的优秀贡献者
     *
     * @param gambitId 话题id
     */
    @Override
    public ServerResponse getExcellentUserListByGambitId(Long gambitId) {
        List<TUUser> tuUserList = tuUserDao.getExcellentUserListByGambitId(gambitId);
        return ServerResponse.success("ok", tuUserList);
    }

    /**
     * 获取指定内容加入的话题列表
     */
    @Override
    public ServerResponse getJoinGambitListByContentId(Long contentId) {
        return ServerResponse.success("ok", tgGambitDao.getJoinGambitListByContentId(contentId));
    }

    /**
     * 获取话题与下属话题的树形结构
     */
    @Override
    public ServerResponse getGambitClassifyTree(Long loginUserId) {
        if (Objects.isNull(loginUserId)) {
            loginUserId = -1L;
        }
        List<TGClassify> gambitTree=tgClassifyDao.selectAllClassify();
        return ServerResponse.success("ok", gambitTree);
    }

    /**
     * 搜索话题并构建话题树
     */
    @Override
    public ServerResponse searchGambitBuildTree(Long loginUserId, String keyWord) {
        if (Objects.isNull(loginUserId)) {
            loginUserId = -1L;
        }
        return ServerResponse.success("ok", tgClassifyDao.searchGambitBuildTree(keyWord));
    }

    /**
     * 搜索话题
     */
    @Override
    public ServerResponse searchGambit(Long loginUserId, String keyWord) {
        if (Objects.isNull(loginUserId)) {
            loginUserId = -1L;
        }
        return ServerResponse.success("ok", tgGambitDao.searchGambit(keyWord, null, null));
    }

    /**
     * 获取最热的话题列表
     */
    @Override
    public ServerResponse getHotGambitList() {
        List<TGGambit> tgGambitList = tgGambitDao.getHotGambitList();
        return ServerResponse.success("ok", tgGambitList);
    }

    /**
     * 获取指定用户加入的话题
     */
    @Override
    public ServerResponse getJoinGambitListByUserId(Long userId) {
        List<TGGambit> tgGambitList = tgGambitDao.getJoinGambitListByUserId(userId);
        return ServerResponse.success("ok", tgGambitList);
    }
}
