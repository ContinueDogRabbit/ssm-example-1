package com.study.test;

import com.study.bean.Department;
import com.study.bean.Employee;
import com.study.bean.EmployeeExample;
import com.study.dao.DepartmentMapper;
import com.study.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

/*
    测试dao层的工作
    推荐Spring的项目可以用Spring的单元测试，可以自动注入我们需要的组件
    1.导入SpringTest模块
    2.@ContextConfiguration指定Spring配置文件的位置
    3.直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    //批处理使用的
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
        /*//1.创建SpringIOC容器
        ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
        //2.获取mapper
        DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);*/
        System.out.println(departmentMapper);
        //1.插入几个部门
        /*departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));*/
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@edu.com",1));
        //拿到的mapper可以批量执行
//        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//        for (int i=0; i<1000;i++){
//            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
//            mapper.insertSelective(new Employee(null,uid,"M",uid+"@seu.edu.cn",1));
//        }
        //删除所有
        //mapper.deleteByExample(new EmployeeExample());
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        System.out.println(employees.get(0));
    }
}
