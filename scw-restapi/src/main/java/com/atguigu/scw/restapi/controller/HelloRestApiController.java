package com.atguigu.scw.restapi.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;


/**
 *  @RestController == Controller+ResponseBody
 * @ClassName HelloRestApiController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月12日 下午5:14:37
 * @version 1.0.0
 */


@RestController
public class HelloRestApiController {
   
    @RequestMapping("/hello")
    public void hello(HttpServletResponse response) throws IOException{
        String json = "{user:1,name:2}";
        response.getWriter().write("abc("+json+")");
    }
    
//    @RequestMapping("/hello")
//    public Map<String, Object> hello(String u,String p){
//        Map<String, Object> map = new HashMap<String, Object>();
//        map.put("username", "张三");
//        System.out.println(u+"==>"+p);
//        return map;
//    }
    
    @RequestMapping("/hello2")
    public List<Object> hello02(){
       List<Object> list = new ArrayList<Object>();
       list.add("张三");
       list.add(true);
       // var b = ["zhangsan","lisi"]  b[0] 
       return list;
    }
}
