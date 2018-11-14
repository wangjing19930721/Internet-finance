<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
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

input[type=checkbox] {
	width: 18px;
	height: 18px;
}
</style>
</head>

<body>

	<%
	    //设置导航条上的显示
				pageContext.setAttribute("navinfo", "分类管理");
				//设置点击高亮效果
				pageContext.setAttribute("curUrl", "servicectrl/type/ctrl");
	%>
	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">
							<i class="glyphicon glyphicon-th"></i> 数据矩阵
						</h3>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table  table-bordered">
								<thead>
									<tr>
										<th>名称</th>
										<c:forEach items="${types }" var="type">
											<th>${ type}</th>
										</c:forEach>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${certs }" var="cert" varStatus="vs">
										<tr>
											<td>${cert.name }</td>
											<c:forEach items="${types }" var="type" varStatus="vs2">
												<td>
													${vs.index }-${vs2.index }
													<!-- 取出二维数组中这个坐标的值，如果是true加上checked -->
													<input type="checkbox" cid="${cert.id }" tname="${type }" ${relations[vs.index][vs2.index] == true?"checked":""}/>
												</td>
											</c:forEach>
											
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


	<%@include file="/WEB-INF/includes/js-file.jsp"%>
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
	</script>
</body>
</html>
