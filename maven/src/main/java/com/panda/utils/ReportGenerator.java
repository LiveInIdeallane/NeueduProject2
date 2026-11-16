package com.panda.utils;

import com.panda.dao.CiDetailedReportDAO;
import com.panda.dao.CiReportDAO;
import com.panda.dao.CheckitemDetailedDAO;
import com.panda.dao.SetmealDetailedDAO;
import com.panda.dao.impl.CiDetailedReportDAOImpl;
import com.panda.dao.impl.CiReportDAOImpl;
import com.panda.dao.impl.CheckitemDetailDAOImpl;
import com.panda.dao.impl.SetmealDetailDAOImpl;
import com.panda.entity.Checkitem;
import com.panda.entity.CheckitemDetailed;
import com.panda.entity.CiDetailedReport;
import com.panda.entity.CiReport;

//根据套餐的检查项，为新订单生成空的体检报告结构（医生后续填写结果）
public final class ReportGenerator {

    private ReportGenerator() {
    }

    public static void generate(int orderId, int smId) throws Exception {
        SetmealDetailedDAO setmealDetailedDAO = new SetmealDetailDAOImpl();
        CiReportDAO ciReportDAO = new CiReportDAOImpl();
        CheckitemDetailedDAO checkitemDetailedDAO = new CheckitemDetailDAOImpl();
        CiDetailedReportDAO ciDetailedReportDAO = new CiDetailedReportDAOImpl();

        for (Checkitem checkitem : setmealDetailedDAO.findCheckitemsBySmId(smId)) {
            CiReport ciReport = new CiReport(null, checkitem.getCiId(), checkitem.getCiName(), orderId);
            int cirId = ciReportDAO.create(ciReport);

            for (CheckitemDetailed detailed : checkitemDetailedDAO.findByCiId(checkitem.getCiId())) {
                CiDetailedReport item = new CiDetailedReport();
                item.setName(detailed.getName());
                item.setUnit(detailed.getUnit());
                item.setMinrange(detailed.getMinrange());
                item.setMaxrange(detailed.getMaxrange());
                item.setNormalValue(detailed.getNormalValue());
                item.setNormalValueString(detailed.getNormalValueString());
                item.setType(detailed.getType());
                item.setValue(null);
                item.setIsError(0);
                item.setCiId(cirId);
                item.setOrderId(orderId);
                ciDetailedReportDAO.create(item);
            }
        }
    }

    //根据检查项类型判断填写值是否异常
    public static int calcError(Integer type, String value, Double minrange, Double maxrange, String normalValue) {
        if (value == null || value.trim().isEmpty() || type == null) {
            return 0;
        }
        String v = value.trim();
        try {
            if (type == 1) {
                double number = Double.parseDouble(v);
                if ((minrange != null && number < minrange) || (maxrange != null && number > maxrange)) {
                    return 1;
                }
            } else if (type == 2) {
                if (normalValue != null && !normalValue.trim().equals(v)) {
                    return 1;
                }
            }
        } catch (NumberFormatException ignored) {
            //非数字输入按无异常处理
        }
        return 0;
    }
}
