package com.atguigu.scw.manager.service;


public interface UserRoleService {
    
    //1、给用户添加哪些角色
    public void addRole(String ids,Integer userId);
    
    //2、移除用户的某些角色
    public void removeRole(String ids,Integer userId);

}
