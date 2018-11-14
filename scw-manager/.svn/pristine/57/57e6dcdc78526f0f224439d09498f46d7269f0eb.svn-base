package com.atguigu.scw.manager.controller.audi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.scw.manager.bean.TMemberCert;
import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.manager.service.MemberCertService;
import com.atguigu.scw.manager.service.MemberService;


/**
 * 实名审核页面对应的请求
 * @ClassName AudiController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月19日 上午11:22:21
 * @version 1.0.0
 */
@RequestMapping("/audi/auth")
@Controller
public class AudiController {
    
    @Autowired
    MemberService memberService;
    
    @Autowired
    MemberCertService memberCertService;
    
    @Autowired
    TaskService taskService;
    
    @RequestMapping("/list")
    public String list(Model model){
        //1、领取实名认证任务
        List<Task> list = taskService.createTaskQuery().taskName("人工审核").list();
        
        /**
         * 根据当前任务的流程的实例id；找出是哪个用户申请的（t_member_ticket）
         * 然后根据用户id，找到用户申请时保存的信息；
         * t_memeber  realname,cardno
         * t_memeber_cert  资质图片路径
         * 
         * <tr>
                <th width="30">任务的id</th>
                <th width="30">
                <input id="checkall_btn" type="checkbox"></th>
                <th>申请的用户名</th>
                <th>实名</th>
                <th>身份证号</th>
                <th>邮箱</th>
                <th>资质图片</th>
                <th width="100">操作</th>
            </tr>
            */
        List<Map<String, Object>> pageResult = new ArrayList<Map<String,Object>>();
        
        
        for (Task task : list) {
            Map<String, Object> map = new HashMap<>();
            //1、先放一些流程信息
            map.put("taskId", task.getId());
            //流程实例的id
            map.put("processId", task.getProcessInstanceId());
            
            //根据任务对应的流程id查出详细信息
            //2、放数据信息；查memeber信息
            //2.1）查基本信息
            TMemeber memeber = memberService.getMemberByTicket(task.getProcessInstanceId());
            map.put("member", memeber);
            //2.2）查资质图片信息
            //map.put("realname", value)
            List<TMemberCert> certs = memberCertService.getCertsByTicketId(task.getProcessInstanceId());
            map.put("certs", certs);
            
            //map封装好数据放入list
            pageResult.add(map);
        }
        
        model.addAttribute("pageInfo", pageResult);
        return "manager/audi/authlist";
    }

}
