package com.atguigu.scw.manager.controller.manager;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.scw.manager.bean.TAdvertisement;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


/**
 * 处理流程上传一级部署的控制器
 * @ClassName ProcessController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月17日 下午3:24:33
 * @version 1.0.0
 */
@Controller
@RequestMapping("/servicectrl/prod")
public class ProcessController {
    
    @Autowired
    RepositoryService repositoryService;
    
    
    @RequestMapping("/list")
    public String list(){
        
        return "manager/serviceman/process";
    }
    
    //使用部署id能获取到流程图；
    //按照流程id找到部署id，按照部署id查询流程的二进制信息
    @ResponseBody
    @RequestMapping(value="/process.jpg")
    public byte[] getProImg(@RequestParam("pid")String processDefinetionId) throws Exception{
        //1、拿到流程定义
        ProcessDefinition definition = repositoryService.createProcessDefinitionQuery()
            .processDefinitionId(processDefinetionId)
            .singleResult();
        //2、拿到部署id
        String deploymentId = definition.getDeploymentId();
        //按照部署id查出部署信息
        List<String> list = repositoryService.getDeploymentResourceNames(deploymentId);
        String pngName = "";
        //拿到流程图片的名字
        for (String string : list) {
            if(string.endsWith(".png")){
                pngName = string;
            }
        }
        
        //流程定义--一一对应----部署信息---按照部署查出资源
        //3、按照部署id和图片名查出这个图片
        InputStream inputStream = repositoryService.getResourceAsStream(deploymentId, pngName);
        byte[] bs = IOUtils.toByteArray(inputStream);
        inputStream.close();
        return bs;
    }
    
    
    @ResponseBody
    @RequestMapping(value="/upload",produces="text/html;charset=utf-8")
    public String upload(@RequestParam("processfile")MultipartFile file) throws Exception{
        //整合流程框架；查到所有的流程信息
        // limit 0,5
        //部署流程
        try {
            Deployment deploy = repositoryService.createDeployment()
                .addInputStream(file.getOriginalFilename(), file.getInputStream())
                .deploy();
            
            return "成功！";
        } catch (Exception e) {
            return "失败！";
        }
    }
    
    @ResponseBody
    @RequestMapping("/json")
    public List<Map<String, Object>> json(){
        //整合流程框架；查到所有的流程信息
        //ProcessDefinition属性里面有一些属性会导致循环引用；
        // limit 0,5
        // [{},{},{} ]
        //ProcessDefinition对应一个map
        List<Map<String, Object>> pd = new ArrayList<Map<String,Object>>();
        //将这个对象需要在页面展示的属性提取出来
        List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().list();
        for (ProcessDefinition processDefinition : list) {
            Map<String, Object> values = new HashMap<String, Object>();
            values.put("id", processDefinition.getId());
            values.put("name", processDefinition.getName());
            values.put("key", processDefinition.getKey());
            values.put("version", processDefinition.getVersion());
            pd.add(values);
        }
        return pd;
    }

}
