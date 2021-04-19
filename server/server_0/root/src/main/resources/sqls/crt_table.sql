-- -------------------------------- 用户模块 start--------------------------------
-- 用户信息表
create table If Not Exists `t_u_user`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
uid varchar(20) default '' not null COMMENT '用户自定义id',
name varchar(20) default '' not null unique COMMENT '用户名',
sex char(1) default '2' COMMENT '用户性别,0:女,1:男,2:未知',
phone varchar(20) default '' not null COMMENT '手机号',
email varchar(20) default '' not null COMMENT '邮箱',
account	varchar(20) default '' not null unique COMMENT '账号,一般为手机号,唯一',
pass varchar(20) default '' not null COMMENT '密码',
intro varchar(1258) default '' not null COMMENT '简介',
birthday timestamp default current_timestamp COMMENT '生日',
login_time timestamp default now() not null COMMENT '注册时间',
update_time	timestamp default now() not null COMMENT '信息更新时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是,1:否',
is_wo char(1) default '0' COMMENT '是否注销,0:否,1:是'
) COMMENT '用户信息表';

-- 用户互动信息表
create table If Not Exists `t_u_interaction_info`(
user_id bigint(20) PRIMARY KEY not null unique COMMENT '用户id',
attention_count bigint(10) default 0 not null COMMENT '关注数',
fans_count bigint(10) default 0 not null COMMENT '粉丝数',
content_count bigint(10) default 0 not null COMMENT '内容发送数',
by_good_count bigint(10) default 0 not null COMMENT '获赞数',
collect_count bigint(10) default 0 not null COMMENT '收藏数',
by_collect_count bigint(10) default 0 not null COMMENT '被收藏数'
) COMMENT '用户互动信息表';

-- 用户商城信息表
create table If Not Exists `t_u_shop_info`(
user_id bigint(20) PRIMARY KEY not null unique COMMENT '用户id',
commodity_count bigint(10) default 0 not null COMMENT '发布的商品数',
collect_commodity_count bigint(10) default 0 not null COMMENT '收藏的商品数',
by_collect_commodity_count bigint(10) default 0 not null COMMENT '被收藏的商品数',
sell_count bigint(10) default 0 not null COMMENT '卖出的商品数量',
buy_count bigint(10) default 0 not null COMMENT '买进的商品数量'
) COMMENT '用户商城信息表';

-- 用户通知设置配置表
create table If Not Exists `t_u_inform_setting`(
user_id bigint(20) PRIMARY KEY not null unique COMMENT '用户id',
is_hot_content_push char(1) default '1' COMMENT '是否推送热门内容,0:否,1:是',
is_att_user_update_push char(1) default '1' COMMENT '是否推送关注的人更新的内容,0:否,1:是',
is_comment_inform char(1) default '1' COMMENT '评论是否通知,0:否,1:是',
is_good_inform char(1) default '1' COMMENT '点赞是否通知,0:否,1:是',
is_att_inform char(1) default '1' COMMENT '关注该用户是否通知,0:否,1:是',
is_at_inform char(1) default '1' COMMENT '@该用户是否通知,0:否,1:是',
is_chat_inform char(1) default '1' COMMENT '私信是否通知,0:否,1:是'
) COMMENT '用户通知设置配置表';

-- 登录信息模块,用于记录用户登录的设备或地理信息的相关信息
create table If Not Exists `t_u_login_info`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
account	varchar(20) default '' not null COMMENT '用户账号',
sys_name varchar(20) default '' COMMENT '系统名称'
) COMMENT '登录信息表';
-- -------------------------------- 用户模块 end--------------------------------

-- -------------------------------- 记录模块 start--------------------------------

-- 用户关注记录
create table If Not Exists `t_rec_attention`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '发起关注用户id',
by_user_id bigint(20) not null  COMMENT '被关注用户id',
time timestamp default now() not null COMMENT '发生时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '用户间关注表';

-- 用户点赞记录表
create table If Not Exists `t_rec_good`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '操作用户id',
by_user_id bigint(20) not null  COMMENT '被操作用户id',
res_id bigint(20) not null COMMENT '被操作资源id',
type int(10) default 0 not null COMMENT '被操作资源类型',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '用户点赞记录表';

-- 用户点踩记录表
create table If Not Exists `t_rec_diss`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '操作用户id',
by_user_id bigint(20) not null  COMMENT '被操作用户id',
res_id bigint(20) not null COMMENT '被操作资源id',
type int(10) default 0 not null COMMENT '被操作资源类型',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '用户点赞记录表';

-- 用户收藏记录表
create table If Not Exists `t_rec_coll`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '操作用户id',
by_user_id bigint(20) not null  COMMENT '被操作用户id',
res_id bigint(20) not null COMMENT '被操作资源id',
type int(10) default 0 not null COMMENT '被操作资源类型',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '用户点赞记录表';

-- 用户@记录表
create table If Not Exists `t_rec_at`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '发起@用户id',
by_user_id bigint(20) not null COMMENT '被@用户id',
src_id bigint(20) default 0 not null COMMENT '来源id',
src_type char(1) default '0' COMMENT '来源类型,由枚举决定',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '用户@记录表';

-- 加入话题记录表
create table If Not Exists `t_rec_join_gambit`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
gambit_id bigint(20) not null COMMENT '话题id',
src_id bigint(20) default 0 not null COMMENT '来源id',
src_type char(1) default '0' COMMENT '来源类型,由枚举决定',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是'
) COMMENT '用户@记录表';

-- 用户浏览内容记录表
create table If Not Exists `t_rec_look`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '用户id',
by_user_id bigint(20) not null  COMMENT '被操作用户id',
src_id bigint(20) default 0 not null COMMENT '来源id',
src_type char(1) default '0' COMMENT '来源类型,由枚举决定',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '用户浏览内容记录表';


-- 用户加入话题记录表
create table If Not Exists `t_rec_user_join_gambit`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
gambit_id bigint(20) not null COMMENT '话题id',
user_id bigint(20) not null COMMENT '用户id',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是'
) COMMENT '用户@记录表';

-- -------------------------------- 记录模块 end--------------------------------


-- -------------------------------- 内容模块 start--------------------------------
-- 内容表
create table If Not Exists `t_c_content`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) default 0 not null COMMENT '用户id',
body text not null COMMENT '内容正文',
create_time	timestamp default now() not null	COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是,1:否'
) COMMENT '内容表';

-- 评论表
create table If Not Exists `t_c_comment`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
content_id bigint(20) default 0 not null COMMENT '所属内容id',
content_type int(5) default 0 not null COMMENT '所属内容类型',
user_id bigint(20) default 0 not null COMMENT '用户id',
by_user_id bigint(20) default 0 not null COMMENT '被评论内容发送者用户id',
by_user_name varchar(20) not null COMMENT '被评论内容发送者用户名',
body text not null COMMENT '评论正文',
create_time	timestamp default now() not null	COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是,1:否',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '评论表';

-- 回复表
create table If Not Exists `t_c_reply`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
content_id bigint(20) default 0 not null COMMENT '所属内容id',
comment_id bigint(20) default 0 not null COMMENT '被回复评论id',
reply_id bigint(20) default 0 not null COMMENT '被回复回复id',
user_id bigint(20) default 0 not null COMMENT '用户id',
by_user_id bigint(20) default 0 not null COMMENT '被回复用户id',
by_user_name varchar(20) not null COMMENT '被回复用户名',
body text not null COMMENT '回复',
by_type char(1) default '0' COMMENT '回复类型,0:回复评论,1:回复回复',
create_time	timestamp default now() not null COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是,1:否',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '回复表';

-- 内容互动信息表
create table If Not Exists `t_c_interaction_info`(
content_id bigint(20) not null COMMENT '内容id',
content_type int(5) default 0 not null COMMENT '内容类型',
good_count bigint(10) default 0 not null COMMENT '点赞数',
diss_count bigint(10) default 0 not null COMMENT '点踩数',
comment_count bigint(10) default 0 not null COMMENT '评论数',
coll_count bigint(10) default 0 not null COMMENT '收藏数',
look_count bigint(10) default 0 not null COMMENT '内容查看数',
reply_count bigint(10) default 0 not null COMMENT '回复数'
) COMMENT '内容互动信息表';
-- -------------------------------- 内容模块 end--------------------------------


-- -------------------------------- 图片模块 start--------------------------------
-- 图片信息表
create table If Not Exists `t_img_info`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
src_id bigint(20) default 0 not null COMMENT '来源id',
src_type char(1) default '0' COMMENT '来源类型,由枚举决定',
file_size int(58) default 0 not null COMMENT '图片文件大小,单位:字节',
file_name varchar(128) default '' not null COMMENT '图片文件名称',
file_type varchar(128) default '' not null COMMENT '图片文件类型',
file_path varchar(558) default '' not null COMMENT '图片文件路径',
ip varchar(128) default '' not null COMMENT '图片文件所在服务器ip',
create_time	timestamp default now() not null	COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是,1:否'
) COMMENT '图片信息表';
-- -------------------------------- 图片模块 end--------------------------------


-- -------------------------------- 话题模块 start--------------------------------
-- 话题信息表
create table If Not Exists `t_g_gambit`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
name varchar(20) default '' not null COMMENT '内容标题',
head_pic_name varchar(20) default '' not null COMMENT '话题头像文件名',
content_count bigint(10) default 0 not null COMMENT '参与内容数字',
classify_id bigint(20) default 0 not null COMMENT '分类id',
create_time	timestamp default now() not null COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是'
) COMMENT '话题信息表';

-- 话题分类表
create table If Not Exists `t_g_classify`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
name varchar(20) default '' not null COMMENT '分类名称',
create_time	timestamp default now() not null COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是'
) COMMENT '话题分类表';

-- -------------------------------- 话题模块 end--------------------------------

-- -------------------------------- 地理信息模块 start--------------------------------
-- 地理信息表
create table If Not Exists `t_local_info`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
src_id bigint(20) default 0 not null COMMENT '来源id',
src_type char(1) default '0' COMMENT '来源类型,由枚举决定',
country_code varchar(20) default '' COMMENT '国家编码',
country varchar(20) default '' COMMENT '国家',
city varchar(20) default '' COMMENT '市',
provincial varchar(20) default '' COMMENT '省',
district varchar(20) default '' not null COMMENT '区',
street varchar(20) default '' not null COMMENT '街道',
longitude varchar(258) default '' not null COMMENT '经度',
latitude varchar(258) default '' not null COMMENT '纬度'
) COMMENT '地理信息表';
-- -------------------------------- 地理信息模块 end--------------------------------



-- -------------------------------- 全局管理模块 start--------------------------------
-- 黑名单表
create table If Not Exists `t_admin_black_list`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '用户id',
name varchar(20) default '' not null COMMENT '用户名',
create_time	timestamp default now() not null COMMENT '内容创建时间'
) COMMENT '公共黑名单';
-- -------------------------------- 全局管理模块 end--------------------------------


-- -------------------------------- 消息模块 start--------------------------------
-- 消息表
create table If Not Exists `t_mess_message`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '消息发送者用户id',
by_user_id bigint(20) not null COMMENT '需通知的用户id',
src_id bigint(20) default 0 not null COMMENT '消息来源id',
src_type char(1) default '0' COMMENT '消息类型,由枚举决定',
create_time	timestamp default now() not null COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '消息表';

-- 系统通知表
create table If Not Exists `t_mess_sys_inform`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '消息发送者用户id',
src_id bigint(20) default 0 not null COMMENT '消息来源id,一般是一个内容',
create_time	timestamp default now() not null COMMENT '内容创建时间',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是'
) COMMENT '系统通知表';
-- -------------------------------- 消息模块 end--------------------------------

-- -------------------------------- 即时通讯模块 start--------------------------------

-- -------------------------------- 即时通讯模块 end--------------------------------




-- -------------------------------- 商城模块 start--------------------------------
-- 商品信息表
create table If Not Exists `t_shop_commodity`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
commodity_src_id bigint(20) not null COMMENT '商品来源id,可以是用户或商家',
commodity_src_type char(1) default '0' COMMENT '商品来源类型,可以是用户或商家',
name varchar(20) default '' not null COMMENT '商品名称',
price double(10,3) default 0 not null COMMENT '商品价格',
price_unit varchar(10) default '' not null COMMENT '商品价格单位',
freight double(10,3) default 0 not null COMMENT '运费价格',
freight_unit varchar(10) default '' not null COMMENT '商品运费单位',
intro varchar(1588) default '' not null COMMENT '商品描述',
classify_id varchar(558) default '' not null COMMENT '商品分类id,可有多个,多个id用逗号隔开',
create_time	timestamp default now() not null COMMENT '商品创建时间',
update_time	timestamp default now() not null COMMENT '商品更新时间'
) COMMENT '商品信息表';

-- 商品图片信息表
create table If Not Exists `t_shop_img_info`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
commodity_id bigint(20) not null unique COMMENT '商品id',
file_size int(58) default 0 not null COMMENT '图片文件大小,单位:字节',
file_name varchar(128) default '' not null COMMENT '图片文件名称',
file_type varchar(128) default '' not null COMMENT '图片文件类型',
file_path varchar(558) default '' not null COMMENT '图片文件路径',
ip varchar(128) default '' not null COMMENT '图片文件所在服务器ip',
create_time	timestamp default now() not null COMMENT '内容创建时间',
update_time	timestamp default now() not null COMMENT '内容更新时间',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是。1:否'
) COMMENT '图片信息表';

-- 商品互动信息表
create table If Not Exists `t_shop_interaction_info`(
commodity_id bigint(20) not null unique COMMENT '商品id',
buy_count bigint(10) default 0 not null COMMENT '购买次数',
comment_count bigint(10) default 0 not null COMMENT '评论数',
coll_count bigint(10) default 0 not null COMMENT '收藏数',
look_count bigint(10) default 0 not null COMMENT '商品查看数',
join_shop_cart_count bigint(10) default 0 not null COMMENT '商品加入购物车次数'
) COMMENT '商品互动信息表';

-- 商品分类表
create table If Not Exists `t_shop_commodity_classify`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
name varchar(20) default '' not null COMMENT '分类名称',
parent_id bigint(20) not null COMMENT '父级分类id',
lvl int(10) default 0 not null COMMENT '分类等级:0:第一大类分类。1:第二中类分类。2:第三小类分类。',
create_time	timestamp default now() not null COMMENT '内容创建时间',
update_time	timestamp default now() not null COMMENT '内容更新时间'
) COMMENT '商品分类表';

-- 商品型号表,针对每个商品的特有的型号,需要用户自行编辑,例如衣物的尺寸
create table If Not Exists `t_shop_commodity_type`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
commodity_id bigint(20) not null COMMENT '商品id',
name varchar(20) default '' not null unique COMMENT '型号名称',
create_time	timestamp default now() not null COMMENT '内容创建时间'
) COMMENT '商品型号表,针对每个商品的特有的型号,需要用户自行编辑,例如衣物的尺寸';

-- 订单表
create table If Not Exists `t_shop_order`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '订单发起者用户id',
commodity_src_id bigint(20) not null COMMENT '商品来源id,可以是用户或商家',
commodity_src_type char(1) default '0' COMMENT '商品来源类型,可以是用户或商家',
commodity_id bigint(20) not null COMMENT '商品id',
physical_distribution_id bigint(20) not null unique COMMENT '物流信息id',
create_time	timestamp default now() not null COMMENT '订单创建时间',
update_time	timestamp default now() not null COMMENT '订单更新时间',
order_status char(1) default '0' COMMENT '订单状态,0:下单,待付款。1:已付款,未发货。2:商品运送中。3:已签收。4:交易完成。5:退换处理中。6:退换处理完成。7:订单正常结束。8:订单非正常结束,例如退换后的结束。',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是'
) COMMENT '订单表';

-- 订单物流信息表
create table If Not Exists `t_shop_order_physical_distribution`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
commodity_id bigint(20) not null unique COMMENT '商品id',
order_id bigint(20) not null unique COMMENT '订单id',
create_time	timestamp default now() not null COMMENT '订单创建时间',
update_time	timestamp default now() not null COMMENT '订单更新时间',
physical_distribution_status char(1) default '0' COMMENT '物流状态,0:待发货。1:运送中。2:已签收。',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是'
) COMMENT '订单物流信息表';

-- 购物车表
create table If Not Exists `t_shop_commodity_cart`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
commodity_id bigint(20) not null COMMENT '商品id',
commodity_src_id bigint(20) not null COMMENT '商品来源id,可以是用户或商家',
commodity_type char(1) default '0' COMMENT '商品来源类型,可以是用户或商家',
user_id bigint(20) not null COMMENT '购物车所属用户id',
commodity_count int(1) not null default 1 COMMENT '商品数量,最大99个',
create_time	timestamp default now() not null COMMENT '加入购物车时间',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是'
) COMMENT '购物车表';

-- 商品与内容关联表
create table If Not Exists `t_shop_content_rel`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '关联创建者用户id',
commodity_id bigint(20) not null COMMENT '商品id',
content_id bigint(20) not null COMMENT '内容id',
content_type bigint(20) default 0 not null COMMENT '内容类型,默认为内容类型',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是'
) COMMENT '商品与内容关联表';

-- -------------------------------- 商城模块 end--------------------------------

-- -------------------------------- im模块 start--------------------------------

-- 对话条目内容表
create table If Not Exists `t_im_chat_content`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
user_id bigint(20) not null COMMENT '发送者用户id',
by_user_id bigint(20) not null COMMENT '接受者用户id',
body text not null COMMENT '内容正文',
type char(1) default '0' COMMENT '私信类型,根据枚举',
time timestamp default now() not null COMMENT '操作时间',
is_del char(1) default '0' COMMENT '是否删除,0:否,1:是',
is_read char(1) default '0' COMMENT '是否已读,0:否,1:是'
) COMMENT '对话条目内容表';

-- 对话条目图片内容表
create table If Not Exists `t_im_chat_image`(
id bigint(20) PRIMARY KEY not null AUTO_INCREMENT COMMENT '主键',
chat_id bigint(20) not null unique COMMENT '对话id',
file_size int(58) default 0 not null COMMENT '图片文件大小,单位:字节',
file_name varchar(128) default '' not null COMMENT '图片文件名称',
file_type varchar(128) default '' not null COMMENT '图片文件类型',
file_path varchar(558) default '' not null COMMENT '图片文件路径',
ip varchar(128) default '' not null COMMENT '图片文件所在服务器ip',
create_time	timestamp default now() not null COMMENT '内容创建时间',
update_time	timestamp default now() not null COMMENT '内容更新时间',
is_del char(1) default '0' COMMENT '是否删除,0:否。1:是',
is_legal char(1) default '0' COMMENT '是否合法,0:是。1:否'
) COMMENT '对话条目图片内容表';

-- -------------------------------- im模块 end--------------------------------

