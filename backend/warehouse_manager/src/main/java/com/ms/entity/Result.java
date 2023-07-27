package com.ms.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 响应结果封装类:
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Result {

    /**
     * 状态码常量:
     */
    //成功
    public static final int CODE_OK = 200;
    //业务错误
    public static final int CODE_ERR_BUSINESS = 501;
    //用户未登录
    public static final int CODE_ERR_UNLOGINED = 502;
    //系统错误
    public static final int CODE_ERR_SYS = 503;

    //成员属性
    private int code;//状态码

    private boolean success;//成功响应为true,失败响应为false

    private String message;//响应信息

    private Object data;//响应数据

    //成功响应的方法 -- 返回的Result中只封装了成功状态码
    public static Result ok(){
        return new Result(CODE_OK,true,null, null);
    }
    //成功响应的方法 -- 返回的Result中封装了成功状态码和响应信息
    public static Result ok(String message){
        return new Result(CODE_OK,true,message, null);
    }
    //成功响应的方法 -- 返回的Result中封装了成功状态码和响应数据
    public static Result ok(Object data){
        return new Result(CODE_OK,true,null, data);
    }
    //成功响应的方法 -- 返回的Result中封装了成功状态码和响应信息和响应数据
    public static Result ok(String message, Object data){
        return new Result(CODE_OK,true,message, data);
    }
    //失败响应的方法 -- 返回的Result中封装了失败状态码和响应信息
    public static Result err(int errCode, String message){
        return new Result(errCode,false, message, null);
    }
    //失败响应的方法 -- 返回的Result中封装了失败状态码和响应信息和响应数据
    public static Result err(int errCode,String message,Object data){
        return new Result(errCode,false,message, data);
    }
}
