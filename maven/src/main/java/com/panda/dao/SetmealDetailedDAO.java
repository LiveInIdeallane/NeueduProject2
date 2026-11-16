package com.panda.dao;

import com.panda.entity.Checkitem;
import com.panda.entity.SetmealDetailed;

import java.util.List;

public interface SetmealDetailedDAO {
    List<SetmealDetailed> findAllDetailed() throws Exception;

    //查询某套餐包含的检查项
    List<Checkitem> findCheckitemsBySmId(int smId) throws Exception;
}
