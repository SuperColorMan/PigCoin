package com.server_0.comm.enums;

/**
 * @ClassName OrderStateEnum
 * @Description 订单状态枚举
 * @Author SuperColorMan
 * @Date 2021/2/25 2:07 下午
 * @ModifyDate 2021/2/25 2:07 下午
 * @Version 1.0
 */
public enum OrderStateEnum {
    PAO(0, "下单,待付款"),
    AP(1, "已付款,未发货"),
    ISTRAN(2, "商品运送中"),
    ISSIGNFOR(3, "已签收"),
    DEALFINISH(4, "交易完成"),
    EAPHANDLE(5, "退换处理中"),
    EAPFINISH(6, "退换处理完成"),
    ORDERNORMALFINISH(7, "订单正常结束"),
    ORDERNOTNORMALFINISH(8, "订单非正常结束,例如退换后的结束");
    private int type;
    private String des;

    OrderStateEnum(int type, String des) {
        this.type = type;
        this.des = des;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
}
