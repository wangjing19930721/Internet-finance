package com.atguigu.scw.restapi.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.restapi.bean.ScwReturn;
import com.atguigu.scw.restapi.service.MemberService;

/**
 * 负责产生所有业务数据
 * 
 * @ClassName MemberController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月15日 下午3:55:22
 * @version 1.0.0
 */
@RestController
@RequestMapping("/member")
public class MemberController {

    @Autowired
    MemberService memberService;

    
 
    /**
     * 用户登陆请求； 1、有一个要求，登陆成功以后，把数据库对应的这个用户的详细信息返回出来； 2、好处； 1）、移动端：放进自己的保存数据的地方，保存并显示 2）、web端：json逆向为对象。拿到用户对象，放进session中；
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/login")
    public ScwReturn<TMemeber> login(TMemeber memeber) {
        TMemeber loginUser = null;
        try {
            loginUser = memberService.login(memeber);
            if (loginUser != null){
                return ScwReturn.success("登陆成功！", loginUser, null);
            }else{
                return ScwReturn.fail("用户名密码错误！", loginUser, null);
            }
        } catch (Exception e) {
            return ScwReturn.fail("登陆失败！", null, null);
        }
    }

    /**
     * ScwReturn<List<TMemeber>>:泛型是content内容的对象的类型
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param memeber
     * @return
     */
    @RequestMapping("/regist")
    public ScwReturn<TMemeber> regist(TMemeber memeber) {

        // 创建一个空的对象
        TMemeber regist = new TMemeber();
        Map<String, Object> hashMap = new HashMap<>();
        try {
            regist = memberService.regist(memeber);
        } catch (Exception e) {
            // 判断异常类型来放错误
            // e.printStackTrace();
            hashMap.put("error", "触犯唯一约束，请保证用户名和邮箱唯一");
        }
        regist.setUserpswd("");
        if (regist.getId() != null) {
            return ScwReturn.success("用户注册成功！", regist, null);
        } else {
            return ScwReturn.fail("用户注册失败!", null, hashMap);
        }
    }

}
