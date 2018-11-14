<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<%@include file="/WEB-INF/includes/css-file.jsp"%>
<link rel="stylesheet" href="${ctp}/css/main.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>

<body>
	<%
	//设置导航条上的显示
	pageContext.setAttribute("navinfo", "实名认证审核"); 
	//设置点击高亮效果
	pageContext.setAttribute("curUrl", "audi/auth/list");
	%>
	<!--  引入navbar-->
	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<!--  引入菜单-->
			<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" 
							role="form" style="float: left;"
							action="${ctp }/permission/user/list" method="post">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" 
										type="text" name="sp"
										placeholder="用户账号/名查询" value="${sp}">
								</div>
							</div>
							<button type="submit" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger deleteAllBtn"
							style="float: right; margin-left: 10px;">
							<i class="glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='add.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30">
										<input id="checkall_btn" type="checkbox"></th>
										<th>申请的用户名</th>
										<th>实名</th>
										<th>身份证号</th>
										<th>邮箱</th>
										<th>资质图片</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${pageInfo }" var="infoMap">
										<tr>
										<td>${infoMap.taskId }</td>
										<td><input id="checkall_btn" type="checkbox"></th></td>
										<td>${infoMap.member.realname }</td>
										<td>${infoMap.member.cardnum }</td>
										<td>${infoMap.member.email}</td>
										<td>
											<button class="showImg" 
												imgurl="<c:forEach items="${infoMap.certs }" var="cert">${cert.iconpath },</c:forEach>">
												点击预览</button>
											<!-- 图片地址， -->
										</td>
										<td>
											<button class="audiBtn">审核</button>
										</td>
										</tr>
									</c:forEach>
								</tbody>
								
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/includes/js-file.jsp" %>
	<!-- 动态显示页面高亮效果的js -->
	<%@include file="/WEB-INF/includes/common-js.jsp" %>
	
	<script type="text/javascript">
		$(function() {
			$(".list-group-item").click(function() {
				if ($(this).find("ul")) {
					$(this).toggleClass("tree-closed");
					if ($(this).hasClass("tree-closed")) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
		});
		
		//当前页面所在的哪个超链接是color:red
		//他的父list-group-item.  tree-closed是没有的
		//找到当前页面的a连接
		//使用css为某个元素加样式  list-group-item
		//为所有分页连接绑定单击事件，让其动态的带上分页的查询参数
		$(".pagination").find("a").click(function(){
			//1、获取到查询表单的查询参数
			//不禁用默认行为，而是为超链接多拼装上查询条件
			//为超链接动态拼装查询条件
			var href = $(this).attr("href")+"&sp="+$("input[name='sp']").val();
			$(this).attr("href",href);
		});
		
		//这是调用了抽取过来的方法；
		checkall_reverse($("#checkall_btn"),$(".single_check"));
		$(".deleteAllBtn").click(function(){
			//点击删除按钮，先拿到我们要删除的所有员工的id
			var delUrl = "${ctp}/permission/user/del?pn=${user_info.pageNum}&ids="
			var ids = "";
			$(".single_check:checked").each(function(){
				//取出我们自定义的id属性
				ids += $(this).attr("del_id")+",";
			});
			//剔除最后一个逗号
			delUrl+=ids.substring(0,ids.length-1);
			//让浏览器访问这个删除链接
			if(confirm("确认删除【"+ids+"】这些员工吗?")){
				location.href = delUrl;
			}
			return false;
		});
		
		//点击权限分配来到权限分配页面；
		$(".assignBtn").click(function(){
			//必须将用户id带给后台
			var id = $(this).attr("u_id");
			//去权限列分配页面
			var url = "${ctp}/permission/user/toAssignRolePage?uid="+id;
			location.href=url;
		});
		
		$(".audiBtn").click(function(){
			
			if(confirm("确认审核吗？")){
				//审核成功；
				//点击确认；
				//1、从session中拿到当前用户，设置他的实名信息状态位为1；
				//2、领“人工审核”任务，并complete；
				//3、taskService.complete(taskId)；从页面带上taskid即可；
				
			}else{
				//拒绝此次实名认证信息
			}
		})
	</script>
	
</body>
</html>
