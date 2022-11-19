package com.study.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.bean.Employee;
import com.study.bean.Msg;
import com.study.service.EmployeeService;
//import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee emp, BindingResult result) {
        System.out.println(result.toString());
        if (result.hasErrors()) {
            //校验失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError:errors){
                //把错误的字段名和提示信息放到map中
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            //因为表单所有控件的name和Employee类的属性名相同，他会自动封装成Employee对象
            employeeService.saveEmp(emp);
            return Msg.success();
        }
    }

    //检验用户名是否可用
    @ResponseBody
    @RequestMapping("/checkuser")
    public Msg checkUser(String empName) {
        //先判断用户名是否是合法的表达式
        String regName = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        //注意是String。matchs(reg)
        if (!empName.matches(regName)) {
            return Msg.fail().add("va_msg", "用户名必须为6-13位英文和数字的组合或者2-5位中文");
        }
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /**
     * 导入Jackson包
     * 返回json 使用@ResponseBody
     *
     * @param pn 第几页
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //这不是一个分页查询
        //引入PageHelper
        //查询前调用startpage，传入页码和每页的条数
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        //使用PageInfo包装查询后的结果，只需要将pageInfo交给页面就行了,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }

    /**
     *根据id查找employee
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 保存更新后的employee对象
     */
    @ResponseBody
    //注意这里参数是empId才会封装到emplyee里面而不能是id
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        //System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id删除单个员工 或者 批量删除
     * 1          1-2-3
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        System.out.println(ids);
        if (ids.contains("-")){
            List<Integer> list=new ArrayList<>();
            //批量删除
            String[] str_ids = ids.split("-");
            //把string数组转换为List<Integer>
            for (String id:str_ids){
                list.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(list);
        }else {
            //单个删除
            employeeService.deletdeEmpById(Integer.parseInt(ids));
        }
        return Msg.success();
    }
}
