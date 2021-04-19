package com.server_0.dao.entity.gambit;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.server_0.dao.entity.user.TUUser;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_g_gambit
 *
 * @author
 */
@Data
public class TGGambit implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 内容标题
     */
    private String name;

    /**
     * 话题头像文件名
     */
    private String headPicName;

    /**
     * 参与内容数字
     */
    private Long contentCount;

    /**
     * 分类id
     */
    private Long classifyId;

    /**
     * 内容创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createTime;

    /**
     * 是否删除,0:否,1:是
     */
    private String isDel;

    /**
     * 话题中的优秀贡献者
     */
    private List<TUUser> excellentUserList;

    private static final long serialVersionUID = 1L;
}