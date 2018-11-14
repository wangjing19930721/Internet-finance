package com.atguigu.scw.restapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.bean.TMemberCert;
import com.atguigu.scw.manager.bean.TMemberCertExample;
import com.atguigu.scw.manager.bean.TMemberCertExample.Criteria;
import com.atguigu.scw.manager.dao.TCertMapper;
import com.atguigu.scw.manager.dao.TMemberCertMapper;
import com.atguigu.scw.restapi.service.CertService;


@Service
public class CertServiceImpl implements CertService {
    
    @Autowired
    TCertMapper certMapper;
    @Autowired
    TMemberCertMapper memberCertMapper;

    @Override
    public List<TCert> getCertsByType(String type) {
        // TODO Auto-generated method stub
        List<TCert> certs = certMapper.getCertsByAccountType(type);
        return certs;
    }

    @Override
    public void insertCerts(List<TMemberCert> certsList) {
        // TODO Auto-generated method stub
        TMemberCertExample example = new TMemberCertExample();
        Criteria criteria = example.createCriteria();
        criteria.andMemberidEqualTo(certsList.get(0).getMemberid());
        //先删除
        memberCertMapper.deleteByExample(example);
        //后保存
        certMapper.insertBatch(certsList);
    }

}
