<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>员工列表</title>

    <!-- JQ -->
	<script src="static/myjs/jquery.min.js"></script>
    <!-- Bootstrap以及jS文件 -->
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  
  <body>
    
  <!-- 员工添加的模态框 -->
  	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新增员工</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal">
				  <div class="form-group">
				    <label class="col-sm-2 control-label">姓名</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="Name">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">性别</label>
				    <div class="col-sm-10">
					    <label class="radio-inline">
							  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
						</label>
						<label class="radio-inline">
							  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
						</label>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">邮箱</label>
				    <div class="col-sm-10">
				      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="Email@Google.com">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">部门</label>
				    <div class="col-sm-4">
				    <!-- 部门提交部门ID -->
						<select class="form-control" name="dId" id="dept_add_select">
						  
						</select>
				    </div>
				  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>


   <!-- 搭载显示页面 -->
   <div class="container">
   	<!-- 标题 -->
   	<div class="row">
   		<div class="col-xs-12">
   			<h1>SSM-CRUD</h1>
   		</div>
   	</div>
   	<!-- 按钮 -->
   	<div class="row">
   		<div class="col-md-4 col-md-offset-8">
   			<button class="btn btn-primary" id="emp_add_bnt">新增</button>
   			<button class="btn btn-danger">删除</button>
   		</div>
   	</div>
   	<!-- 显示数据 -->
   	<div class="row">
   		<div class="col-xs-12">
   			<table class="table table-hover" id="emp_table">
   			<thead>
   				<tr>
   					<td>#</td>
   					<td>姓名</td>
   					<td>性别</td>
   					<td>邮箱</td>
   					<td>部门</td>
   					<td>操作</td>
   				</tr>
   			</thead>
   			<tbody>
   			
   			</tbody>
  			</table>
   		</div>
   	</div>
   	<!-- 分页信息 -->
   	<div class="row">
   		<!-- 分页文字信息 -->
   		<div class="col-xs-6" id="empsPageInfoShow">
   		</div>
   		<!-- 分页条信息 -->
   		<div class="col-xs-6" id="emp_page_nav">
	   		
			
   		</div>
   	</div>
   </div>
   <script type="text/javascript">
   
   		var totalNum;
   
   		//頁面加載完成以後，直接去發送ahax請求，要到分頁數據
	   	$(function(){
	   		//去首頁
	   		toPage(1);
	   	});
	   	
	   	function toPage(pn){
	   		$.ajax({
	   			url:"http://localhost:8080/ssm-crud/emps",
	   			data:"pn="+pn,
	   			type:"get",
	   			success:function(result){
	   				/* console.log(result); */
	   				//解析并显示员工数据
	   				build_emps_table(result);
	   				//解析并显示分页信息
	   				build_page_info(result);
	   				//解析显示分页条数据
	   				build_page_nav(result);
	   			}
	   		});
	   	}
	   	
	   	function build_emps_table(result){
	   		//每次發送請求都清空列表
	   		$("#emp_table tbody").empty();
	   		var emps = result.extend.pageInfo.list;
		   		$.each(emps,function(index,item){
		   			var empIdTd = $("<td></td>").append(item.empId);
		   			var empNameTd = $("<td></td>").append(item.empName);
		   			var genders = item.gender == 'M'?"男":"女";
		   			var genderTd = $("<td></td>").append(genders);
		   			var emailTd = $("<td></td>").append(item.email);
		   			var deptName = $("<td></td>").append(item.department.deptName);
		   			/* <button class="btn btn-primary btn-xs">
	   							<span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>编辑
	   						</button>
		   					<button class="btn btn-danger btn-xs">
		   						<span class="glyphicon glyphicon-trash " aria-hidden="true"></span>删除
		   					</button> */
		   					
		   			var editBnt = $("<button></button>").addClass("btn btn-primary btn-sm")
		   						.append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
		   			var deletBnt = $("<button></button>").addClass("btn btn-danger btn-sm")
		   						.append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
		   						
		   			var bntTd = $("<td></td>").append(editBnt).append(" ").append(deletBnt);
		   			$("<tr></tr>").append(empIdTd).append(empNameTd).append(genderTd).append(emailTd).append(deptName)
		   				.append(bntTd)
		   				.appendTo("#emp_table tbody");	
		   		})
	   	}
	   	
	   	function build_page_info(result){
	   		//每次發送請求都清空列表
	   		$("#empsPageInfoShow").empty();
	   		var pageNums = result.extend.pageInfo.pageNum;
	   		var pageAll = result.extend.pageInfo.pages;
	   		var pageTotal = result.extend.pageInfo.total;
	   		totalNum = result.extend.pageInfo.pages;
	   		$("#empsPageInfoShow").append("当前第"+pageNums+"页，共"+pageAll+"页，共"+pageTotal+"条记录");
	   	}
	   	
	   	
    //清空表单样式和内容
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".form-control").text("");
    }
    
	   	function build_page_nav(result){
	   	//每次發送請求都清空列表
	   		$("#emp_page_nav").empty();
	   		//emp_page_nav
	   		var ul = $("<ul></ul>").addClass("pagination");
	   		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
	   		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
	   		if(result.extend.pageInfo.hasPreviousPage == false){
	   			firstPageLi.addClass("disabled");
	   			prePageLi.addClass("disabled");
	   		}else{
	   			firstPageLi.click(function(){
	   				toPage(1);
	   			});
	   			prePageLi.click(function(){
	   				toPage(result.extend.pageInfo.prePage);
	   			});
	   		}
	   		
	   		var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;")); 
	   		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
	   		if(result.extend.pageInfo.hasNextPage == false){
	   			nextPageLi.addClass("disabled");
	   			lastPageLi.addClass("disabled");
	   		}else{
	   			nextPageLi.click(function(){
	   				toPage(result.extend.pageInfo.nextPage);
	   			});
	   			lastPageLi.click(function(){
	   				toPage(result.extend.pageInfo.pages);
	   			});
	   		}
	   		
	   		ul.append(firstPageLi).append(prePageLi);
	   		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
	   			var numLi = $("<li></li>").append($("<a></a>").append(item)); 
	   			if(result.extend.pageInfo.pageNum == item){
	   				numLi.addClass("active");
	   			}
	   			numLi.click(function(){
	   				toPage(item);
	   			});
	   			ul.append(numLi);
	   		});
	   		ul.append(nextPageLi).append(lastPageLi);
	   		
	   		var navEle = $("<nav></nav>").append(ul);
	   		navEle.appendTo("#emp_page_nav");
	   	}
	   	/* 点击新增按钮弹出模态框 */
	   		$("#emp_add_bnt").click(function(){
		   		//发送ajax请求，查出部门信息，显示在下拉列表中+
		   		//重置表单内容
	        	reset_form("#myModal form");
	        	
	        	getDepts("#myModal select");
	   			/* 弹出模态框 */
		   		$('#myModal').modal({
		   			backdrop:"static"
		   		});
		   		
		   		
		   		//校验表单数据
		   		function varlidate_add_form(){
		   			//先拿到要校验的数据，使用正则表达式
		   			var empName = $("#empName_add_input").val;
		   			var regName = /(^[a-zA_Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+)/;
		   			
		   			if(!regName.test(empName)){
		   				alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
		   				return false;
		   			};
		   			
		   			var empEmail = $("#email_add_input").val;
		   			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		   			
		   			if(!regEmail.test(empEmail)){
		   				alert("请检查邮箱格式是否正确:xxxxxx@xxx.xxx");
		   				return false;
		   			};
		   			
		   			return false;
		   		}
		   		
		   			//模态框中天禧的表单数据提交给服务器进行保存
		   			//发送ajax请求，保存员工
		   		$("#emp_save_btn").click(function(){
			   		//员工保存方法
			   		//先对要提交给服务器的数据进行校验
			   		if(!varlidate_add_form()){
			   			return false;
			   		};
		   			$.ajax({
		   				url:"http://localhost:8080/ssm-crud/emp",
		   				type:"POST",
		   				data:$("#myModal form").serialize(),
		   				success:function(resut){
		   					if(resut.code == 100){
		   						//成功后关闭模态框
		   						$('#myModal').modal('hide');
		   						//并且跳到最后一页显示数据
		   						toPage(totalNum);
		   					}
		   				}
		   			})
		   		});
	   	});
	   	//查出所有部门信息，并显示在下拉列表中
		   		function getDepts(ele){
		   			$.ajax({
		   				url:"http://localhost:8080/ssm-crud/depts",
		   				type:"GET",
		   				success:function(result){
		   					//{"code":100,"msg":"success","extend":
		   					//{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
		   					//$("dept_add_select").append("");
		   					$.each(result.extend.depts,function(){
		   						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
		   						optionEle.appendTo(ele);
		   					});
		   				}
		   			});
		   		}
   </script>
  </body>
</html>
