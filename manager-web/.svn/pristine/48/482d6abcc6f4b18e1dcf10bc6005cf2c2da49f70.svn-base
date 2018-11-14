<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<a class="navbar-brand" href="${ctp}/index.jsp"
						style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form class="form-signin" role="form" action="${ctp }/sendemail" method="post">
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 填写注册时的邮箱
			</h2>
			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control"  name="email"
				id="email_input" placeholder="输入邮箱" autofocus> 
				<span class="glyphicon glyphicon-user form-control-feedback"></span>
			</div>
			<a class="btn btn-lg btn-success btn-block">确定</a>
		</form>
	</div>

	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	<script type="text/javascript">
		// 用jqeury.validation插件校验email的合法性
		$("a.btn-success").click(function(){
			$(".form-signin").submit();
		});
	
	</script>
	
</body>
</html>