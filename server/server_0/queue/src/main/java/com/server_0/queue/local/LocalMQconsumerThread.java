package com.server_0.queue.local;

import com.server_0.comm.callback.QueueCallBack;
import com.server_0.comm.global.GlobalConstant;
import lombok.SneakyThrows;

/**
 * @ClassName LocalMQconsumerThred
 * @Description 本地队列消费线程
 * @Author SuperColorMan
 * @Date 2021/1/4 2:21 下午
 * @ModifyDate 2021/1/4 2:21 下午
 * @Version 1.0
 */
public class LocalMQconsumerThread implements Runnable {

    /**
     * 本地队列消费者线程
     */
    public static void start() {
        new Thread(new LocalMQconsumerThread()).start();
    }

    /**
     * 新增队列项
     */
    public static void addQueueItem(QueueCallBack callBack) {
        GlobalConstant.LOCAL_MQ.add(callBack);
        synchronized (GlobalConstant.LOCAL_MQ) {
            GlobalConstant.LOCAL_MQ.notifyAll();
        }
    }

    @SneakyThrows
    @Override
    public void run() {
        while (true) {
            synchronized (GlobalConstant.LOCAL_MQ) {
                if (GlobalConstant.LOCAL_MQ.size() == 0) {
                    // 休眠
                    GlobalConstant.LOCAL_MQ.wait();
                } else {
                    // 消费
                    QueueCallBack callBack = GlobalConstant.LOCAL_MQ.poll();
                    // 消费处理
                    LocalMQconsumerHandle.handle(callBack);
                }
            }
        }
    }
}
