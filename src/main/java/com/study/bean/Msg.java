package com.study.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * 一个更通用的类，保存传输的json数据，以及状态码和提示信息
 * 后面只需要返回给客户端Msg就行了
 */
public class Msg {
    //状态码 100成功 200失败
    private int code;
    //提示信息
    private String msg;
    //用户返回给浏览器的数据
    private Map<String,Object> extend=new HashMap<>();

    //static更方便，后面直接Msg.success就能获取到一个Msg了
    public static Msg success(){
        Msg res=new Msg();
        res.setCode(100);
        res.setMsg("处理成功");
        return res;
    }
    public static Msg fail(){
        Msg res=new Msg();
        res.setCode(200);
        res.setMsg("处理失败");
        return res;
    }
    //返回Msg方便链式操作，add().add().add()
    public Msg add(String key,Object value){
        this.getExtend().put(key, value);
        return this;
    }
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
