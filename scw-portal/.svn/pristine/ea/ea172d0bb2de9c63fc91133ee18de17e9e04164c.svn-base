<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form role="form" class="submitForm" style="margin-top: 20px;">
	<div class="form-group">
		<span style="color: red;">${msg }</span>
		<label for="exampleInputEmail1">邮箱地址</label> 
		<input type="text" name="email" value="${loginUser.email }" class="form-control" id="exampleInputEmail1"
			placeholder="请输入用于接收验证码的邮箱地址">
	</div>
	<button type="button"
		url="${ctp}/auth/apply-1.html"
		class="btn btn-default unusebtn">上一步</button>
	<button type="button"
		url="${ctp}/auth/apply-3.html"
		class="btn btn-success unusebtn">下一步</button>
		
	<button style="display: none;" class="btn btn-default unusebtn" url="${ctp}/auth/apply-2.html"></button>
</form>