package com.server_0.utils.thread;

import java.util.concurrent.*;

/**
 * @ClassName ThreadPoolUtils
 * @Description 线程池工具类
 * @Author SuperColorMan
 * @Date 2020/7/31 5:30 下午
 * @ModifyDate 2020/7/31 5:30 下午
 * @Version 1.0
 */
public class ThreadPoolUtils {
    /**
     * -----------------------
     * 核心线程数
     * -----------------------
     */
    private static final int corePool = Runtime.getRuntime().availableProcessors();
    /**
     * -----------------------
     * 最大线程数
     * -----------------------
     */
    private static final int maxThread = Integer.MAX_VALUE;
    /**
     * -----------------------
     * 阻塞队列大小
     * -----------------------
     */
    private static final int queueSize = Integer.MAX_VALUE;
    /**
     * -----------------------
     * 线程池
     * -----------------------
     */
    private static final ExecutorService threadPool = new ThreadPoolExecutor(
            corePool,
            maxThread,
            1L,
            TimeUnit.SECONDS,
            new LinkedBlockingQueue<>(queueSize),
            Executors.defaultThreadFactory(),
            new ThreadPoolExecutor.CallerRunsPolicy());

    /**
     * -----------------------
     * 线程池任务执行
     * -----------------------
     *
     * @param run 线程池任务接口
     */
    public static void exe(Runnable run) {
        threadPool.execute(run);
    }

    /**
     * -----------------------
     * 线程池任务执行
     * -----------------------
     *
     * @param run 线程池任务接口
     */
    public static Future<?> retExe(Runnable run) {
        return threadPool.submit(run);
    }
}
