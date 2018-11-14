package com.atguigu.scw.manager.dao;

import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.bean.TCertExample;
import com.atguigu.scw.manager.bean.TMemberCert;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface TCertMapper {
    long countByExample(TCertExample example);

    int deleteByExample(TCertExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TCert record);

    int insertSelective(TCert record);

    List<TCert> selectByExample(TCertExample example);

    TCert selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TCert record, @Param("example") TCertExample example);

    int updateByExample(@Param("record") TCert record, @Param("example") TCertExample example);

    int updateByPrimaryKeySelective(TCert record);

    int updateByPrimaryKey(TCert record);

    List<TCert> getCertsByAccountType(@Param("accttype")String type);

    void insertBatch(@Param("certs")List<TMemberCert> certsList);
}