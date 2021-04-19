package com.server_0.dao.mappers.user;

import com.server_0.dao.entity.user.TUUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TUUserDao {

    int isExistUId(@Param("uid") String uid);

    int isExistUserName(@Param("name") String name);

    int deleteByPrimaryKey(Long id);

    int insert(TUUser record);

    int verifyAccount(@Param("account") String account, @Param("pass") String pass);

    int insertSelective(TUUser record);

    TUUser selectByPrimaryKey(Long id);

    TUUser selectByName(@Param("userName") String userName);

    List<TUUser> getFansListByUserId(@Param("userId") Long userId,
                            @Param("page") Long page,
                            @Param("pageSize") Long pageSize);

    List<TUUser> searchUser(@Param("keyWord") String keyWord,
                            @Param("page") Long page,
                            @Param("pageSize") Long pageSize);

    List<TUUser> getUserAttentionListById(@Param("userId") Long userId,
                            @Param("page") Long page,
                            @Param("pageSize") Long pageSize);

    List<TUUser> getExcellentUserListByGambitId(@Param("gambitId") Long gambitId);

    TUUser selectByPrimaryAccount(@Param("account") String account, @Param("pass") String pass);

    int updateByPrimaryKeySelective(TUUser record);

    int updateByPrimaryKey(TUUser record);
}