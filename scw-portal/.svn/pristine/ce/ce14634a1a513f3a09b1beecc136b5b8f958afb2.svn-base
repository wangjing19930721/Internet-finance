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
<link rel="stylesheet" href="${ctp}/css/theme.css">
<style>
#footer {
	padding: 15px 0;
	background: #fff;
	border-top: 1px solid #ddd;
	text-align: center;
}

.seltype {
	position: absolute;
	margin-top: 70px;
	margin-left: 10px;
	color: red;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1>实名认证 - 账户类型选择</h1>
		</div>
		<div style="padding-top: 10px;">
			<div class="row">
				<div class="col-xs-6 col-md-3">

					<h2>商业公司</h2>
					<!--  当前页面-->
					<a href="#" class="thumbnail" act_type="商业公司"> <img
						alt="100%x180" src="${ctp}/img/services-box1.jpg"
						data-holder-rendered="true"
						style="height: 180px; width: 100%; display: block;">
					</a>
				</div>
				<div class="col-xs-6 col-md-3">
					<h2>个体工商户</h2>
					<a href="#" class="thumbnail" act_type="个体工商户"> <img
						alt="100%x180" src="${ctp}/img/services-box2.jpg"
						data-holder-rendered="true"
						style="height: 180px; width: 100%; display: block;">
					</a>
				</div>
				<div class="col-xs-6 col-md-3">
					<h2>个人经营</h2>
					<a href="#" class="thumbnail" act_type="个人经营"> <img
						alt="100%x180" src="${ctp}/img/services-box3.jpg"
						data-holder-rendered="true"
						style="height: 180px; width: 100%; display: block;">
					</a>
				</div>
				<div class="col-xs-6 col-md-3">
					<h2>政府及非营利组织</h2>
					<a href="#" class="thumbnail" act_type="政府及非营利组织"> <img
						alt="100%x180" src="${ctp}/img/services-box4.jpg"
						data-holder-rendered="true"
						style="height: 180px; width: 100%; display: block;">
					</a>
				</div>
			</div>
			<button id="toauthpage_btn" type="button"
				class="btn btn-danger btn-lg btn-block"
				url="${ctp}/auth/authpage.html">认证申请</button>
		</div>
		<!-- /container -->
	</div>
	<div class="container" style="margin-top: 20px;">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div id="footer">
					<div class="footerNav">
						<a rel="nofollow" href="${ctp}/http://www.atguigu.com">关于我们</a> |
						<a rel="nofollow" href="${ctp}/http://www.atguigu.com">服务条款</a> |
						<a rel="nofollow" href="${ctp}/http://www.atguigu.com">免责声明</a> |
						<a rel="nofollow" href="${ctp}/http://www.atguigu.com">网站地图</a> |
						<a rel="nofollow" href="${ctp}/http://www.atguigu.com">联系我们</a>
					</div>
					<div class="copyRight">Copyright ?2017-2017atguigu.com 版权所有</div>
				</div>

			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	<script>
		$(".thumbnail")
				.click(
						function() {
							$('.seltype').remove();
							$(this)
									.prepend(
											'<div class="glyphicon glyphicon-ok seltype"></div>');
						});

		$("#toauthpage_btn").click(function() {
			//找到加了表示的a连接
			var aEle = $(".seltype").parent("a");
			var url = $(this).attr("url");
			if (aEle.length == 1) {
				url+= "?accttype="+aEle.attr("act_type");
				location.href=url;
			}else{
				layer.msg("请先选择账户类型哦！")
			}
			//发送请求；
			//
		});
	</script>
</body>
</html>