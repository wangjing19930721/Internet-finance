package com.atguigu.scw.restapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.atguigu.scw.manager.bean.TMemberTicket;
import com.atguigu.scw.manager.bean.TMemberTicketExample;
import com.atguigu.scw.manager.bean.TMemberTicketExample.Criteria;
import com.atguigu.scw.manager.dao.TMemberTicketMapper;
import com.atguigu.scw.restapi.service.MemeberTicketService;


@Controller
public class MemeberTicketServiceImpl implements MemeberTicketService {
    
    @Autowired
    TMemberTicketMapper ticketMapper;
    
    @Override
    public TMemberTicket getAuthTicket(Integer mid) {
        // TODO Auto-generated method stub
        TMemberTicketExample example = new TMemberTicketExample();
        Criteria criteria = example.createCriteria();
        criteria.andMemberidEqualTo(mid);
        
        List<TMemberTicket> list = ticketMapper.selectByExample(example);
        int size = list.size();
        
        //获取到用户的当前流程实例的信息
        TMemberTicket ticket = list.get(size-1);
        return ticket;
    }

}
