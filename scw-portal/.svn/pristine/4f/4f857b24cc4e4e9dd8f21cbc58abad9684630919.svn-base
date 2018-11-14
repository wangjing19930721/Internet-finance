package com.atguigu.scw.portal.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.stat.TableStat.Mode;
import com.atguigu.project.HttpClientUtil;
import com.atguigu.project.MyStringUtils;
import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.manager.constant.Constants;
import com.atguigu.scw.portal.bean.ScwReturn;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 实名认证的控制器
 * 
 * @ClassName AuthController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月18日 上午9:21:14
 * @version 1.0.0
 */
@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private RestApiServerInfo info;
    
    

    private final String AUTH_INFO = "auth_info";

    /**
     * 申请完成
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param code
     * @return
     * @throws UnsupportedEncodingException 
     */
    @RequestMapping("/success.html")
    public String authSucces(String code,HttpSession session,Model model) throws Exception {
        //收到验证码发给api层
        Map<String, Object> map = new HashMap<>();
        TMemeber memeber = (TMemeber) session.getAttribute(Constants.LOGIN_USER);
        map.put("code", code);
        map.put("mid", memeber.getId());
        //发送请求
        String response = HttpClientUtil.httpPostRequest(info.getRestApiURL()+"/auth/vacode", map);
        //转换响应内容
        ScwReturn<Object> readValue = new ObjectMapper().readValue(response.getBytes(), new TypeReference<ScwReturn<Object>>() {
        });
        if(readValue.getCode()==1){
            model.addAttribute("msg", readValue.getMsg());
            return "member/success";
        }else{
            //来到继续输入验证码页面
            model.addAttribute("msg", readValue.getMsg());
            return "member/apply-3";
        }
    }

    @RequestMapping("/apply-3.html")
    public String toApply3(@RequestParam(value="email")String email,HttpSession session,Model model) throws Exception {
        System.out.println("邮箱信息："+email);
        //1、检查邮箱是否存在；给api层发送校验
        Map<String, Object> map = new HashMap<>();
        //当前登录的用户id
        TMemeber memeber = (TMemeber) session.getAttribute(Constants.LOGIN_USER);
        map.put("id", memeber.getId());
        map.put("email", email);
        map.put("username", memeber.getUsername());
        String response = HttpClientUtil.httpPostRequest(info.getRestApiURL()+"/auth/sendEmail", map);
        
        ScwReturn<Object> result = new ObjectMapper().readValue(response.getBytes(), new TypeReference<ScwReturn<Object>>() {
        });
        if(result.getCode() == 0){
            //发送邮件失败
            model.addAttribute("msg",result.getMsg());
            return "member/apply-2";
        }else{
            return "member/apply-3";
        }
        
       
    }

    /**
     * 来到填写邮箱页面；
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/apply-2.html")
    public String toApply2() {
        return "member/apply-2";
    }

    /**
     * 来到选择资质页面，同时也是完成了基本信息的录入
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     * @throws Exception
     * @throws JsonMappingException
     * @throws JsonParseException
     */
    @RequestMapping("/apply-1.html")
    public String toApply1(TMemeber memeber, HttpSession session,Model model) throws Exception {

        // 从session中拿到的对象是一个引用，一改全改
        TMemeber auth = (TMemeber) session.getAttribute(AUTH_INFO);
        if (auth != null && !MyStringUtils.isEmpty(memeber.getRealname())
                && !MyStringUtils.isEmpty(memeber.getCardnum())) {

            auth.setCardnum(memeber.getCardnum());
            auth.setRealname(memeber.getRealname());

            System.out.println("友收集到的数据：" + memeber.getCardnum() + "-->" + memeber.getRealname());

            // 2、收集到基本数据信息，先发给api层，让其先保存
            Map<String, Object> map = new HashMap<String, Object>();
            try {
                // 将javaBean中的属性和值，按照key=value放进map
                // BeanUtils.populate(auth, map);
                map.put("id", auth.getId());
                map.put("accttype", auth.getAccttype());
                map.put("realname", auth.getRealname());
                map.put("cardnum", auth.getCardnum());
                System.out.println("bean数据对应的map：" + map);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // 提交这些数据；发给api层；可能得到的string是错误页面而不是一个json字符串
            // 先保存基本信息
            String string = HttpClientUtil.httpPostRequest(info.getRestApiURL() + "/auth/baseinfo", map);

            ScwReturn<Object> readValue = new ObjectMapper().readValue(string.getBytes(),
                    new TypeReference<ScwReturn<Object>>() {
                    });
            if (readValue.getCode() == 1) {
                // 保存基本信息成功了，来到下一步
                // 查出用户当前要用的账户类型的所有资质
                String accttype = auth.getAccttype();
                Map<String, Object> param1 = new HashMap<>();
                param1.put("accttype", accttype);
                // 查出需要的所有资质
                String res = HttpClientUtil.httpPostRequest(info.getRestApiURL() + "/auth/certs", param1);
                ScwReturn<List<TCert>> certs = new ObjectMapper().readValue(res.getBytes(), new TypeReference<ScwReturn<List<TCert>>>() {});
                
                model.addAttribute("certs", certs.getContent());
                
                return "member/apply-1";
            } else {
                // 保存失败，重新路径
                return "member/apply";
            }
        } else {
            // 返回基本信息收集页面，没有收集到相应数据
            return "member/apply";
        }
    }

    /**
     * 来到输入基本信息页面
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/apply.html")
    public String toApply() {

        // 这个页面很简单
        return "member/apply";
    }

    /**
     * 来到认证申请的主页面
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/authpage.html")
    public String toAuthPage(TMemeber memeber, HttpSession session) {

        // 只要放行过来的就绝对是登陆了的；
        TMemeber login = (TMemeber) session.getAttribute(Constants.LOGIN_USER);

        System.out.println("用户id：" + login.getId());
        memeber.setId(login.getId());
        System.out.println("账户类型信息：" + memeber.getAccttype());
        // 收集数据信息放在session中
        session.setAttribute(AUTH_INFO, memeber);
        return "member/authpage";
    }

    /**
     * @Description (完成账户类型选择，来到输入基本信息页面)
     * @return
     */
    // @RequestMapping("/checktype.html")
    // public String finishCheckAccountType(){
    // return "redirect:/auth/apply.html";
    // }

}
