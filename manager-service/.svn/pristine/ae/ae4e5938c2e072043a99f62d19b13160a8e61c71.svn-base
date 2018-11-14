package com.atguigu.scw.manager.service;

import java.util.List;

import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.bean.TUserExample;



public interface UserService {

    boolean register(TUser user);

    TUser login(TUser user);

    //查询所有用户
    List<TUser> getAll();
    
    List<TUser> getAllByCondition(TUserExample example);

    void deleteBatchOrSingle(String ids);

    //发送忘记密码邮件
    boolean sendEmail(String email);
    
    //检查邮箱存在？  true：存在  false：不存在
    TUser checkEmailExist(String email);
    
    boolean updatePasswordByToken(String token,String pwd);

   
    

}
