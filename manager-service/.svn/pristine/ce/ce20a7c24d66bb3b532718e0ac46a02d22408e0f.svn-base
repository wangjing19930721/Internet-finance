package com.atguigu.scw.manager.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.commons.codec.digest.Md5Crypt;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.project.MD5Util;
import com.atguigu.project.MyStringUtils;
import com.atguigu.scw.manager.bean.TRole;
import com.atguigu.scw.manager.bean.TRoleExample;
import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.bean.TUserExample;
import com.atguigu.scw.manager.bean.TUserExample.Criteria;
import com.atguigu.scw.manager.bean.TUserToken;
import com.atguigu.scw.manager.bean.TUserTokenExample;
import com.atguigu.scw.manager.dao.TRoleMapper;
import com.atguigu.scw.manager.dao.TUserMapper;
import com.atguigu.scw.manager.dao.TUserTokenMapper;
import com.atguigu.scw.manager.service.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    TUserMapper userMapper;
    @Autowired
    TRoleMapper roleMapper;

    @Autowired
    TUserTokenMapper tokenMapper;

    /**
     * 注册用户方法
     */
    @Override
    public boolean register(TUser user) {
        // user好多属性数据库默认不能为空
        // 1、拿到用户信息，先加密密码
        // 第一个参数是我们加密的密码，第二个参数是盐值
        //

        // String crypt = Md5Crypt.md5Crypt(user.getUserpswd().getBytes());
        String digest = MD5Util.digest(user.getUserpswd());
        System.out.println(digest);
        user.setUserpswd(digest);

        // 2、在将用户的其他信息设置默认值
        // 设置昵称、创建时间(String)等
        user.setUsername(user.getLoginacct());

        user.setCreatetime(MyStringUtils.formatSimpleDate(new Date()));
        // 3、去数据库保存用户；
        int i = 0;
        try {
            i = userMapper.insertSelective(user);
        } catch (Exception e) {
            // 保存失败的原因就是用户重复
            System.out.println(e);
            return false;
        }

        return i == 1 ? true : false;

    }

    @Override
    public TUser login(TUser user) {
        // 1、拿到用户名和密码

        // 2、去数据库查询是否存在
        TUserExample example = new TUserExample();
        Criteria criteria = example.createCriteria();
        // 设置查询条件
        criteria.andLoginacctEqualTo(user.getLoginacct());
        criteria.andUserpswdEqualTo(MD5Util.digest(user.getUserpswd()));
        // 可能会查询多个用户
        List<TUser> list = null;
        try {
            list = userMapper.selectByExample(example);
        } catch (Exception e) {
            System.out.println(e);
        }

        return list.size() == 1 ? list.get(0) : null;
    }

    @Override
    public List<TUser> getAll() {

        return userMapper.selectByExample(null);
    }

    @Override
    public List<TUser> getAllByCondition(TUserExample example) {
        // TODO Auto-generated method stub
        return userMapper.selectByExample(example);
    }

    @Override
    public void deleteBatchOrSingle(String ids) {
        // TODO Auto-generated method stub
        if (ids.contains(",")) {
            String[] split = ids.split(",");
            List<Integer> list = new ArrayList<Integer>();
            for (String s : split) {
                int i = 0;
                try {
                    i = Integer.parseInt(s);
                } catch (NumberFormatException e) {
                }
                list.add(i);
            }

            TUserExample example = new TUserExample();
            Criteria criteria = example.createCriteria();
            // 删除id所在的集合
            criteria.andIdIn(list);
            userMapper.deleteByExample(example);
        } else {
            userMapper.deleteByPrimaryKey(Integer.parseInt(ids));
        }
    }

    @Override
    public boolean sendEmail(String email) {
        // TODO Auto-generated method stub
        // 1、检查邮箱是否存在
        TUser user = checkEmailExist(email);
        if (user!=null) {
            // 发送邮件
            // 1、生成令牌
            String tokenStr = UUID.randomUUID().toString().replace("-", "");
            // 2、给数据库保存令牌
            // 先查询数据库当前用户，有没有令牌记录；
            TUserTokenExample example = new TUserTokenExample();
            com.atguigu.scw.manager.bean.TUserTokenExample.Criteria criteria = example.createCriteria();
            //按照用户id去查找中间的令牌表，是否这个用户有令牌
            criteria.andUseridEqualTo(user.getId());
            List<TUserToken> list = tokenMapper.selectByExample(example);
            if (list != null && list.size() > 0) {
                TUserToken token = list.get(0);
                token.setPswToken(tokenStr);
                // 将令牌更新到数据库
                tokenMapper.updateByPrimaryKeySelective(token);
            } else {
                TUserToken token = new TUserToken();
                token.setUserid(user.getId());
                token.setPswToken(tokenStr);
                tokenMapper.insertSelective(token);
            }
            // 3、把连接带令牌的连接发给用户
            HtmlEmail htmlEmail = new HtmlEmail();
            htmlEmail.setHostName("localhost");
            htmlEmail.setSmtpPort(25);
            //设置连接服务器的账号
            htmlEmail.setAuthentication("admin@atguigu.com", "123456");
            
            try {
                //设置发送给谁
                Email addTo = htmlEmail.addTo(email);
                //设置来源
                htmlEmail.setFrom("admin@atguigu.com");
                //设置邮件标题
                htmlEmail.setSubject("找回密码");
                //设置邮件内容
                htmlEmail.setContent("<h1>半小时内点击密码重置连接</h1><a href='http://127.0.0.1:8080/manager-web/getpwd?token="+tokenStr+"'>重置密码</a>", "text/html;charset=utf-8");
                //发送邮件
                htmlEmail.send();
            } catch (EmailException e) {
                System.out.println("邮件发送失败："+e);
            }
            return true;
        }
        return false;
    }

    @Override
    public TUser checkEmailExist(String email) {
        TUserExample example = new TUserExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        // 系统设计去来保存邮箱的唯一性；
        List<TUser> list = userMapper.selectByExample(example);
        if (list != null && list.size() == 1) {
            return list.get(0);
        }
        return null;
    }

    @Override
    public boolean updatePasswordByToken(String token, String pwd) {
        // TODO Auto-generated method stub
        //将密码进行md5加密
        String digest = MD5Util.digest(pwd);
        return userMapper.updatePasswordByToken(token, digest)>0;
    }

}
