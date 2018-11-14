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
				pageContext.setAttribute("navinfo", "角色维护");
				//设置点击高亮效果
				pageContext.setAttribute("curUrl", "permission/role/list");
	%>
	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/includes/user_menu.jsp"%>

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据列表
						</h3>
					</div>
					<div class="panel-body">
						<form class="form-inline" role="form" style="float: left;">
							<div class="form-group has-feedback">
								<div class="input-group">
									<div class="input-group-addon">查询条件</div>
									<input class="form-control has-success" type="text"
										placeholder="请输入查询条件">
								</div>
							</div>
							<button type="button" class="btn btn-warning">
								<i class="glyphicon glyphicon-search"></i> 查询
							</button>
						</form>
						<button type="button" class="btn btn-danger"
							style="float: right; margin-left: 10px;">
							<i class=" glyphicon glyphicon-remove"></i> 删除
						</button>
						<button type="button" class="btn btn-primary"
							style="float: right;" onclick="window.location.href='form.html'">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th width="30"><input type="checkbox"></th>
										<th>名称</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${role_info.list }" var="role">
										<tr>
											<td>${role.id }</td>
											<td><input type="checkbox"></td>
											<td>${role.name }</td>
											<td>
												<button type="button" rid="${role.id }"
													class="btn btn-success btn-xs assignPermissionModelBtn">
													<i class=" glyphicon glyphicon-check"></i>
												</button>
												<button type="button" class="btn btn-primary btn-xs">
													<i class=" glyphicon glyphicon-pencil"></i>
												</button>
												<button type="button" class="btn btn-danger btn-xs">
													<i class=" glyphicon glyphicon-remove"></i>
												</button>
											</td>
										</tr>
									</c:forEach>

								</tbody>
								<tfoot>
									<tr>
										<td colspan="6" align="center">
											<ul class="pagination">
												<!-- 即使点击分页连接也应该带上查询条件的值 -->
												<!-- 给分页超链接绑定单击事件； -->
												<li><a href="${ctp}/permission/role/list?pn=1">首页</a></li>
												<c:if test="${role_info.hasPreviousPage}">
													<li><a
														href="${ctp}/permission/role/list?pn=${role_info.prePage}">上一页</a></li>
												</c:if>

												<!-- 遍历连续显示的页面 navigatepageNums : int[]-->
												<c:forEach items="${role_info.navigatepageNums}" var="pn">
													<c:if test="${pn == role_info.pageNum }">
														<li class="active"><a
															href="${ctp}/permission/role/list?pn=${pn}">${pn } <span
																class="sr-only">(current)</span></a></li>
													</c:if>
													<c:if test="${pn != role_info.pageNum }">
														<li><a href="${ctp}/permission/role/list?pn=${pn}">${pn }</a></li>
													</c:if>
												</c:forEach>

												<c:if test="${role_info.hasNextPage}">
													<li><a
														href="${ctp}/permission/role/list?pn=${role_info.nextPage}">下一页</a></li>
												</c:if>
												<li><a
													href="${ctp}/permission/role/list?pn=${role_info.pages}">末页</a></li>
											</ul>
										</td>
									</tr>

								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 模态框 -->
	<div class="modal fade" id="permissModel" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配权限</h4>
				</div>
				<div class="modal-body">
					<!-- 展示权限树 -->
					<div>
						<ul id="permissionTree" class="ztree"></ul>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="addPermissionBtn">分配权限</button>
				</div>
			</div>
		</div>
	</div>

	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	<!-- 动态显示页面高亮效果的js -->
	<%@include file="/WEB-INF/includes/common-js.jsp"%>
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
	
		//保存ztree对象的
		var ztreeObject;
		//用户角色分配权限-
		//点击按钮-打开模态框-查出所有的权限-在模态框中树形显示-将当前用户拥有的权限选中
		/* $("tbody .btn-success").click(function() {
			window.location.href = "assignPermission.html";
		}); */
		//点击分配权限按钮，
		//模态框的按钮
		$("#addPermissionBtn").click(function(){
			//1、获取当前我们已经选中的权限
			var nodes = ztreeObject.getCheckedNodes(true);
			//2、将这些权限的id和角色的id发给程序
			var permission_ids = "";
			$.each(nodes,function(){
				permission_ids += this.id+",";
			});
			var rid = $(this).attr("rid");
			//3、使用程序保存这个角色对应的权限的值
			//写程序；删除对应的东西即可
			$.get("${ctp}/permission/role/update?pids="+permission_ids+"&rid="+rid,function(){
				alert("权限分配成功");
				$('#permissModel').modal("hide");
			})
		});
		
		$(".assignPermissionModelBtn").click(function() {
			var options = {
				backdrop : 'static',
				show : true
			}

			//"permissionTree"刷出权限树
			//js的this会经常飘逸
			initPermissionTree($(this).attr("rid"));
			//getUser(1)
			//勾选当前角色的权限
			//打开模态框
			$('#permissModel').modal(options);
			//将角色id保存到模态框的哪个属性中；
			//打开模态框将角色id传递给model里面的权限分配按钮
			$('#addPermissionBtn').attr("rid",$(this).attr("rid"));
		});

		//treeId：是权限树ul的id
		//treeNode：当前节点信息
		function showIcon(treeId, treeNode) {
			//console.log(treeId);
			//treeNode里面有一个tId；
			//这个tid用来拼串以后就是图标显示位置的元素id和名字显示位置的元素id
			//tId:"permissionTree_3"
			//<span id="permissionTree_2_span">用户维护</span>
			//<span id="permissionTree_2_ico" ></span>
			//console.log(treeNode);
			//改图标；找到当前元素图标显示的节点，将这个节点的class设置为当前节点的icon
			$("#" + treeNode.tId + "_ico").removeClass()
					.addClass(treeNode.icon);
		}

		///传入角色id，将当前角色拥有的权限勾选
		function checkcurPermisson(rid) {
			//   /permission/role/perm/4
			$.getJSON("${ctp}/permission/role/perm/" + rid, function(data) {
				//查出的当前角色拥有的权限
				//ztree对象的方法；checkNode；
				//三个参数：
				//第一个参数就是要勾选的节点
				//第二个参数就是勾选与否
				//第三个参数是是否和父节点级联互动
				//第四个参数是勾选状态变化后，是否调用之前用（callback）规定的回调函数
				$.each(data, function() {
					//console.log(this);
					//从ztree中获取到要勾选的对象；
					var node = ztreeObject.getNodeByParam("id", this.id, null);
					ztreeObject.checkNode(node, true, false);
				})
			})
		}

		function initPermissionTree(rid) {
			var setting = {
				data : {
					simpleData : {
						enable : true,
						idKey : "id",
						pIdKey : "pid",
					},
					key : {
						url : "haha"
					}
				},
				view : {
					//自定义显示的效果
					addDiyDom : showIcon
				},
				check : {
					enable : true
				}
			};

			//从数据库查出的所有权限节点数据
			//发送ajax请求获取到所有权限的json数据
			$.getJSON("${ctp}/permission/role/json", function(nodes) {
				//console.log(nodes);
				//给每一个节点修改或者添加一些属性
				$.each(nodes, function() {
					if (this.pid == 0) {
						this.open = true;
					}
				})
				//如果不是用var声明的变量，这个变量就默认变为全局的
				//把初始化好的ztree对象传递给外界使用，可以通用操作这个对象，来改变树
				//ztree为了不影响下面的操作是异步展示数据的
				ztreeObject = $.fn.zTree.init($("#permissionTree"), setting,
						nodes);
				checkcurPermisson(rid);
			})
		}
	</script>
</body>
</html>
