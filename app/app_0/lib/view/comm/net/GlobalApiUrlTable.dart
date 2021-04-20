/// -------------------------------
/// Des: 全局api uri表
/// -------------------------------
class GlobalApiUrlTable {
  /// 协议
  static const String PROTOCOL = "http://";

  /// 接口ip
  static const String IP = "127.0.0.1";

  /// 端口
  static const String PORT = "8899";

  /// 测试接口URI
  static const String TEST_API = PROTOCOL + IP + ":" + PORT + "/api/test/test";

  /// -------------------------------------------- 互动接口模块 start --------------------------------------------

  /// ---------------------------- 点赞区域 start ----------------------------

  /// 内容点赞接口URI
  static const String CONTENT_GODD_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/goodContent";

  /// 取消内容点赞接口URI
  static const String CANCEL_CONTENT_GODD_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelGoodContent";

  /// 评论点赞接口URI
  static const String COMMENT_GODD_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/goodComment";

  /// 取消评论点赞接口URI
  static const String CANCEL_COMMENT_GODD_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelGoodComment";

  /// 回复点赞接口URI
  static const String REPLY_GODD_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/goodReply";

  /// 取消回复点赞接口URI
  static const String CANCEL_REPLY_GODD_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelGoodReply";

  /// ---------------------------- 点赞区域 end ----------------------------

  /// ---------------------------- 点踩区域 start ----------------------------
  /// 内容点踩接口URI
  static const String CONTENT_DISS_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/dissContent";

  /// 取消内容点踩接口URI
  static const String CANCEL_CONTENT_DISS_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelGoodContent";

  /// 评论点踩接口URI
  static const String COMMENT_DISS_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/dissComment";

  /// 取消评论点踩接口URI
  static const String CANCEL_COMMENT_DISS_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelDissComment";

  /// 回复点踩接口URI
  static const String REPLY_DISS_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/dissReply";

  /// 取消回复点踩接口URI
  static const String CANCEL_REPLY_DISS_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelDissReply";

  /// ---------------------------- 点踩区域 start ----------------------------

  /// ---------------------------- 收藏区域 start ----------------------------
  /// 内容收藏接口URI
  static const String CONTENT_COLLECT_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/collectContent";

  /// 取消内容收藏接口URI
  static const String CANCEL_CONTENT_COLLECT_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelCollectContent";

  /// 评论收藏接口URI
  static const String COMMENT_COLLECT_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/collectComment";

  /// 取消评论收藏接口URI
  static const String CANCEL_COMMENT_COLLECT_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelCollectComment";

  /// 回复收藏接口URI
  static const String REPLY_COLLECT_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/collectReply";

  /// 取消回复收藏接口URI
  static const String CANCEL_REPLY_COLLECT_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelCollectReply";

  /// ---------------------------- 收藏区域 start ----------------------------

  /// ---------------------------- 查看区域 start ----------------------------
  /// 内容查看接口URI
  static const String CONTENT_LOOK_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/lookContent";

  /// 取消内容查看接口URI
  static const String CANCEL_CONTENT_LOOK_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelLookContent";

  /// 评论查看接口URI
  static const String COMMENT_LOOK_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/lookComment";

  /// 取消评论查看接口URI
  static const String CANCEL_COMMENT_LOOK_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelLookComment";

  /// 回复查看接口URI
  static const String REPLY_LOOK_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/lookReply";

  /// 取消回复查看接口URI
  static const String CANCEL_REPLY_LOOK_API =
      PROTOCOL + IP + ":" + PORT + "/api/interaction/cancelLookReply";

  /// ---------------------------- 查看区域 start ----------------------------
  ///
  /// -------------------------------------------- 互动接口模块 end --------------------------------------------

  /// -------------------------------------------- 用户模块 start --------------------------------------------
  /// 根据用户id获取用户信息
  static const String GET_USER_INFO_BY_ID =
      PROTOCOL + IP + ":" + PORT + "/api/user/getUserInfoById";

  /// 根据用户名称获取用户信息
  static const String GET_USER_INFO_BY_NAME =
      PROTOCOL + IP + ":" + PORT + "/api/user/getUserInfoByName";

  /// 搜搜用户
  static const String SEARCH_USER =
      PROTOCOL + IP + ":" + PORT + "/api/user/searchUser";

  /// 获取指定用户关注的用户列表
  static const String GET_USER_ATTENTION_LIST =
      PROTOCOL + IP + ":" + PORT + "/api/user/getUserAttentionListById";

  /// 获取指定用户的粉丝列表
  static const String GET_FANS_LIST_BY_USER_ID =
      PROTOCOL + IP + ":" + PORT + "/api/user/getFansListByUserId";

  /// 获取指定用户被点赞与收藏的内容
  static const String GET_BY_COLLECT_AND_GOOD_CONTENT_LIST_BY_USER_ID =
      PROTOCOL +
          IP +
          ":" +
          PORT +
          "/api/c/getByCollectAndGoodContentListByUserId";

  /// 获取指定用户被评论与@的内容
  static const String GET_BY_COMMENT_AND_AT_CONTENT_LIST_BY_USER_ID = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/c/getByCommentAndAtContentListByUserId";

  /// 上传用户头像
  static const String UP_USER_HEAD_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/user/upUserHeadPic";

  /// 上传用户背景
  static const String UP_USER_BG_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/user/upUserBgPic";

  /// 编辑用户信息
  static const String USER_EDIT_INFO =
      PROTOCOL + IP + ":" + PORT + "/api/user/editUserInfo";

  /// 编辑用户个人设置
  static const String USER_EDIT_SETTING =
      PROTOCOL + IP + ":" + PORT + "/api/user/editUserSetting";

  /// -------------------------------------------- 用户模块 end --------------------------------------------

  /// -------------------------------------------- 话题模块 start --------------------------------------------
  /// 获取话题分类树
  static const String GET_GAMBIT_TREE =
      PROTOCOL + IP + ":" + PORT + "/api/g/getGambitClassifyTree";

  /// 搜索话题
  static const String SEARCH_GAMBIT =
      PROTOCOL + IP + ":" + PORT + "/api/g/searchGambit";

  /// -------------------------------------------- 话题模块 end --------------------------------------------

  /// -------------------------------------------- 内容模块 start --------------------------------------------

  /// 搜索内容接口URI
  static const String SEARCH_CONTENT =
      PROTOCOL + IP + ":" + PORT + "/api/c/searchContent";

  /// 内容发送接口URI
  static const String UP_CONTENT_API =
      PROTOCOL + IP + ":" + PORT + "/api/c/upContent";

  /// 评论内容发送接口URI
  static const String COMMENT_CONTENT_API =
      PROTOCOL + IP + ":" + PORT + "/api/c/commentContent";

  /// 回复发送接口URI
  static const String REPLY_API = PROTOCOL + IP + ":" + PORT + "/api/c/reply";

  /// 获取指定分类的内容URI
  static const String GET_CONTENT_BY_TYPE_API =
      PROTOCOL + IP + ":" + PORT + "/api/c/getContentByType";

  /// 获取指定用户的查看内容历史
  static const String GET_LOOK_CONTENT_HISTORY_BY_USER_ID =
      PROTOCOL + IP + ":" + PORT + "/api/c/getLookContentHistoryByUserId";

  /// 获取指定分类的内容URI
  static const String GET_USER_CONTNET_BY_CLASSIFY_API =
      PROTOCOL + IP + ":" + PORT + "/api/c/getUserContentByClassify";

  /// 获取获取指定用户指定分类的内容URI
  static const String GET_USER_CLASSIFY_CONTENT =
      PROTOCOL + IP + ":" + PORT + "/api/c/getContentByType";

  /// 获取搜索结果集分类
  static const String GET_SEARCH_RESULT_TYPE_API =
      PROTOCOL + IP + ":" + PORT + "/api/c/getSearchResultType";

  /// 获取指定内容加入的话题列表
  static const String GET_JOIN_GAMBIT_LIST_BY_CONTENT_ID =
      PROTOCOL + IP + ":" + PORT + "/api/g/getJoinGambitListByContentId";

  /// 获取话题下的内容列表
  static const String GET_CONTENT_LIST_BY_GAMBIT_ID =
      PROTOCOL + IP + ":" + PORT + "/api/c/getContentListByGambitId";

  /// -------------------------------------------- 内容模块 end --------------------------------------------

  /// -------------------------------------------- 评论模块 start --------------------------------------------
  /// 获取指定内容下热门评论列表URI
  static const String GET_HOT_COMMENT_LIST_API =
      PROTOCOL + IP + ":" + PORT + "/api/comment/getHotCommentListByContentId";

  /// 获取指定内容下评论列表URI
  static const String GET_COMMENT_List_API =
      PROTOCOL + IP + ":" + PORT + "/api/comment/getCommentListByContentId";

  /// 获取指定用户发起评论的内容
  static const String GET_USER_COMMENT_CONTENT_LIST = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/comment/getUserCommentContentListByUserId";

  /// -------------------------------------------- 评论模块 end --------------------------------------------

  /// -------------------------------------------- 回复模块 start --------------------------------------------
  /// 获取指定评论下的回复列表URI
  static const String GET_REPLY_LIST_API =
      PROTOCOL + IP + ":" + PORT + "/api/reply/getReplyListByCommentId";

  /// -------------------------------------------- 回复模块 end --------------------------------------------

  /// -------------------------------------------- 登录接口模块 start --------------------------------------------

  /// 登录URI
  static const String REGISTER_API =
      PROTOCOL + IP + ":" + PORT + "/api/login/register";

  /// 注册URI
  static const String LOGIN_API =
      PROTOCOL + IP + ":" + PORT + "/api/login/login";

  /// -------------------------------------------- 登录接口模块 end --------------------------------------------

  /// -------------------------------------------- 图片模块接口 start --------------------------------------------

  /// 获取用户头像
  static const String GET_USER_HEAD_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/img/getUserHeadPic";

  /// 获取用户壁纸
  static const String GET_USER_BG_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/img/getUserBgPic";

  /// 获取内容图片
  static const String GET_CONTENT_IMG =
      PROTOCOL + IP + ":" + PORT + "/api/img/getContentImg";

  /// 获取评论图片
  static const String GET_COMMENT_IMG =
      PROTOCOL + IP + ":" + PORT + "/api/img/getCommentImg";

  /// 获取回复图片
  static const String GET_REPLY_IMG =
      PROTOCOL + IP + ":" + PORT + "/api/img/getReplyImg";

  /// 获取话题头像图片
  static const String GET_GAMBIT_HEAD_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/img/getGambitHeadPic";

  /// 获取商品分类图片
  static const String COMMODITY_CLASSIFY_HEAD_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/img/getCommodityHeadPic";

  /// 获取私信图片,根据私信id
  static const String CHAT_IMG_BY_CHAT_ID =
      PROTOCOL + IP + ":" + PORT + "/api/img/getChatImgByChatId";

  /// 获取私信图片,根据主键id
  static const String CHAT_IMG_BY_ID =
      PROTOCOL + IP + ":" + PORT + "/api/img/getChatImgById";

  /// 获取商品相关图片
  static const String GET_COMMODITY_PIC =
      PROTOCOL + IP + ":" + PORT + "/api/img/getCommodityPic";

  /// -------------------------------------------- 图片模块接口 end --------------------------------------------

  /// -------------------------------------------- 计算接口模块 start --------------------------------------------

  /// 获取用户今日新增数据信息
  static const String CAL_USER_TO_DAY_INFO =
      PROTOCOL + IP + ":" + PORT + "/api//cal/user/getToDatInfoByUserId";

  /// 获取指定用户总体卖出商品量
  static const String GET_SALE_COMMODITY_SUM = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getSaleCommoditySumByUserId";

  /// 获取指定用户发布的商品的总体分类
  static const String CAL_COMMODITY_CLASSIFY = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getCommodityClassifyByUserId";

  /// 获取指定用户卖出商品的分类
  static const String CAL_SALE_COMMODITY_CLASSIFY = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getSaleCommodityClassifyByUserId";

  /// ---------------------------- 商品卖出量 start ----------------------------
  /// 获取用户周卖出量
  static const String CAL_SALE_COMMODITY_SUM_BY_WEEK = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getSaleCommoditySumByWeekByUserId";

  /// 获取用户月卖出量
  static const String CAL_SALE_COMMODITY_SUM_BY_MONTH = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getSaleCommoditySumByMonthByUserId";

  /// 获取用户年卖出量
  static const String CAL_SALE_COMMODITY_SUM_BY_YEAR = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getSaleCommoditySumByYearByUserId";

  /// ---------------------------- 商品卖出量 end ----------------------------

  /// ---------------------------- 商品浏览量 start ----------------------------
  /// 获取用户周卖出量
  static const String CAL_LOOK_COMMODITY_SUM_BY_WEEK = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getLookCommoditySumByWeekByUserId";

  /// 获取用户月卖出量
  static const String CAL_LOOK_COMMODITY_SUM_BY_MONTH = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getLookCommoditySumByMonthByUserId";

  /// 获取用户年卖出量
  static const String CAL_LOOK_COMMODITY_SUM_BY_YEAR = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api//cal/commodity/getLookCommoditySumByYearByUserId";

  /// ---------------------------- 商品浏览量 end ----------------------------

  /// ---------------------------- 商品被加入购物车量 start ----------------------------
  /// 获取用户周卖出量
  static const String CAL_JOIN_SHOP_CAR_COMMODITY_SUM_BY_WEEK = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/cal/commodity/getJoinShopCarCommoditySumByWeekByUserId";

  /// 获取用户月卖出量
  static const String CAL_JOIN_SHOP_CAR_COMMODITY_SUM_BY_MONTH = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/cal/commodity/getJoinShopCarCommoditySumByMonthByUserId";

  /// 获取用户年卖出量
  static const String CAL_JOIN_SHOP_CAR_COMMODITY_SUM_BY_YEAR = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/cal/commodity/getJoinShopCarCommoditySumByYearByUserId";

  /// 获取指定内容的关联商品
  static const String GET_REL_COMMODITY_BY_CONTENT_ID = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/cal/commodity/getRelCommodityByContentId";

  /// ---------------------------- 商品被加入购物车量 end ----------------------------

  /// -------------------------------------------- 计算接口模块 end --------------------------------------------

  /// -------------------------------------------- 商城模块 start --------------------------------------------

  /// 获取指定用户的商品
  static const String GET_COMMODITY_LIST_BY_USER_ID =
      PROTOCOL + IP + ":" + PORT + "/api/commodity/getCommodityListByUserId";

  /// 获取指定用户关注的用户发布的商品
  static const String GET_COMMODITY_LIST_BY_USER_ATTENTION_USER = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/commodity/getCommodityListByUserAttentionUser";

  /// 获取推荐商品
  static const String GET_RECOMMEND_COMMODITY_LIST =
      PROTOCOL + IP + ":" + PORT + "/api/commodity/getRecommendCommodityList";

  /// 获取大类列表
  static const String GET_COMMODITY_LIST_BY_BIG_CLASSIFY_ID = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/commodity/getCommodityListByBigClassifyId";

  /// 获取指定多个分类的商品
  static const String GET_COMMODITY_LIST_BY_CLASSIFYS = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/commodity/getCommodityListByClassifys";

  /// 获取大类列表
  static const String GET_BIG_CLASSIFY_LIST =
      PROTOCOL + IP + ":" + PORT + "/api/commodityclassify/getBigClassifyList";

  /// 获取指定大类下的小类列表
  static const String GET_SMALL_CLASSIFY_LIST_BY_BIG_CLASSIFY_ID = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/commodityclassify/getSmallClassifyListByBigClassifyId";

  /// 获取商品分类树
  static const String GET_COMMODITY_CLASSIFY_TREE = PROTOCOL +
      IP +
      ":" +
      PORT +
      "/api/commodityclassify/getCommodityClassifyTree";

  /// 评论商品发送接口URI
  static const String COMMENT_COMMODITY_API =
      PROTOCOL + IP + ":" + PORT + "/api/c/commentCommodity";

  /// 以用户身份发布商品接口URI
  static const String COMMODITY_RELEASE_BY_USER =
      PROTOCOL + IP + ":" + PORT + "/api/commodity/addCommodityByUser";

  /// -------------------------------------------- 商城模块 end --------------------------------------------

  /// -------------------------------------------- 消息模块 start --------------------------------------------
  /// 获取系统消息或私信消息接口
  static const String SYS_MESSAGE_OR_CHAT =
      PROTOCOL + IP + ":" + PORT + "/api/message/getMessageByUserId";

  /// -------------------------------------------- 消息模块 end --------------------------------------------

}
