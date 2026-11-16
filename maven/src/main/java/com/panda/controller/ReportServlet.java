package com.panda.controller;

import com.panda.dao.CiDetailedReportDAO;
import com.panda.dao.CiReportDAO;
import com.panda.dao.OrdersDAO;
import com.panda.dao.OverallResultDAO;
import com.panda.dao.impl.CiDetailedReportDAOImpl;
import com.panda.dao.impl.CiReportDAOImpl;
import com.panda.dao.impl.OrdersDAOImpl;
import com.panda.dao.impl.OverallResultDAOImpl;
import com.panda.entity.CiDetailedReport;
import com.panda.entity.CiReport;
import com.panda.entity.OverallResult;
import com.panda.utils.JsonUtil;
import com.panda.utils.ReportGenerator;
import com.panda.utils.ResultVO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

//体检报告接口
@WebServlet("/report/*")
public class ReportServlet extends HttpServlet {

    private final OrdersDAO ordersDAO = new OrdersDAOImpl();
    private final CiReportDAO ciReportDAO = new CiReportDAOImpl();
    private final CiDetailedReportDAO ciDetailedReportDAO = new CiDetailedReportDAOImpl();
    private final OverallResultDAO overallResultDAO = new OverallResultDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path != null && path.startsWith("/list/")) {
                String userId = JsonUtil.lastSegment(path);
                JsonUtil.write(resp, ResultVO.success("查询成功", ordersDAO.findByUserId(userId)));
                return;
            }
            if (path != null && path.startsWith("/detail/")) {
                Integer orderId = JsonUtil.pathId(path);
                if (orderId == null) {
                    JsonUtil.write(resp, ResultVO.fail("订单编号错误"));
                    return;
                }
                JsonUtil.write(resp, ResultVO.success("查询成功", buildDetail(orderId)));
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的报告接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("查询失败：" + e.getMessage()));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String path = req.getPathInfo();
            if (path == null) {
                JsonUtil.write(resp, ResultVO.fail("未知的报告接口"));
                return;
            }
            if (path.equals("/saveGroup")) {
                saveGroup(req, resp);
                return;
            }
            if (path.equals("/addResult")) {
                Map<String, Object> body = JsonUtil.readMap(req);
                OverallResult result = new OverallResult();
                result.setOrderId(JsonUtil.getInt(body, "orderId"));
                result.setTitle(JsonUtil.getStr(body, "title"));
                result.setContent(JsonUtil.getStr(body, "content"));
                int orId = overallResultDAO.add(result);
                result.setOrId(orId);
                JsonUtil.write(resp, ResultVO.success("已添加", result));
                return;
            }
            if (path.equals("/updateResult")) {
                Map<String, Object> body = JsonUtil.readMap(req);
                Integer orId = JsonUtil.getInt(body, "orId");
                boolean ok = orId != null && overallResultDAO.update(
                        orId, JsonUtil.getStr(body, "title"), JsonUtil.getStr(body, "content"));
                JsonUtil.write(resp, ok ? ResultVO.success("已更新") : ResultVO.fail("更新失败"));
                return;
            }
            if (path.startsWith("/deleteResult/")) {
                Integer orId = JsonUtil.pathId(path);
                boolean ok = orId != null && overallResultDAO.deleteById(orId);
                JsonUtil.write(resp, ok ? ResultVO.success("已删除") : ResultVO.fail("删除失败"));
                return;
            }
            JsonUtil.write(resp, ResultVO.fail("未知的报告接口"));
        } catch (Exception e) {
            JsonUtil.write(resp, ResultVO.fail("操作失败：" + e.getMessage()));
        }
    }

    private Map<String, Object> buildDetail(int orderId) throws Exception {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("order", ordersDAO.findById(orderId));

        List<Map<String, Object>> groups = new ArrayList<>();
        for (CiReport report : ciReportDAO.findByOrderId(orderId)) {
            Map<String, Object> group = new LinkedHashMap<>();
            group.put("cirId", report.getCirId());
            group.put("ciId", report.getCiId());
            group.put("ciName", report.getCiName());
            group.put("orderId", report.getOrderId());
            group.put("items", ciDetailedReportDAO.findByCirId(report.getCirId()));
            groups.add(group);
        }
        data.put("groups", groups);
        data.put("conclusions", overallResultDAO.findByOrderId(orderId));
        return data;
    }

    @SuppressWarnings("unchecked")
    private void saveGroup(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Map<String, Object> body = JsonUtil.readMap(req);
        Object itemsObj = body.get("items");
        if (!(itemsObj instanceof List)) {
            JsonUtil.write(resp, ResultVO.fail("报告数据格式错误"));
            return;
        }
        for (Object obj : (List<Object>) itemsObj) {
            if (!(obj instanceof Map)) {
                continue;
            }
            Map<String, Object> item = (Map<String, Object>) obj;
            Integer cidrId = JsonUtil.getInt(item, "cidrId");
            if (cidrId == null) {
                continue;
            }
            String value = JsonUtil.getStr(item, "value");
            Integer type = JsonUtil.getInt(item, "type");
            Double minrange = JsonUtil.getDouble(item, "minrange");
            Double maxrange = JsonUtil.getDouble(item, "maxrange");
            String normalValue = JsonUtil.getStr(item, "normalValue");
            int isError = ReportGenerator.calcError(type, value, minrange, maxrange, normalValue);
            item.put("isError", isError);
            ciDetailedReportDAO.updateValue(cidrId, value, isError);
        }
        JsonUtil.write(resp, ResultVO.success("已保存"));
    }
}
