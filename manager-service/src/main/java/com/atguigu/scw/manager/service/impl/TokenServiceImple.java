package com.atguigu.scw.manager.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TUserToken;
import com.atguigu.scw.manager.dao.TUserTokenMapper;
import com.atguigu.scw.manager.service.TokenService;

@Service
public class TokenServiceImple implements TokenService {

    @Autowired
    TUserTokenMapper tokenMapper;

    @Override
    public boolean saveToken(TUserToken tBean) {
        int insertSelective = tokenMapper.insertSelective(tBean);
        return insertSelective > 0;
    }

}
