package com.atguigu.scw.portal.test;

import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.junit.Test;

import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.portal.bean.ScwReturn;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;


public class HttpClientTest {
    
    
    @Test
    public void test01() throws Exception{
        
        
        //1、请求参数带在？后面
        //HttpGet get = new HttpGet("http://localhost:8082/scw-restapi/hello");
        
        //2、传入uri；构造请求地址和参数的形式
        URI uri = new URIBuilder()
            .setScheme("http")
            .setHost("localhost:8082")
            .setPath("/scw-restapi/member/regist")
            .setParameter("loginacct", "dsadhsakjdha")
            .setParameter("userpswd", "dsaj121")
            .setParameter("email", "aaa@qq.com")
            .build();
            
        //1】、创建一个Get或者其他请求
        HttpGet get = new HttpGet(uri);
        //2】、创建出一个发送请求的对象
        CloseableHttpClient client = HttpClients.createDefault();
        //3】、发送请求  HttpUriRequest，得到响应
        CloseableHttpResponse response = client.execute(get);
        //4】、查看响应对象（包含响应头、响应体等所有内容）
        HttpEntity entity = response.getEntity();
        //获取响应头： response.getAllHeaders();
        //响应内容：
        InputStream content = entity.getContent();
        //String string = IOUtils.toString(content, "utf-8");
        String string2 = EntityUtils.toString(entity,"utf-8");
       // System.out.println("io打印："+string);
        System.out.println("EntityUtils：打印："+string2);
       
        
        //根据json字符串，逆向出他之前的对象
        /**
         * jackson和gson和fastjson等工具都行；
         * 
         * jackson：怎么转；
         * 
         * {"code":0,"msg":"用户注册失败!",
         *  "content":null,
         *  "ext":{"error":"触犯唯一约束，请保证用户名和邮箱唯一"}}
         */
        /**
         * 1、jackson将对象转json字符串
         * 2、将json字符串转对象；
         * 复杂类型，new TypeReference<ScwReturn<TMemeber>>() { }
         */
        
        //2、将json字符串转对象;ScwReturn<T>
        ObjectMapper objectMapper = new ObjectMapper();
        //src：json字符串   valueType：复杂类型
        ScwReturn<TMemeber> readValue = 
                objectMapper.readValue(string2.getBytes(), 
                new TypeReference<ScwReturn<TMemeber>>() { });
        System.out.println(readValue.getCode());
        System.out.println(readValue.getMsg());
        System.out.println(readValue.getContent());
        System.out.println(readValue.getExt());
        
        
        //1、jackson将对象转json字符串
        String string = objectMapper.writeValueAsString(readValue);
        System.out.println("转为json："+string);
        //释放资源
        response.close();
        client.close();
        
        
        
    }

}
