<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="keys" content="">
<meta name="author" content="">
<%@include file="/WEB-INF/includes/css-file.jsp"%>
<link rel="stylesheet" href="${ctp}/css/login.css">
</head>
<body>
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" href="${ctp}/index.html"
						style="font-size: 32px;">尚筹网-重置密码</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form class="form-signin" id="resetForm" role="form"
			action="${ctp }/updatepwd" method="post">
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 重置密码
			</h2>
			<input type="hidden" name="token" value="${param.token }"/>
			<div class="form-group has-success has-feedback">
				<input type="password" class="form-control" name="password"
					id="password_input"
					placeholder="请输入新密码" autofocus> 
			</div>
			<div class="form-group has-success has-feedback">
				<input type="password" class="form-control" name="repassword"
					id="password_input2" placeholder="再次确认密码" style="margin-top: 10px;">
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<a class="btn btn-lg btn-success btn-block resetBtn">确认重置</a>
		</form>
	</div>

	<%@include file="/WEB-INF/includes/js-file.jsp"%>

	<script>
		$(".resetBtn").click(function(){
			//0、表单校验（jquery.validation插件）
			//1、提交重置表单
			$("#resetForm").submit();
			return false;
		});
	</script>
</body>
</html>