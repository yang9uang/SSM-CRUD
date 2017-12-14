package yg.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import yg.ssm.bean.Employee;
import yg.ssm.bean.Msg;
import yg.ssm.service.EmployeeService;

/**
 * 处理员工CRUD	请求
 * @author Yanf
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeServis;
	
	/**
	 * 单个删除和批量删除二合一
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		//System.out.println(id);
		if(ids.contains("-")){
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeServis.deleteBatch(del_ids);
			
		}else{
			Integer id = Integer.parseInt(ids);
			employeeServis.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	/**
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee){
		System.out.println(employee);
		employeeServis.updateEmp(employee);
		return Msg.success();
	}
	/**
	 * 根据ID查询员
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id){//@PathVariable("id")指定页面过来的ID
		Employee employee = employeeServis.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 * 员工保存
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmps(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败，返回错误信息，在模态框中显示
			Map<String,Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeServis.saveEmps(employee);
			return Msg.success();	
		}
	}
	
	/**
	 * 校验用户名是否重复
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkuser(@RequestParam("empName")String empName){
		String regx = "(^[a-zA_Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)";

		if(!empName.matches(regx)){
			System.out.println(empName.matches(regx) + empName);
			return Msg.fail().add("va_msg", "*用户名可以是2-5位中文或者6-16位英文和数字的组合!");
		}
		//数据库用户名重复校验
		boolean b = employeeServis.checkuser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用!");
		}
	}
	
	/**
	 *导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
				//这不是分页查询
				//引入 PageHelper分页插件
				//在查询之前只需要调用,传入页码pn,以及每页的大小
				 PageHelper.startPage(pn,10);
				 //startPage后面紧跟的这个查询就是分页查询
				List<Employee> emps = employeeServis.getAll();
				//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
				//封装的相信的分页信息，包括有我们查询出来的数据，传入连续显示的页数
				PageInfo page = new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	/**
	 * 查询员工数据
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		//这不是分页查询
		//引入 PageHelper分页插件
		//在查询之前只需要调用,传入页码pn,以及每页的大小
		 PageHelper.startPage(pn,5);
		 //startPage后面紧跟的这个查询就是分页查询
		List<Employee> emps = employeeServis.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
		//封装的相信的分页信息，包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps,10);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
