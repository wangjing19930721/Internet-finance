package com.atguigu.scw.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.dao.TCertMapper;
import com.atguigu.scw.manager.service.CertService;


@Service
public class CertServiceImpl implements CertService {
    
    @Autowired
    TCertMapper certMapper;

    @Override
    public List<TCert> getAllCert() {
        // TODO Auto-generated method stub
        return certMapper.selectByExample(null);
    }

}
