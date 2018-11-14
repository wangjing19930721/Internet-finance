﻿<%@page import="com.atguigu.scw.manager.constant.Constants"%>
<%@page import="com.atguigu.scw.manager.bean.TUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Cookie[] cookies =  request.getCookies();
	
	if(cookies!=null&&cookies.length>0){
	  //增强for容器在数组为null的时候抛异常
	  	for(Cookie c:cookies){
	  	    if(c.getName().equals("autologin")){
	  	        //说明用户携带了自动登录的令牌
	  	        //直接进行登陆操作；
	  	        //先去查缓存库是否有自动登录的这个用户；以application域为缓存的
	  	        //先查缓存，再查数据库，
	  	        //如果查到了就自动登录，没查到什么都不要做！
	  	        TUser user =  (TUser)application.getAttribute(c.getValue());
	  	        //1、查到以后放在session中
	  	        if(user!=null){
	  	          	//放在session中
		  	        session.setAttribute(Constants.LOGIN_USER, user);
		  	    	//如果没有再去查询数据库
		  	        //查出用户放在session中，再直接跳转到main.html
		  	        response.sendRedirect(request.getContextPath()+"/main.html");
		  	    	
		  	    	//为什么要加？
		  	    	return;
	  	        }
	  	    }
	  	}
	}
		
%>
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
						style="font-size: 32px;">尚筹网-创意产品众筹平台</a>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<form class="form-signin" role="form"
			action="${ctp }/permission/user/login" method="post">
			<h2 class="form-signin-heading">
				<i class="glyphicon glyphicon-log-in"></i> 用户登录
			</h2>
			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control" name="loginacct"
					id="loginacct_input" value="${errorUser.loginacct }"
					placeholder="请输入登录账号" autofocus> <span
					class="glyphicon glyphicon-user form-control-feedback"></span> <span
					style="color: red;">${msg }</span>
				<!-- 取出一次就将session中的这个属性移除 -->
				<!-- 
			     var="msg"：指定要从域中移除的key
				 scope=""：指定从哪个域中移除，不写默认会从所有域中移除 -->
				<c:remove var="msg" />
				<c:remove var="errorUser" />
			</div>
			<div class="form-group has-success has-feedback">
				<input type="text" class="form-control" name="userpswd"
					id="userpswd_input" placeholder="请输入登录密码" style="margin-top: 10px;">
				<span class="glyphicon glyphicon-lock form-control-feedback"></span>
			</div>
			<div class="form-group has-success has-feedback">
				<select class="form-control">
					<option value="manager" selected="selected">管理</option>
				</select>
			</div>
			<div class="checkbox">
				<label> <input type="checkbox" name="rememberme" value="1">
					记住我
				</label> <br> <label><a href="${ctp }/topswpage.html">忘记密码
				</a> </label> <label style="float: right"> <a href="${ctp}/reg.jsp">我要注册</a>
				</label>
			</div>
			<a class="btn btn-lg btn-success btn-block" onclick="dologin()">
				登录</a>
		</form>
	</div>

	<%@include file="/WEB-INF/includes/js-file.jsp"%>

	<script>
		function dologin() {
			var type = $(":selected").val();
			if (type == "manager") {
				//管理员登陆
				$("form:first").submit();

			} else {
				//超链接跳转到指定的地址
				window.location.href = "${ctp}/index.jsp";
			}

			return false;
		}
	</script>
</body>
</html>