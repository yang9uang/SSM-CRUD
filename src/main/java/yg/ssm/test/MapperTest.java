package yg.ssm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import yg.ssm.bean.Department;
import yg.ssm.bean.Employee;
import yg.ssm.dao.DepartmentMapper;
import yg.ssm.dao.EmployeeMapper;

/**
 * 测试dao层的工作
 * @author Yanf
 *推荐Spring的项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 *导入SpringTest单元测试模块
 *@ContextConfiguration指定spring文件位置
 *直接Autowired
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	/**
	 * 测试departmentMapper
	 */
	@Test
	public void testCURD(){
		//1.创建SpringIOC容器
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);
		System.out.println(departmentMapper);
		
		/*//1.插入几个部门
		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//2.生成员工数据
		System.out.println(employeeMapper);*/
		
		employeeMapper.insertSelective(new Employee(null, "李四", "M", "3725689@163.com", 1));
		
		//批量插入,使用可以批量操作的sqlsession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@163.com", 1));
		}
		
		System.out.println("OD");
		
		//employeeMapper.selectByExample(example)
		
	}
}
