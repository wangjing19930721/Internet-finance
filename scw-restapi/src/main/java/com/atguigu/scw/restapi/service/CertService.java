package com.atguigu.scw.restapi.service;

import java.util.List;

import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.bean.TMemberCert;


public interface CertService {
    
    //传入账户类型
    public List<TCert> getCertsByType(String type);

    public void insertCerts(List<TMemberCert> certsList);
    

}
