package com.atguigu.scw.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.dao.TRoleMapper;
import com.atguigu.scw.manager.service.RoleService;


@Service
public class RoleServiceImpl implements RoleService {
    
    @Autowired
    TRoleMapper roleMapper;

    @Override
    public List<TRole> getAllRole() {
        // TODO Auto-generated method stub
       
        return  roleMapper.selectByExample(null);
    }

    @Override
    public List<TRole> getUserRole(Integer userId) {
        // TODO Auto-generated method stub
        return roleMapper.getUserRole(userId);
    }

}
