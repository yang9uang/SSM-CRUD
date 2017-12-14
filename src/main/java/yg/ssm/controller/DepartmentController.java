package yg.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import yg.ssm.bean.Department;
import yg.ssm.bean.Msg;
import yg.ssm.service.DepartmentService;

/**
 *处理部门有关的请求
 * @author Yanf
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有的部門信息
	 */
	@RequestMapping("depts")
	@ResponseBody
	public Msg getDepts(){
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
	
}
