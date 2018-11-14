package com.atguigu.scw.manager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.manager.bean.TAdvertisement;
import com.atguigu.scw.manager.dao.TAdvertisementMapper;
import com.atguigu.scw.manager.service.AdvertisService;


@Service
public class AdvertisServiceImpl implements AdvertisService {

    @Autowired
    TAdvertisementMapper advertisementMapper;
    
    @Override
    public boolean addAdver(TAdvertisement advertisement) {
        // TODO Auto-generated method stub
        return advertisementMapper.insertSelective(advertisement)>0;
    }

    @Override
    public List<TAdvertisement> getAll() {
        // TODO Auto-generated method stub
        return advertisementMapper.selectByExample(null);
    }

  

}
