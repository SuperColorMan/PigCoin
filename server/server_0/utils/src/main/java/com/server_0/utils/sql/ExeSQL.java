package com.server_0.utils.sql;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.springframework.core.io.ClassPathResource;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName ExeSQL
 * @Description SQL文件执行器
 * @Author SuperColorMan
 * @Date 2020/5/25 4:25 下午
 * @ModifyDate 2020/5/25 4:25 下午
 * @Version 1.0
 */
public class ExeSQL {
    /**
     * -----------------------
     * SQL文件对象列表
     * -----------------------
     */
    private final List<File> fList = new ArrayList<>();

    /**
     * -----------------------
     * 递归SQL文件
     * -----------------------
     *
     * @param file SQL文件对象
     */
    public void getFiles(File file) {
        if (file.isDirectory()) {
            //目录
            File[] fArr = file.listFiles();
            for (File f : fArr) {
                getFiles(f);
            }
        } else {
            //文件
            fList.add(file);
        }
    }

    /**
     * -----------------------
     * 执行SQL文件
     * -----------------------
     *
     * @param conn DB连接对象
     */
    public void exeSql(Connection conn) throws FileNotFoundException, SQLException {
        ScriptRunner scriptRunner = new ScriptRunner(conn);
        Resources.setCharset(Charset.forName("UTF8"));
        ClassPathResource resource = new ClassPathResource("");
        for (File file : fList) {
            scriptRunner.runScript(new FileReader(file));
        }
        scriptRunner.closeConnection();
        conn.close();
    }

    /**
     * -----------------------
     * 执行SQL文件
     * -----------------------
     *
     * @param conn DB连接对象
     * @param f    指定的sql文件
     */
    public void exeSql(Connection conn, File f) throws FileNotFoundException, SQLException {
        ScriptRunner scriptRunner = new ScriptRunner(conn);
        //设置语句分隔符
        scriptRunner.setDelimiter(";");
        Resources.setCharset(Charset.forName("UTF8"));
        ClassPathResource resource = new ClassPathResource("");
        scriptRunner.runScript(new FileReader(f));
        scriptRunner.closeConnection();
        conn.close();
    }
}
