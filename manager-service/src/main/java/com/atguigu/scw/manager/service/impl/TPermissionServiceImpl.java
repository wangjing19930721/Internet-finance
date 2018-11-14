package com.atguigu.scw.manager.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TPermission;
import com.atguigu.scw.manager.bean.TRolePermission;
import com.atguigu.scw.manager.bean.TRolePermissionExample;
import com.atguigu.scw.manager.bean.TRolePermissionExample.Criteria;
import com.atguigu.scw.manager.dao.TPermissionMapper;
import com.atguigu.scw.manager.dao.TRolePermissionMapper;
import com.atguigu.scw.manager.service.TPermissionService;

@Service
public class TPermissionServiceImpl implements TPermissionService {

    @Autowired
    TPermissionMapper mapper;
    @Autowired
    TRolePermissionMapper rolePermissionMapper;

    public List<TPermission> getPermissions() {
        return mapper.selectByExample(null);
    }

    @Override
    public List<TPermission> getAllMenus() {
        // 父菜单保存
        List<TPermission> menus = new ArrayList<TPermission>();
        Map<Integer, TPermission> map = new HashMap<Integer, TPermission>();

        // 这是所有菜单；18个菜单
        List<TPermission> list = mapper.selectByExample(null);

        /**
         * 递归结束条件，一定得有一个跳出条件； 斐波那契数列；1 1 2 3 5 8 杨辉三角； 出圈问题； 浪费时间而赚取空间； 很多程序有一个概念叫 算法： 时间（空间）复杂度： 常规循环复杂为： log1
         * //无限极菜单；递归方法; 递归使用于很多方面； 树形结构遍历； 二叉树；二叉树遍历算法 二叉树的数据结构； public void bulidMenus(List<Permission> list){
         * for(Permission p:list) { if(hasChilds()){ //拿到当前的子菜单 List childs = getCurrentsChilds(p);
         * bulidMenus(List<Permission> list) }else{ //添加到父菜单的集合中;只保存一个大的一级菜单 //menus.add(menus)； //把他加入到上级菜单中
         * addToParentMenu(p){ //找到当前菜单的父菜单； //p_menu = p.getPid //当前菜单设置进去 p_menu.addChilds(p); } } }
         */

        // 1、将所有菜单都放在map中
        // 都是引用，如果从map中拿到这个数据改变以后，map中页面变化
        for (TPermission tPermission : list) {
            map.put(tPermission.getId(), tPermission);
        }
        // logN
        // log2n
        // logn2 18
        // 二级菜单？
        for (TPermission tPermission : list) {

            if (tPermission.getPid() == 0) {
                // 父菜单;确定了4个父菜单
                menus.add(tPermission);
            } else {// 子菜单；加入到父菜单中

                // tPermission（子菜单），拿到父菜单
                Integer pid = tPermission.getPid();
                // 拿到父菜单；以pid的值作为map中的菜单id，就是父菜单
                TPermission p_menu = map.get(pid);
                // 拿到当前父菜单的子菜单；子菜单会有一些额外的问题
                // 这个list第一次获取是没有的，如果添加上一次以后。这个list是有的
                List<TPermission> childs = p_menu.getChilds();
                if (childs != null) {
                    // 当前有子菜单
                    childs.add(tPermission);
                } else {
                    // 当前没有子菜单
                    childs = new ArrayList<>();
                    // 添加当前子菜单
                    childs.add(tPermission);
                    // 将当前整理好的childs设置进去
                    p_menu.setChilds(childs);
                }
                //
                // childs.add(tPermission);
                // p_menu.setChilds(childs);
                // for (TPermission p_m : list) {
                // if(p_m.getId() == pid){
                // p_m.setChilds(null);
                // }
                // }
            }
        }

        // 将菜单的子父级关系整理好交给页面
        // List<TPermission>
        // List[Tp1{
        // childMenus{}
        // },Tp2,Tp3,Tp4]
        // 整理父子关系，将子菜单设置到父菜单的 private List<TPermission> childs;里面

        // 1、查出父菜单；不推荐。
        // List<4> parents = getParents(pid=0);
        // 2、遍历父菜单
        // for(TPermission p:parents){
        // 查出这个的子菜单List<7> childs = getChild(pid=p.id)
        // p.setChilds(childs);
        // }

        // 采取的做法，一次性查出所有菜单，使用程序进行组合

        return menus;
    }

    /**
     * 查询角色对应的权限
     */
    @Override
    public List<TPermission> getRolePermission(Integer rid) {

        return mapper.getRolePermission(rid);
    }

    @Override
    public boolean updatePermission(String pids, Integer rid) {
        // 1、先删除当前角色的所有权限
        TRolePermissionExample example = new TRolePermissionExample();
        Criteria criteria = example.createCriteria();
        criteria.andRoleidEqualTo(rid);
        rolePermissionMapper.deleteByExample(example);

        // 2、新增
        String[] split = pids.split(",");
        if (split != null && split.length >= 1) {
            for (String pid : split) {
                    int i = Integer.parseInt(pid);
                    TRolePermission permission = new TRolePermission();
                    //设置角色id
                    permission.setRoleid(rid);
                    //设置权限id
                    permission.setPermissionid(i);
                    //保存角色权限关系
                    rolePermissionMapper.insertSelective(permission);
            }
            return true;
        }
        return false;
        
    }

}
