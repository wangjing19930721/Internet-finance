<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<ul class="nav nav-tabs" role="tablist">
	<li role="presentation" class="active"><a href="${ctp}/auth/apply.html"><span
			class="badge">1</span> 基本信息</a></li>
	<li role="presentation"><a href="${ctp}/auth/apply-1.html"><span class="badge">2</span>
			资质文件上传</a></li>
	<li role="presentation"><a href="${ctp}/auth/apply-2.html"><span
			class="badge">3</span> 邮箱确认</a></li>
	<li role="presentation"><a href="${ctp}/auth/apply-3.html"><span class="badge">4</span>
			申请确认</a></li>
</ul>
<script>
	function currPageActive(pageTxt){
		$("a:contains('"+pageTxt+"')").css("color","red");
		$("a:contains('"+pageTxt+"')")
			.parents("li[role='presentation']")
			.addClass("active");
		//.siblings("li[role='presentation']").removeClass("active")			
		
	}
</script>