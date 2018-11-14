package com.atguigu.scw.manager.controller.manager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.scw.manager.bean.TAccountTypeCert;
import com.atguigu.scw.manager.bean.TCert;
import com.atguigu.scw.manager.service.CertService;
import com.atguigu.scw.manager.service.CertTypeService;

/**
 * 分类管理
 * 
 * @ClassName TypeController
 * @Description TODO(这里用一句话描述这个类的作用)
 * @author lfy
 * @Date 2017年7月12日 上午10:34:08
 * @version 1.0.0
 */
@RequestMapping("/servicectrl/type")
@Controller
public class TypeController {

    @Autowired
    CertService certService;

    @Autowired
    CertTypeService certTypeService;

    @RequestMapping("/ctrl")
    public String list(Model model) {
        // 1、先去数据库查出表格横向的显示数据
        List<String> types = Arrays.asList("商业公司", "个体工商户", "个人经营", "政府及非营利组织");

        // 2、在查出纵向要显示的标题
        List<TCert> certs = certService.getAllCert();

        // 3、横纵坐标的状态；做一个二维矩阵
        // 3.1)、查出商业公司拥有哪些资质
        // 3.2)、保存在一个数组中；model.addAttribute("t1",list)
        // 4.1）、查出个人公司拥有哪些资质model.addAttribute("t2",list)
        // 4次数据库查询
        // 一次数据库查询，组装一个二维矩阵；
        // 查出资质和账户的对应关系
        List<TAccountTypeCert> tAccountTypeCerts = certTypeService.getAll();
        Boolean[][] relations = new Boolean[certs.size()][types.size()];
        
        //  7-4
        // 确定
        for (int i = 0; i < relations.length; i++) {
            for (int j = 0; j < relations[i].length; j++) {
                //拿出当前的资质
                TCert tCert = certs.get(i);
                //拿出当前的类型
                String type = types.get(j);
                //对照是否有这个资质对应的类型
                //  2-1  2-2 2-3 2-4
                // 查出了10个
                for (TAccountTypeCert tct : tAccountTypeCerts) {
                    relations[i][j] = tct.getAccttype().equals(type) && tct.getCertid()==tCert.getId();
                    //确定成功就跳出循环
                    if(relations[i][j] == true) break;
                }
            }
        }
        
        //[7][4]
        for (Boolean[] booleans : relations) {
            //第一层的长度
            for (Boolean boolean1 : booleans) {
                //第二层的for
                System.out.print(boolean1+"\t");
            }
            System.out.println();
        }

        model.addAttribute("types", types);
        model.addAttribute("certs", certs);
        //确定好的二维矩阵交给页面
        model.addAttribute("relations", relations );
        return "manager/serviceman/type";
    }

}
