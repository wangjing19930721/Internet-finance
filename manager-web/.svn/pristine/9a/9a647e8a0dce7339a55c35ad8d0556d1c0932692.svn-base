package com.atguigu.scw.manager.controller.permission;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.manager.bean.TPermission;
import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.service.RoleService;
import com.atguigu.scw.manager.service.TPermissionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理角色维护模块的请求
 * 
 * @ClassName RoleController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月8日 上午9:37:16
 * @version 1.0.0
 */
@RequestMapping("/permission/role")
@Controller
public class RoleController {

    @Autowired
    RoleService roleService;
    @Autowired
    TPermissionService permissionService;
    
    /**
     * 更新角色权限；
     * 1、先删除当前角色的所有权限
     * 2、在新增之前选中的所有权限
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping("/update")
    public String deleteRolePermission(@RequestParam("pids")String pids,
            @RequestParam("rid")Integer rid){
        boolean flag = permissionService.updatePermission(pids,rid);
        System.out.println("更新完成...");
        return "ok!";
    }

    // /permission/role/perm/4
    @ResponseBody
    @RequestMapping("/perm/{id}")
    public List<TPermission> getRolePermisson(@PathVariable("id") Integer rid) {
        List<TPermission> permissions = permissionService.getRolePermission(rid);
        return permissions;
    }

    /**
     * 返回所有权限的json数据
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @ResponseBody
    @RequestMapping("/json")
    public List<TPermission> getAllPermission() {
        // 返回所有的权限
        return permissionService.getPermissions();
    }

    /**
     * 来到角色列表页面
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/list")
    public String toRolePage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
            @RequestParam(value = "ps", defaultValue = "10") Integer ps, Model model,
            @RequestParam(value = "sp", defaultValue = "") String search) {

        PageHelper.startPage(pn, ps);
        List<TRole> role = roleService.getAllRole();
        PageInfo<TRole> info = new PageInfo<>(role, 5);
        model.addAttribute("role_info", info);

        return "manager/permission/role";
    }

}
