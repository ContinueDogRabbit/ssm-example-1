package com.study.service;

import com.study.bean.Employee;
import com.study.bean.EmployeeExample;
import com.study.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }
    public boolean checkUser(String empName){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    public Employee getEmp(Integer id){
        return employeeMapper.selectByPrimaryKey(id);
    }

    public void updateEmp(Employee employee){
        //根据主键empId有选择的更新，因为employee中没有empName属性值
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void deletdeEmpById(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
