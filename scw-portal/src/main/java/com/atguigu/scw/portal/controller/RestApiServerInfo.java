package com.atguigu.scw.portal.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

@Controller
public class RestApiServerInfo {
    
 // MemberService memberService;
    @Value("${restapi.server.ip}")
    private String restapiserver;

    @Value("${restapi.server.port}")
    private String restapiport;

    @Value("${restapi.server.apppath}")
    private String appPath;

    public String getRestApiURL() {
        System.out.println("http://" + restapiserver + ":" + restapiport);
        return "http://" + restapiserver + ":" + restapiport + "/" + appPath;
    }

}
