package com.atguigu.scw.manager.dao;

import com.atguigu.scw.manager.bean.TMemberTicket;
import com.atguigu.scw.manager.bean.TMemberTicketExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface TMemberTicketMapper {
    long countByExample(TMemberTicketExample example);

    int deleteByExample(TMemberTicketExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TMemberTicket record);

    int insertSelective(TMemberTicket record);

    List<TMemberTicket> selectByExample(TMemberTicketExample example);

    TMemberTicket selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TMemberTicket record, @Param("example") TMemberTicketExample example);

    int updateByExample(@Param("record") TMemberTicket record, @Param("example") TMemberTicketExample example);

    int updateByPrimaryKeySelective(TMemberTicket record);

    int updateByPrimaryKey(TMemberTicket record);
}