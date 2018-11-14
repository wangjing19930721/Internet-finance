package com.atguigu.scw.manager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.scw.manager.bean.TPermission;
import com.atguigu.scw.manager.constant.Constants;
import com.atguigu.scw.manager.service.TPermissionService;
import com.atguigu.scw.manager.service.UserService;
import com.sun.tools.internal.jxc.ap.Const;

/**
 * 页面调度中心
 * 
 * @ClassName DispatcherController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月7日 上午9:22:14
 * @version 1.0.0
 */
@Controller
public class DispatcherController {

    @Autowired
    TPermissionService ps;
    @Autowired
    UserService userService;

    @RequestMapping("/updatepwd")
    public String updatepwd(Model model, @RequestParam("password") String passwd, @RequestParam("token") String token) {
        System.out.println("新的密码：" + passwd);
        System.out.println("令牌：" + token);
        // 1、先按照令牌去找到用户
        boolean b = userService.updatePasswordByToken(token, passwd);
        if (b) {
            model.addAttribute("msg", "密码重置成功！请重新登陆");
        }else{
            model.addAttribute("msg", "密码重置连接失效了，请重新操作");
        }
        //令牌一但使用后，就直接移除，把令牌设空；
        
        // 返回成功页面
        return "success";
    }

    @RequestMapping("/getpwd")
    public String resetpassword() {

        // 来到输入密码的页面
        return "resetpassword";
    }

    @RequestMapping("/sendemail")
    public String forgetPassword(@RequestParam("email") String email, Model model) {
        // 收到邮箱地址，给邮箱发送重置连接
        System.out.println("提交的邮箱：" + email);

        // 1、判断这个邮箱是否存在
        boolean flag = userService.sendEmail(email);
        // 1.1）、发邮件说成功！
        if (flag) {
            model.addAttribute("msg", "我们已经为你的邮箱成功发送了一份邮件!");
        } else {
            model.addAttribute("msg", "我们已经为你的邮箱发送了一份邮件!");
        }
        // 2、不存在
        // 2.1）、不发邮件
        // 2.2）、隐私提示；成功
        //

        return "success";
    }

    /**
     * 伪静态化效果
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping(value = "/main.html")
    public String toMainPage(HttpSession session) {
        // 校验
        // 判断session中是否有这个用户，如果没有去登陆页面
        Object object = session.getAttribute(Constants.LOGIN_USER);
        if (object == null) {
            // 用户没登陆
            return "redirect:/login.jsp";
        } else {
            // 用户登陆才来到主页，session中没有菜单，或者菜单被我们从session中清除了
            if (session.getAttribute(Constants.USER_MENUS) == null) {
                // 1、先查出所有菜单，在页面进行显示
                List<TPermission> menus = ps.getAllMenus();
                // 2、将查到的菜单放在请求域中/session域中；
                // 菜单这些数据没必要每次来到主页，都调用service方法进行查询；放在session用户，
                // 当前用户的这次会话一直使用，只需要去数据库查一次
                session.setAttribute(Constants.USER_MENUS, menus);
            }

            return "manager/main";
        }

    }

}
