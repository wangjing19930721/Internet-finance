<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<form role="form" class="submitForm" style="margin-top: 20px;">
	<div class="form-group">
		<label for="exampleInputEmail1">真实名称</label> 
		<input type="text" name="realname" value="${auth_info.realname }"
			class="form-control"  
			id="exampleInputEmail1" placeholder="请输入真实名称">
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">身份证号码</label> 
		<input type="text" name="cardnum" class="form-control" 
			id="exampleInputPassword1" value="${auth_info.cardnum }"
			placeholder="请输入身份证号码">
	</div>
	<div class="form-group">
		<label for="exampleInputPassword1">电话号码</label> 
		<input type="text" class="form-control" 
			id="exampleInputPassword1" placeholder="请输入电话号码">
	</div>
	<!-- 上一步是来到账户选择页面 -->
	<button type="button"
		url="${ctp}/member/auth.html"
		class="btn btn-default unusebtn">上一步</button>
	<!-- 下一步是来到资质文件上传页面 -->
	<button type="button" style="display: none"
		url="${ctp}/auth/apply.html"
		class="btn btn-success unusebtn"></button>
		
	<button type="button"
		url="${ctp}/auth/apply-1.html"
		class="btn btn-success unusebtn">下一步</button>
</form>
