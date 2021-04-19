package com.server_0.dao.entity.gambit;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * t_g_classify
 *
 * @author
 */
@Data
public class TGClassify implements Serializable {
    /**
     * 主键
     */
    private Long id;

    /**
     * 分类名称
     */
    private String name;

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
     * 加入的话题列表
     */
    private List<TGGambit> tgGambitList;

    private static final long serialVersionUID = 1L;
}