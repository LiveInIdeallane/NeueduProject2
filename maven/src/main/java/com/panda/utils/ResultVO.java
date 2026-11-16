package com.panda.utils;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultVO {

    private Integer code;
    private String message;
    private Object data;

    //查询数据的成功方法
    public static ResultVO success(String message,Object data){
        return new ResultVO(200,message,data);
    }

    //增删改的成功方法
    public static ResultVO success(String message){
        return new ResultVO(200,message,null);
    }

    //失败方法
    public static ResultVO fail(String message){
        return new ResultVO(500,message,null);
    }
}
