package com.atguigu.scw.restapi.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.project.MD5Util;
import com.atguigu.scw.manager.bean.TMemberTicket;
import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.manager.bean.TMemeberExample;
import com.atguigu.scw.manager.bean.TMemeberExample.Criteria;
import com.atguigu.scw.manager.dao.TMemberTicketMapper;
import com.atguigu.scw.manager.dao.TMemeberMapper;
import com.atguigu.scw.restapi.service.MemberService;


@Service
public class MemberServiceImpl implements MemberService {
    
    @Autowired
    TMemeberMapper memeberMapper;
    
    @Autowired
    TMemberTicketMapper ticketMapper;
    
    
    
    @Autowired
    RepositoryService repositoryService;
    
    @Autowired
    RuntimeService runtimeService;
    
    @Autowired
    TaskService taskService;

    @Override
    public TMemeber regist(TMemeber tMemeber) {
        // TODO Auto-generated method stub
        String digest = MD5Util.digest(tMemeber.getUserpswd());
        //加密密码保存
        tMemeber.setUserpswd(digest);
        //初始化用户名和账号
        tMemeber.setUsername(tMemeber.getLoginacct());
        //实名认证状态  0:未实名认证  1::实名认证
        tMemeber.setAuthstatus("0");
        //真实姓名；实名认证是保存的
        tMemeber.setRealname("未实名");
        // 0：普通会员    1：月费会员  2：年费会员   3：
        tMemeber.setUsertype("0");
        //身份证号，账户类型；（实名认证是做的）
        //账户类型：直接保存账户的全名
        
        int i = memeberMapper.insertSelective(tMemeber);
        
        //刚才就是按照这个对象给数据库插入值，希望获取到数据库分配的自增主键
        return tMemeber;
    }

    /**
     * 登陆要返回登成功的用户对象
     */
    @Override
    public TMemeber login(TMemeber memeber) {
        // TODO Auto-generated method stub
        TMemeberExample example = new TMemeberExample();
        Criteria criteria = example.createCriteria();
        
        criteria.andLoginacctEqualTo(memeber.getLoginacct());
        criteria.andUserpswdEqualTo(MD5Util.digest(memeber.getUserpswd()));
        
        List<TMemeber> list = memeberMapper.selectByExample(example);
        
        return list.size()==1?list.get(0):null;
    }

    /**
     * 按照id更新已经携带的字段
     */
    @Override
    public boolean authBaseInfo(TMemeber memeber) {
        // TODO Auto-generated method stub
        int i = memeberMapper.updateByPrimaryKeySelective(memeber);
        return i>0;
    }

    @Override
    public boolean saveEmail(TMemeber memeber) {
        // TODO Auto-generated method stub
        //按主键更新email
        try {
            memeberMapper.updateByPrimaryKeySelective(memeber);
        } catch (Exception e) {
            System.out.println("邮箱违反唯一约束");
            return false;
        }
        return true;
    }

    @Override
    public void sendEmail(String email,String username,Integer mid) {
        // TODO Auto-generated method stub
        //启动流程框架的邮件发送任务；查到这个流程的定义信息
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionName("实名认证流程").latestVersion().singleResult();
        //流程实例的id；
       // runtimeService.startProcessInstanceById("");
        //启动流程
        //流程一但一启动会产生流程实例
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("useremail", email);
        map.put("user", username);
        String code = UUID.randomUUID().toString().replace("-", "").substring(0, 5);
        //如果是流程框架可以不保存
        map.put("code",code );
        ProcessInstance processInstance = runtimeService
                .startProcessInstanceById(processDefinition.getId(), map);
        
        //保存流程实例信息到数据库；
        //用户启动了哪个流程；工单；
        //维修；保存用户对应的流程实例id，我们需要看走到哪一步流程，我们就去流程框架里面按照实例id去查询即可
        //taskService.createTaskQuery().processInstanceId(processInstance.getId()).list();
        //保存当前用户的工单；
        TMemberTicket ticket = new TMemberTicket();
        ticket.setMemberid(mid);
        ticket.setTicketid(processInstance.getId());
        ticketMapper.insertSelective(ticket);
        
    }

}
