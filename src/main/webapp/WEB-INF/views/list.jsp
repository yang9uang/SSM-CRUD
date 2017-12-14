<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>员工列表</title>
    <%
    	pageContext.setAttribute("APP_PATH",request.getContextPath());
     %>
    <!-- JQ -->
	<script src="${APP_PATH}/static/myjs/jquery.min.js"></script>
    <!-- Bootstrap以及jS文件 -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
  	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  
  <body>
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
   			<button class="btn btn-primary">新增</button>
   			<button class="btn btn-danger">删除</button>
   		</div>
   	</div>
   	<!-- 显示数据 -->
   	<div class="row">
   		<div class="col-xs-12">
   			<table class="table table-hover">
   				<tr>
   					<td>#</td>
   					<td>姓名</td>
   					<td>性别</td>
   					<td>邮箱</td>
   					<td>部门</td>
   					<td>操作</td>
   				</tr>
   				<c:forEach items="${pageInfo.list }" var="emp">
   					<tr>
	   					<td>${emp.empId }</td>
	   					<td>${emp.empName }</td>
	   					<td>${emp.gender=="M"?"男":"女" }</td>
	   					<td>${emp.email }</td>
	   					<td>${emp.department.deptName }</td>
	   					<td>
	   						<button class="btn btn-primary btn-xs">
	   							<span class="glyphicon glyphicon-pencil " aria-hidden="true"></span>编辑
	   						</button>
		   					<button class="btn btn-danger btn-xs">
		   						<span class="glyphicon glyphicon-trash " aria-hidden="true"></span>删除
		   					</button>
	   					</td>
   				</tr>
   				</c:forEach>
   				
  			</table>
   		</div>
   	</div>
   	<!-- 分页信息 -->
   	<div class="row">
   		<!-- 分页文字信息 -->
   		<div class="col-xs-6">
   			当前第${pageInfo.pageNum }页，总${pageInfo.pages }页，总${pageInfo.total}条记录
   		</div>
   		<!-- 分页条信息 -->
   		<div class="col-xs-6">
	   		<nav aria-label="Page navigation">
			  <ul class="pagination">
			  		<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
			  		<c:if test="${pageInfo.hasPreviousPage }">
			  		 <li>
			  			<a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous">
				       		 <span aria-hidden="true">&laquo;</span>
				     	 </a>
				      </li>
			  		</c:if>
				    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
				    	<c:if test="${page_Num == pageInfo.pageNum }">
				    		<li class="active"><a href="#">${page_Num }</a></li>
				    	</c:if>
				    	<c:if test="${page_Num != pageInfo.pageNum }">
				    		<li><a href="${APP_PATH}/emps?pn=${page_Num }">${page_Num }</a></li>
				    	</c:if>
				    	
				    </c:forEach>
				    
				    
			    	<c:if test="${pageInfo.hasNextPage }">
			    		<li>
					      <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
				    	</li>
			    	</c:if>
			    	<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
			  </ul>
			</nav>
   		</div>
   	</div>
   </div>
   
  </body>
</html>
