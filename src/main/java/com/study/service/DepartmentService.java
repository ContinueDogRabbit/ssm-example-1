package com.study.service;

import com.study.bean.Department;
import com.study.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    /**
     * 查询所有部门
     */
    public List<Department> getDepts(){
        return departmentMapper.selectByExample(null);
    }
}
