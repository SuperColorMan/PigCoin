package com.server_0.dao.mappers.user;


import com.server_0.dao.entity.user.TUInformSetting;
import org.apache.ibatis.annotations.Param;

public interface TUInformSettingDao {

    int isExiset(@Param("userId") Long userId);

    int deleteByPrimaryKey(Long userId);

    int insert(TUInformSetting record);

    int insertSelective(TUInformSetting record);

    TUInformSetting selectByPrimaryKey(Long userId);

    int updateByPrimaryKeySelective(TUInformSetting record);

    int updateByPrimaryKey(TUInformSetting record);
}