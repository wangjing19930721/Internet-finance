package com.atguigu.scw.manager.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.manager.dao.TMemeberMapper;
import com.atguigu.scw.manager.service.MemberService;


@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    TMemeberMapper memeberMapper;
    
    @Override
    public TMemeber getMemberByTicket(String processInstanceId) {
        // TODO Auto-generated method stub
        
        
        return memeberMapper.getMemberByTicket(processInstanceId);
    }

}
