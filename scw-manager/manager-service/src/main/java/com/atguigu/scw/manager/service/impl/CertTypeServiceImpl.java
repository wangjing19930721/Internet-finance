package com.atguigu.scw.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TAccountTypeCert;
import com.atguigu.scw.manager.dao.TAccountTypeCertMapper;
import com.atguigu.scw.manager.service.CertTypeService;


@Service
public class CertTypeServiceImpl implements CertTypeService {
    
    @Autowired
    TAccountTypeCertMapper mapper;

    @Override
    public List<TAccountTypeCert> getAll() {
        // TODO Auto-generated method stub
        return mapper.selectByExample(null);
    }

}
