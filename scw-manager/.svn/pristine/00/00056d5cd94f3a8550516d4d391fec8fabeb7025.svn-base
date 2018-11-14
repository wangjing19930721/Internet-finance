package com.atguigu.scw.manager.controller.manager;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.scw.manager.bean.TAdvertisement;
import com.atguigu.scw.manager.bean.TUser;
import com.atguigu.scw.manager.constant.Constants;
import com.atguigu.scw.manager.service.AdvertisService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/servicectrl/ads")
public class AdvertismentController {

    @Autowired
    AdvertisService advertisService;
    
    /**
     * 返回所有广告的json数据
     * @Description (TODO这里用一句话描述这个方法的作用)
     */
    @ResponseBody
    @RequestMapping("/json")
    public PageInfo<TAdvertisement> getAdJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
        
        PageHelper.startPage(pn, 7);
        List<TAdvertisement> ads = advertisService.getAll();
        
        PageInfo<TAdvertisement> info = new PageInfo<>(ads,5);
        
        return info;
    }

    @RequestMapping("/list")
    public String list() {
        return "manager/serviceman/advertisement";
    }

    /**
     * produces="text/html;charset=utf-8"相当于给响应头加Content-Type能解决乱码
     * @Description (TODO这里用一句话描述这个方法的作用)
     * @param session
     * @param file
     * @param name
     * @return
     */
    @ResponseBody
    @RequestMapping(value="/upload",produces="text/html;charset=utf-8")
    public String upload(HttpSession session, @RequestParam("ad")MultipartFile file, String name) {

        // 1、获取某个文件夹在服务器上的真实路径
        ServletContext context = session.getServletContext();
        // 2、使用context对象获取真实路径
        String adPath = context.getRealPath("/advertisments");
        // 3、把文件上传到这个位置
        String filename = UUID.randomUUID().toString().replace("-", "").substring(0, 10) + "_file_"
                + file.getOriginalFilename();
        try {
            // 文件上传后的网络位置
            String netUrl = "advertisments/" + filename;
            file.transferTo(new File(adPath + "/" + filename));
            TAdvertisement advertisement = new TAdvertisement();
            advertisement.setName(name);
            advertisement.setUrl(netUrl);
            advertisement.setUserid(((TUser)session.getAttribute(Constants.LOGIN_USER)).getId());
            // 保存到数据库中
            boolean flag = advertisService.addAdver(advertisement);
            if (flag) {
                return "保存成功！";
            } else {
                return "广告上传失败！";
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            System.out.println("广告上传异常："+e);
            return "广告上传失败!!!";
        }
    }

}
