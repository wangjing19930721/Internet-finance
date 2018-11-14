package com.atguigu.scw.restapi.service;

import com.atguigu.scw.manager.bean.TMemeber;


public interface MemberService {
    
    /**
     * 用户注册。返回注册好的用户对象
     */
    public TMemeber regist(TMemeber tMemeber);

    public TMemeber login(TMemeber memeber);

    public boolean authBaseInfo(TMemeber memeber);
    
    
    public boolean saveEmail(TMemeber memeber);

    public void sendEmail(String email,String username,Integer mid);
}
