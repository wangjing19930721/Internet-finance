<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<style>
</style>
</head>
<body> 
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<div>
					<a class="navbar-brand" href="index.html" style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form id="regForm" class="form-signin" role="form"
			action="${ctp }/permission/user/reg" method="post">
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 用户注册
			</h2>
			<div class="form-group has-success has-feedback">
				<input type="text" name="loginacct" class="form-control"
					id="loginacct_input" placeholder="请输入登录账号" value="${TUser.loginacct }" autofocus> 
				<span
					class="glyphicon glyphicon-user form-control-feedback"> </span>
				<span class="errorinfo" style="color: red"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="password" name="userpswd" class="form-control"
					id="userpswd_input" placeholder="请输入登录密码" style="margin-top: 10px;">
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				<span class="errorinfo" style="color: red"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control" name="email" value="${TUser.email }"
					id="email_input" placeholder="请输入邮箱地址" style="margin-top: 10px;">
				<span
					class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
				<span class="errorinfo" style="color: red"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<select class="form-control">
					<option>会员</option>
					<option>管理</option>
				</select>
			</div>
			<div class="checkbox">
				<label> 忘记密码 </label> <label style="float: right"> <a
					href="${ctp }/login.jsp">我有账号</a>
				</label>
			</div>
			<a id="submitBtn" class="btn btn-lg btn-success btn-block"> 注册</a>
		</form>
	</div>
	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	<script type="text/javascript">
		//给校验器设置一些策略
		$.validator.setDefaults({
			showErrors:function(map, list) {
				//console.log(map);
				//console.log(list);
				//将每个元素自己的错误信息显示在自己的图标下
				//先清除所有错误；清状态
				$(".errorinfo").empty();
				$(".form-group").removeClass("has-success has-error has-warning")
				
				$.each(list,function(){
					//当前发生错误的详细信息；
					//element当前错误元素
					//错误信息
					$(this.element).nextAll(".errorinfo").text(this.message);
					//改变input的状态；
					$(this.element).parent("div.form-group").addClass("has-error")
					
					
				})
			}
		});

		$("#submitBtn").click(function() {
			
			var loginType = $("select.form-control").val();
			//
			if(loginType == "管理"){
				$("#regForm").submit();
			}else{
				alert("此功能尚未开通");
			}
			
			return false;
		});

		$("#regForm").validate({
			rules : {
				loginacct : {
					required : true,
					minlength : 6
				},
				userpswd : {
					required : true,
					minlength : 6
				},
				email : {
					required : true,
					email : true
				}
			},
			messages : {
				loginacct : {
					required : "用户的登陆账号是必须的",
					minlength : "登陆账号必须是6位以上"
				},
				userpswd : {
					required : "请填写密码",
					minlength : "密码必须在6位以上"
				},
				email : {
					required : "邮箱必须填写",
					email : "请输入正确的邮箱格式"
				}
			}
		});
	</script>
</body>
</html>