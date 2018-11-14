package com.atguigu.scw.manager.controller.permission;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.bean.TUserExample;
import com.atguigu.scw.manager.bean.TUserExample.Criteria;
import com.atguigu.scw.manager.bean.TUserToken;
import com.atguigu.scw.manager.constant.Constants;
import com.atguigu.scw.manager.service.RoleService;
import com.atguigu.scw.manager.service.TokenService;
import com.atguigu.scw.manager.service.UserRoleService;
import com.atguigu.scw.manager.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RequestMapping("/permission/user")
@Controller
public class UserController {

    private final String MANAGER_MAIN = "manager/main";
    @Autowired
    UserService userService;

    @Autowired
    RoleService roleService;

    @Autowired
    UserRoleService urService;
    
    @Autowired
    TokenService tokenService;

    /**
     * 添加角色 如果返回值为null，默认请求地址就会当成页面地址。
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param rids
     *            out.write("成功！")
     */
    @ResponseBody
    @RequestMapping("/assignrole")
    public String userRole(@RequestParam("rids") String rids, @RequestParam("uid") Integer uid,
            @RequestParam("opt") String opt) {
        if ("add".equals(opt)) {
            // 为某个用户添加一些角色
            urService.addRole(rids, uid);
            System.out.println("添加完成...");
        } else if("remove".equals(opt)) {
            //移除角色
            urService.removeRole(rids, uid);
            System.out.println("删除完成...");
        }

        return "";
    }

    /**
     * 去权限分配页面
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/toAssignRolePage")
    public String toAssignRolePage(@RequestParam(value = "uid") Integer uid, Model model) {
        System.out.println("要去权限分配页面，用户id：" + uid);
        // 1、查出所有权限
        List<TRole> roles = roleService.getAllRole();

        // 2、查出当前用户拥有的权限
        List<TRole> userRole = roleService.getUserRole(uid);
        Map<Integer, TRole> map = new HashMap<Integer, TRole>();
        for (TRole tRole : userRole) {
            map.put(tRole.getId(), tRole);
        }

        // 3、用户未分配的权限
        List<TRole> unRoles = new ArrayList<TRole>();
        for (TRole tRole : roles) {
            if (!map.containsKey(tRole.getId())) {
                // 用户已拥有的权限
                unRoles.add(tRole);
            }
        }

        model.addAttribute("unroles", unRoles);
        model.addAttribute("roles", userRole);
        // 来到权限分配页面
        return "manager/permission/assignRole";
    }

    /**
     * 用户删除
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/del")
    public String userDelete(@RequestParam(value = "ids", defaultValue = "") String ids) {
        if (!ids.trim().equals("")) {
            userService.deleteBatchOrSingle(ids);
        }
        System.out.println("");
        // 删除完成重新查询所有数据
        return "redirect:/permission/user/list";
    }

    /**
     * 用户列表页面显示
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String users(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
            @RequestParam(value = "ps", defaultValue = "10") Integer ps, Model model,
            @RequestParam(value = "sp", defaultValue = "") String search) {
        // 有表单提交的化建议通过额外写一个转发方法重定向到页面
        // 没有表单提交就直接转发来目标页面
        // userService.
        System.out.println("分页获取用户的逻辑");
        PageHelper.startPage(pn, ps);
        // 拿到分页查出的结果，不带条件的，页面会带来条件
        // 规则，将这个条件作为用户名或者用户昵称的查询条件
        // select * from t_user where loginacct like ? or username=?
        // List<TUser> list = userService.getAll();
        TUserExample example = new TUserExample();

        // 第一次创建的条件，默认使用and连接的
        Criteria criteria1 = example.createCriteria();
        Criteria criteria2 = example.createCriteria();
        if (!search.trim().equals("")) {
            criteria1.andLoginacctLike("%" + search + "%");
            criteria2.andUsernameLike("%" + search + "%");
        }
        example.or(criteria2);

        List<TUser> list = userService.getAllByCondition(example);

        // 去页面显示的数据
        PageInfo<TUser> info = new PageInfo<>(list, 5);

        model.addAttribute("user_info", info);
        model.addAttribute("sp", search);
        System.out.println("提交的查询参数：" + search);
        // 直接转到页面；
        return "manager/permission/user";
    }

    @RequestMapping("/login")
    public String login(TUser user,HttpServletResponse response, HttpSession session,@RequestParam(value="rememberme",defaultValue="0")String remeber) throws Exception {
        TUser login = userService.login(user);
        if (login == null) {
            // 登陆失败
            session.setAttribute("errorUser", user);
            session.setAttribute("msg", "登陆失败");
            return "redirect:/login.jsp";
            //response.sendRedirect(session.getServletContext().getContextPath()+"/login.jsp");
        }

        // 登陆成功！
        // 1、将用户放在session域中
        session.setAttribute(Constants.LOGIN_USER, login);
        
        
        //实现记住我功能
        if(remeber.equals("1")){
          //1、先判断用户是否使用了记住我功能
          //我们可以将记住我的token发送给用户进行保存
          //生成一个能用来做自动登录功能的令牌
          //1）、数据库一份，用来进行比对
          String token = UUID.randomUUID().toString().replace("-", "");
          //1、保存令牌到数据库
          TUserToken tBean = new TUserToken();
          //设置令牌所属的当前用户
          tBean.setUserid(login.getId());
          //设置令牌的值
          tBean.setAutoLogin(token);
          boolean flag = tokenService.saveToken(tBean);
          
          //2）、浏览器保存一份（以cookie的形式；长久保存）;
          //浏览器访问的时候可能会带上，我们就根据带来的cookie中自动登录的令牌匹配用户进行登录
          Cookie cookie = new Cookie("autologin", token);
          //一周以内这个cookie都在
          cookie.setMaxAge(3600*24*7);
          //springmvc出于安全考虑，只能设置当前工程路径的cookie
          //cookie默认就是所有访问都在  path "/"
          //cookie必须是当前项目的下的访问权限   path   /manager-web
          //springmvc出于安全考虑，
          cookie.setPath(session.getServletContext().getContextPath());
          
          //给响应里面添加cookie
          response.addCookie(cookie);
          System.out.println(cookie);
          //response.addHeader("Set-Cookie", "autologin=1");
          //将登陆的用户放在缓存库中
          session.getServletContext().setAttribute(token, login);
          
        }
        
        //response.sendRedirect("/");
        //response.sendRedirect(session.getServletContext().getContextPath()+"/main.html");
        return "redirect:/main.html";
    }

    /**
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/reg")
    public String reg(TUser user, Model model, HttpSession session) {
        // TUser [id=null, loginacct=aaaaaa, userpswd=123456, username=null, email=aaa@163.com, createtime=null]
        // System.out.println("用户注册..."+user);
        // 1、注册用户；
        boolean flag = userService.register(user);
        // 注册成功
        if (flag) {

            // 1、公司用户注册成功来到后台的控制面板
            // 1、把这个用户重新获取查出来放在session中
            // 2、我们采取的方式，用户保存的数据在user对象中，id是数据库生成的自增主键
            // 3、需要修改mybatis的mapper文件，让其使用自动生成的id

            session.setAttribute(Constants.LOGIN_USER, user);

            return "redirect:/main.html";
        } else {
            // 2、注册失败
            model.addAttribute("regError", "用户名已经被使用");
            // 3、来到页面要回显user之前输入的内容
            // 4、user先从隐含模型中拿的；只要是pojo，确定完值以后会自动的放在隐含模型中；
            // 用的key是类名首字母小写 ${tUser.loginacct}
            return "forward:/reg.jsp";
        }

    }

}
