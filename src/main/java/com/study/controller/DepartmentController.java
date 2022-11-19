package com.study.controller;

import com.study.bean.Department;
import com.study.bean.Msg;
import com.study.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;
    /**
     * 返回所有部门信息
     */
    @ResponseBody
    @RequestMapping("depts")
    public Msg getDepts(){
        List<Department> depts=departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
