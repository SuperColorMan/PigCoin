package com.server_0.comm.filters;

import org.apache.commons.lang3.StringUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.*;

/**
 * @ClassName SubPageFilter
 * @Description 分页相关信息过滤器
 * @Author SuperColorMan
 * @Date 2020/6/5 11:38 上午
 * @ModifyDate 2020/6/5 11:38 上午
 * @Version 1.0
 */
public class OverAllFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        RequestParameterWrapper requestParameterWrapper = new RequestParameterWrapper(request);
        Map<String, Object> extraParams = new HashMap<String, Object>();
        //请求过滤
        //设置页号,从0开始
        String pageStr = servletRequest.getParameter("page");
        String pageSizeStr = servletRequest.getParameter("pageSize");
        String loginUserId = servletRequest.getParameter("loginUserId");
        //如果不存在登录用户
        if(StringUtils.isBlank(loginUserId)){
            loginUserId="0";
            extraParams.put("loginUserId", loginUserId);
        }
        if (pageStr != null) {
            long page = Long.parseLong(pageStr);
            long pageSize = Long.parseLong(pageSizeStr);
            if(page>0){
                page=page-1;
            }
            page = page  * pageSize;
            extraParams.put("page", page);
        }
        requestParameterWrapper.addParameters(extraParams);
        filterChain.doFilter(requestParameterWrapper, response);
    }

    @Override
    public void destroy() {
    }

    private class RequestParameterWrapper extends HttpServletRequestWrapper {

        private Map<String, String[]> params = new HashMap<String, String[]>();

        public RequestParameterWrapper(HttpServletRequest request) {
            super(request);
            //将现有parameter传递给params
            this.params.putAll(request.getParameterMap());
        }

        /**
         * 重载构造函数
         *
         * @param request
         * @param extraParams
         */
        public RequestParameterWrapper(HttpServletRequest request, Map<String, Object> extraParams) {
            this(request);
            addParameters(extraParams);
        }

        public void addParameters(Map<String, Object> extraParams) {
            for (Map.Entry<String, Object> entry : extraParams.entrySet()) {
                addParameter(entry.getKey(), entry.getValue());
            }
        }

        /* 重写父类方法
         * 自定义参数
         */
        @Override
        public Enumeration<String> getParameterNames() {

            Set set = params.keySet();

            if (set.size() > 0 & set != null) {

                return Collections.enumeration(set);
            } else {
                return super.getParameterNames();
            }
        }

        /**
         * 重写getParameter，代表参数从当前类中的map获取
         *
         * @param name
         * @return
         */
        @Override
        public String getParameter(String name) {
            String[] values = params.get(name);
            if (values == null || values.length == 0) {
                return null;
            }
            return values[0];
        }

        /**
         * 同上
         *
         * @param name
         * @return
         */
        @Override
        public String[] getParameterValues(String name) {
            return params.get(name);
        }

        /**
         * 添加参数
         *
         * @param name
         * @param value
         */
        public void addParameter(String name, Object value) {
            if (value != null) {
                if (value instanceof String[]) {
                    params.put(name, (String[]) value);
                } else if (value instanceof String) {
                    params.put(name, new String[]{(String) value});
                } else {
                    params.put(name, new String[]{String.valueOf(value)});
                }
            }
        }
    }

    /**
     * 返回值输出代理类
     *
     * @author kokJuis
     * @Title: ResponseWrapper
     * @Description:
     * @date 上午9:52:11
     */
    public class ResponseParameterWrapper extends HttpServletResponseWrapper {

        private ByteArrayOutputStream buffer;

        private ServletOutputStream out;

        public ResponseParameterWrapper(HttpServletResponse httpServletResponse) {
            super(httpServletResponse);
            buffer = new ByteArrayOutputStream();
            out = new WrapperOutputStream(buffer);
        }

        @Override
        public ServletOutputStream getOutputStream()
                throws IOException {
            return out;
        }

        @Override
        public void flushBuffer()
                throws IOException {
            if (out != null) {
                out.flush();
            }
        }

        public byte[] getContent()
                throws IOException {
            flushBuffer();
            return buffer.toByteArray();
        }

        class WrapperOutputStream extends ServletOutputStream {
            private ByteArrayOutputStream bos;

            public WrapperOutputStream(ByteArrayOutputStream bos) {
                this.bos = bos;
            }

            @Override
            public void write(int b)
                    throws IOException {
                bos.write(b);
            }

            @Override
            public boolean isReady() {

                // TODO Auto-generated method stub
                return false;

            }

            @Override
            public void setWriteListener(WriteListener arg0) {

                // TODO Auto-generated method stub

            }
        }

    }

}
