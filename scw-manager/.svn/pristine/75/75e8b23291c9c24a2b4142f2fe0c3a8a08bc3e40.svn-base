package com.atguigu.scw.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TMemberCert;
import com.atguigu.scw.manager.dao.TMemberCertMapper;
import com.atguigu.scw.manager.service.MemberCertService;


@Service
public class MemberCertServiceImpl implements MemberCertService {
    
    @Autowired
    TMemberCertMapper certMapper;

    @Override
    public List<TMemberCert> getCertsByTicketId(String processInstanceId) {
        
        return certMapper.getCertsByTicketId(processInstanceId);
    }

}
