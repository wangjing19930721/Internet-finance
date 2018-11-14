package com.atguigu.scw.restapi.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.scw.manager.bean.TAccountTypeCert;
import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.bean.TMemberCert;
import com.atguigu.scw.manager.bean.TMemberTicket;
import com.atguigu.scw.manager.bean.TMemeber;
import com.atguigu.scw.manager.dao.TMemberTicketMapper;
import com.atguigu.scw.restapi.bean.ScwReturn;
import com.atguigu.scw.restapi.service.CertService;
import com.atguigu.scw.restapi.service.MemberService;
import com.atguigu.scw.restapi.service.MemeberTicketService;


@RequestMapping("/auth")
@ResponseBody
@Controller
public class AuthController {

    @Autowired
    MemberService memberService;

    @Autowired
    CertService certService;
    
    @Autowired
    TaskService taskService;
    
    @Autowired
    MemeberTicketService ticketSevrice;

   // @CrossOrigin
    @RequestMapping("/hello")
    public String hello() {
        return "abcbcs";
    }
    
    //文件上传
    private String uploadfile(String webPath,MultipartFile file,HttpSession session){
        ServletContext context = session.getServletContext();
        String realPath = context.getRealPath(webPath);
        String name = UUID.randomUUID().toString().replace("-", "").substring(0, 10) +"_file_"+ file.getOriginalFilename();
        try {
            //webPath不存在的情况下必须创建
            File file2 = new File(realPath);
            if(!file2.exists()){
                //创建目录
                file2.mkdirs();
            }
            
            file.transferTo(new File(realPath+"/"+name));
            //返回这个图片在服务器下的路径
            return webPath+"/"+name;
        }catch (Exception e) {
            return null;
        }
    }
    
    
    /**
     * 提交申请进行校验
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param code
     * @param mid
     * @return
     * 
     * String code不写相当于  @RequestParam("code")
     */
    @RequestMapping("/vacode")
    public ScwReturn<Object> validateCode(String code,Integer mid){
        //领取用户之前的实名任务完成，这个任务即可
        try {
            TMemberTicket ticket = ticketSevrice.getAuthTicket(mid);
            //之前的任务
            Task task = taskService.createTaskQuery().processInstanceId(ticket.getTicketid())
            .singleResult();
            
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("usercode", code);
            //完成任务，需要给框架提交用户输入的验证码
            taskService.complete(task.getId(), map);
            
            
            //下一个任务
            Task otherTask = taskService.createTaskQuery().processInstanceId(ticket.getTicketid())
                    .singleResult();
            if(task.getName().equals(otherTask.getName())){
                return ScwReturn.fail("申请失败！请重新提交验证码", null, null);
            }
            return ScwReturn.success("申请成功！请等待审核，3-5个工作日", null, null);
        } catch (Exception e) {
            return ScwReturn.fail("申请失败！请重新提交验证码", null, null);
        }
    }
    
    //api层进行实名认证启动；
    /**
     * 处理发邮件请求
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param member：提交email和用户id
     * 
     * email id  ;
     * 
     * @return
     */
    @RequestMapping("/sendEmail")
    public ScwReturn<Object> saveEmailInfo(TMemeber member){
        boolean flag = memberService.saveEmail(member);
        if(flag){
            //1、用户邮箱是有效的，进行邮件发送
            //查出这个用户的用户名
            try {
                memberService.sendEmail(member.getEmail(), member.getUsername(), member.getId());
                return ScwReturn.success("邮箱发送成功", null, null);
            } catch (Exception e) {
                return ScwReturn.fail("邮箱发送失败", null, null);
            }
        }
        return ScwReturn.fail("邮箱发送失败", null, null);
    }
    
    @RequestMapping("/upload")
    public ScwReturn<Object> upload(HttpSession session,
            @RequestParam("file")MultipartFile[] file,
            @RequestParam("certid")Integer[] certid,@RequestParam("memberid")Integer memberid){
        
        try {
            System.out.println("资质的id"+certid);
            List<TMemberCert> certsList= new ArrayList<TMemberCert>();
            for (int i=0;i<certid.length;i++) {
                TMemberCert cert = new TMemberCert();
                MultipartFile multipartFile = file[i];
                String uploadfile = uploadfile("/certsimg", multipartFile, session);
                cert.setCertid(certid[i]);
                cert.setMemberid(memberid);
                cert.setIconpath(uploadfile);
                certsList.add(cert);
            }
            //调用业务逻辑进行保存;/删除原有资质，保存新的资质
            certService.insertCerts(certsList);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            System.out.println(e);
            return ScwReturn.fail("资质保存失败！", null, null);
        }
        
        return ScwReturn.success("保存成功！", null, null);
    }

    /**
     * 传入用户的账户类型
     * 
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return
     */
    @RequestMapping("/certs")
    public ScwReturn<List<TCert>> getCertByAcctType(@RequestParam("accttype") String act_type) {
        List<TCert> list = certService.getCertsByType(act_type);
        if (list != null && list.size() >= 1) {
              return ScwReturn.success("资质获取成功", list, null);
        } else { 
            return ScwReturn.fail("资质获取失败", null, null);
        }
    }

    /**
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @return memeber：用户id、用户账户类型、用户真实名字，用户身份正好
     */
    @RequestMapping("/baseinfo")
    public ScwReturn<Object> auth(TMemeber memeber) {
        // 按照id更新部分认证的信息
        boolean b = memberService.authBaseInfo(memeber);
        if (b) {
            return ScwReturn.success("基本信息已经录入", null, null);
        } else {
            return ScwReturn.fail("信息录入失败，请重新提交", null, null);
        }
    }

}
