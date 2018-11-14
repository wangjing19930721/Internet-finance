package com.atguigu.scw.manager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.scw.manager.service.UserService;

@Controller
public class HelloController {

    @Autowired
    UserService userService;

    @RequestMapping("/hello")
    public String hello(@RequestParam(value = "id", defaultValue = "1")
    Integer id,Model model) {
        return "forward:/success.jsp";
    }

}
