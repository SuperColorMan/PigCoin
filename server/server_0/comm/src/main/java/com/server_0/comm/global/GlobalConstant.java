package com.server_0.comm.global;

import com.google.common.collect.Queues;
import com.server_0.comm.callback.QueueCallBack;
import org.springframework.core.io.ClassPathResource;

import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.util.Queue;


/**
 * @ClassName GlobalConstant
 * @Description 全局常量
 * @Author SuperColorMan
 * @Date 2021/1/4 1:54 下午
 * @ModifyDate 2021/1/4 1:54 下午
 * @Version 1.0
 */
public class GlobalConstant {
    /**
     * 本地消息队列
     */
    public final static Queue<QueueCallBack> LOCAL_MQ = Queues.newConcurrentLinkedQueue();

    /**
     * 消息队列异常事务句柄处理队列
     */
    public final static Queue<QueueCallBack> EXCEPTION_LOCAL_MQ = Queues.newConcurrentLinkedQueue();

    /**
     * 项目根目录
     */
    public final static String ROOT_DIR() {
        ClassPathResource resource = new ClassPathResource("");
        try {
            return resource.getFile().getAbsolutePath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 热门评论的约束点赞数,超过该值为神评
     */
    public final static int HOT_COMMENT_GOOD_COUNT = 1;

    /**
     * 热门回复的约束点赞数,超过该值为神回复
     */
    public final static int HOT_REPLY_GOOD_COUNT = 1;

    /**
     * 热门评论的显示个数
     */
    public final static int HOT_COMMENT_COUNT = 3;

    /**
     * 热门回复的显示个数
     */
    public final static int HOT_REPLY_COUNT = 3;

    /**
     * 话题最佳贡献者最大人数
     */
    public final static int GAMBIT_EXCELLENT_USER_COUNT = 10;

    /**
     * 用户默认头像
     */
    public final static File DEFAULT_USER_HEAD_PIC = new File(GlobalConstant.ROOT_DIR() + "/imgs/user/default_user_head_pic.jpg");

    /**
     * 用户默认壁纸
     */
    public final static File DEFAULT_USER_BG_PIC = new File(GlobalConstant.ROOT_DIR() + "/imgs/user/default_uesr_bg_pic.jpg");

    /**
     * 话题头像路径
     */
    public final static String GAMBIT_HEAD_PIC = GlobalConstant.ROOT_DIR() + "/imgs/gambit/headpic/";

    /**
     * 话题底量数据文件路径
     */
    public final static File GAMBIT_INIT_DATA_FILE_PATH = new File(GlobalConstant.ROOT_DIR() + "/json/gambit/init_gambit.json");

    /**
     * 话题头像路径
     */
    public final static String COMMODITY_CLASSIFY_HEAD_PIC = GlobalConstant.ROOT_DIR() + "/imgs/shop/classify/";

    /**
     * 商品分类底量数据文件路径
     */
    public final static File COMMODITY_CLASSIFY_INIT_DATA_FILE_PATH = new File(GlobalConstant.ROOT_DIR() + "/json/shop/commodity_classify.json");


    /**
     * 系统表结构初始化文件路径
     */
    public final static File SYS_TABLE_INIT_FILE_PATH = new File(GlobalConstant.ROOT_DIR() + "/sqls/crt_table.sql");

    /**
     * app名称
     */
    public final static String APP_NAME = "浪浪虾";

    /**
     * --------------------------------- 文件上传相关输出文件夹 start ---------------------------------
     * */
    /**
     * 内容图片输出路径
     */
    public final static String CONTENT_IMG_OUT_PUT_FILE_PATH = GlobalConstant.ROOT_DIR() + "/imgs/content/";
    /**
     * 商品图片输出路径
     */
    public final static String COMMODITY_IMG_OUT_PUT_FILE_PATH = GlobalConstant.ROOT_DIR() + "/imgs/commodity/";
    /**
     * 私信图片输出路径
     */
    public final static String CHAT_IMG_OUT_PUT_FILE_PATH = GlobalConstant.ROOT_DIR() + "/imgs/chat/";
    /**
     * --------------------------------- 文件上传相关输出文件夹 end ---------------------------------
     * */
}
