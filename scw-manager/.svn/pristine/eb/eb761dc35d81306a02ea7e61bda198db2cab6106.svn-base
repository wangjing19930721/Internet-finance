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
				pageContext.setAttribute("navinfo", "广告管理");
				//设置点击高亮效果
				pageContext.setAttribute("curUrl", "servicectrl/ads/list");
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
						<button type="button" id="adAdd_btn" class="btn btn-primary"
							style="float: right;">
							<i class="glyphicon glyphicon-plus"></i> 新增
						</button>
						<br>
						<hr style="clear: both;">
						<div class="table-responsive">
							<table id="adsTable" class="table  table-bordered">
								<thead>
									<tr>
										<th width="30">#</th>
										<th>广告描述</th>
										<th>状态</th>
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- <img src="" style="display: none"/> -->
								</tbody>
								<tfoot>
									<tr>
										<td id="pageBar_td" colspan="4" align="center"></td>
									</tr>

								</tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	<%@include file="/WEB-INF/includes/common-js.jsp"%>
	<!-- 广告添加的模态框 -->
	<div class="modal fade" id="ad_add_model" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加广告</h4>
				</div>
				<div class="modal-body">
					<form action="${ctp }/servicectrl/ads/upload" id="ad_form"
						method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>广告名</label> <input type="text" class="form-control"
								id="ad_name_input" name="name" placeholder="广告名">
						</div>
						<div class="form-group">
							<label>选择广告</label> 
							<input type="file" name="ad" id="ad_file_input">
						</div>
						<div class="form-group">
							<!--选择的文件展示位  -->
							<div class="row">
								<div class="col-md-12 imgdiv">
								
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="submitBtn">确定</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var index;//layer提示框的索引
		//为文件选择项绑定事件；
		$("#ad_file_input").change(function(event){
			//alert("aa");
			//拿到图片项。进行显示
			//1、回调函数需要获取到事件对象
			//2、可以用事件对象得到很多信息
			var files = event.target.files; //this.files[0]
			var file;
			if(files && files.length>0){
				file = files[0];
			}
			//文件上传限制大小  提交表单的时候判断
			//if(file.size > 1024)
			//只允许图片 type:"image/jpeg"
			var reg = /image*/;
			if(!reg.test(file.type)){
				alert("请选择一个图片");
				//不是图片将val置空
				$("#ad_file_input").val("");
				return false;
			};
			
			var URL = window.URL || window.webkitURL;
			//创建一个临时的url地址
            var imgURL = URL.createObjectURL(file);
            
			$(this).parent(".form-group")
				.next(".form-group").find(".imgdiv")
				.append("<img src='"+imgURL+"' style='width:400px;height:240px;'/>");
			//console.log(file);
		});
		
		//获取所有广告在页面显示
		function getAllAdver(pn) {
			$.ajax({
				url : "${ctp}/servicectrl/ads/json",
				type : "get",
				data : "pn=" + pn,
				beforeSend : function() {
					index = layer.load();
				},
				success : function(result) {
					console.log(result);
					//显示数据到页面上
					showAdsToTable($("#adsTable"), result.list)
					//显示分页条数据
					buildPageLi(result);
					//关闭
					layer.close(index);
				}
			});
		}
		//构建每行tr
		function showAdsToTable(tabEle, data) {
			//显示之前先移除之前的数据
			tabEle.find("tbody").empty();
			//表单中写数据；
			$
					.each(
							data,
							function() {
								// 状态  0:未审核  1:审核成功  2:已发布(要发布到首页的) 3:已移除
								//删除分为逻辑删除和物理删除，业务逻辑中大多使用逻辑删除；
								//给某个每个记录添加一个状态字段表示；0：为删除  1：已删除

								var tr = $("<tr></tr>").append(
										"<td>" + this.id + "</td>").append(
										"<td>" + this.name + "</td>").append(
										"<td>" + this.status + "</td>");

								var showImg = $("<button type='button' url='"+this.url+"' class='btn btn-success btn-xs showimg'><i class='glyphicon glyphicon-eye-open'></i></button>")
								var editBtn = $("<button></button>")
										.attr({
											type : "button"
										})
										.addClass("btn btn-success btn-xs")
										.append(
												"<i class='glyphicon glyphicon-pencil'></i>");
								var delBtn = $("<button></button>").attr({
									type : "button"
								}).addClass("btn btn-success btn-xs").append(
										$("<i></i>").addClass(
												"glyphicon glyphicon-remove"));

								var btnTd = $("<td></td>").append(showImg)
										.append(" ").append(editBtn)
										.append(" ").append(delBtn);
								btnTd.appendTo(tr);
								//整个表格项构建完成；
								//showImg.click(showImgFuntion);

								tabEle.find("tbody").append(tr);
							})

		}

		/*为后来新增的元素绑定事件 */
		//on 选择器（元素的祖先元素）
		// 大元素.on(事件名,"元素选择器",回调函数)
		$("body").on("click", ".showimg", function() {
			//this
			//推荐使用bootstrap模态框弹出显示图片；可以自适应大小
			var url = $(this).attr("url");
			layer.open({
				type : 1,
				skin : 'layui-layer-rim', //加上边框
				area : [ '420px', '240px' ], //宽高
				content : "<img style='height:200px;width:400px;' src='${ctp}/"+url+"'/>"
			});
		})

		/* function showImgFuntion(){
			alert("Nihao");
		} */

		//构建分页条
		function buildPageLi(page) {
			var ulEle = $("<ul></ul>").addClass("pagination");
			//各种判断append
			//首页
			ulEle.append($("<li><a onclick='getAllAdver(1)'>首页</a></li>"));
			//上一页；都应该点击上一页发送ajax请求 
			if (page.hasPreviousPage) {
				ulEle.append($("<li><a onclick='getAllAdver(" + page.prePage
						+ ")'>上一页</a></li>"));
			} else {
				ulEle.append($("<li><a>上一页</a></li>").addClass("disabled"));
			}
			//构造连续页面
			var ns = page.navigatepageNums;
			$.each(ns, function() {
				//判断当前页要加class="active"
				if (page.pageNum == this) {
					ulEle.append($(
							"<li><a onclick='getAllAdver(" + this + ")'>"
									+ this + "</a></li>").addClass("active"));
				} else {
					ulEle.append($("<li><a onclick='getAllAdver(" + this
							+ ")'>" + this + "</a></li>"));
				}

			})

			//下一页
			if (page.hasNextPage) {
				ulEle.append($("<li><a onclick='getAllAdver(" + page.nextPage
						+ ")'>下一页</a></li>"));
			} else {
				ulEle.append($("<li><a>下一页</a></li>").addClass("disabled"));
			}

			//末页
			//首页
			ulEle.append($("<li><a onclick='getAllAdver(" + page.pages
					+ ")'>末页</a></li>"));

			$("#pageBar_td").empty().append(ulEle);

		}

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

			//页面加载完成就调用
			getAllAdver(1);
		});
		//应该展示数据之前有一个等待操作；

		//点击新增弹出广告添加的模态框
		$("#adAdd_btn").click(function() {
			$("#ad_add_model").find(".imgdiv").empty();
			$("#ad_add_model").modal("show");
		});

		//广告新增
		$("#submitBtn").click(function() {
			//1、提交表单.不是ajax提交表单；这就是点击提交按钮进行的页面跳转
			//$("#ad_form").submit();
			//如何使用ajax提交带文件上传的表单
			//1、使用formData（js对象来包装form表单）
			var fd = new FormData();
			//添加一项要提交的内容；使用append即可
			fd.append("name", $("#ad_name_input").val());
			fd.append("ad", $("#ad_file_input")[0].files[0])
			$.ajax({
				url : "${ctp }/servicectrl/ads/upload",
				type : "post",
				//data:new FormData($("#ad_form")[0]),
				data : fd,
				processData : false,//告诉ajax不要处理和编码这些数据，直接提交
				contentType : false,//不使用默认的内容类型
				success : function(result) {
					layer.msg(result);

				},
				error : function(e) {
					layer.msg(e);
				}
			});
			
			//2、关闭模态框
			$("#ad_add_model").modal("hide");
			//3、刷新list页面；初始化页面显示；新增显示最后一页
			getAllAdver(99999);
		});
	</script>
</body>
</html>
