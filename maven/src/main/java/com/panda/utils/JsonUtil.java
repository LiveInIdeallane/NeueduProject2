package com.panda.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

//统一处理请求体读取与响应写出（JSON + 日期格式）
public final class JsonUtil {

    public static final ObjectMapper MAPPER = new ObjectMapper().registerModule(new JavaTimeModule()).disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    private JsonUtil() {
    }

    public static <T> T read(HttpServletRequest req, Class<T> clazz) throws IOException {
        req.setCharacterEncoding("UTF-8");
        return MAPPER.readValue(req.getInputStream(), clazz);
    }

    @SuppressWarnings("unchecked")
    public static Map<String, Object> readMap(HttpServletRequest req) throws IOException {
        req.setCharacterEncoding("UTF-8");
        return MAPPER.readValue(req.getInputStream(), Map.class);
    }

    public static void write(HttpServletResponse resp, Object data) throws IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        MAPPER.writeValue(resp.getWriter(), data);
    }

    public static String getStr(Map<String, Object> map, String key) {
        Object v = map.get(key);
        return v == null ? null : v.toString();
    }

    public static Integer getInt(Map<String, Object> map, String key) {
        Object v = map.get(key);
        if (v == null || "".equals(v.toString())) {
            return null;
        }
        if (v instanceof Number) {
            return ((Number) v).intValue();
        }
        return Integer.valueOf(v.toString());
    }

    public static Double getDouble(Map<String, Object> map, String key) {
        Object v = map.get(key);
        if (v == null || "".equals(v.toString())) {
            return null;
        }
        if (v instanceof Number) {
            return ((Number) v).doubleValue();
        }
        return Double.valueOf(v.toString());
    }

    public static String lastSegment(String path) {
        if (path == null) {
            return "";
        }
        int index = path.lastIndexOf('/');
        return index >= 0 ? path.substring(index + 1) : path;
    }

    public static Integer pathId(String path) {
        try {
            return Integer.valueOf(lastSegment(path));
        } catch (Exception e) {
            return null;
        }
    }
}
