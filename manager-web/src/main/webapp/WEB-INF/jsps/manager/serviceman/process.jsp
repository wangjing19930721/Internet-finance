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
				pageContext.setAttribute("navinfo", "流程管理");
				//设置点击高亮效果
				pageContext.setAttribute("curUrl", "servicectrl/prod/list");
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
										<th width="30">流程id</th>
										<th>流程名</th>
										<th>流程的key</th>
										<th>版本</th>
										<!-- 能看流程图片 -->
										<th width="100">操作</th>
									</tr>
								</thead>
								<tbody>
									<!-- <img src="" style="display: none"/> -->
								</tbody>
								<tfoot>
									<tr>
										<td id="pageBar_td" colspan="5" align="center"></td>
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
					<h4 class="modal-title" id="myModalLabel">添加流程定义文件</h4>
				</div>
				<div class="modal-body">
					<form action="${ctp }/servicectrl/ads/upload" id="ad_form"
						method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label>流程名</label> <input type="text" class="form-control"
								id="ad_name_input" name="processName" placeholder="流程名">
						</div>
						<div class="form-group">
							<label>选择流程文件</label> 
							<input type="file" name="processfile" id="ad_file_input">
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
		
		//获取所有广告在页面显示
		function getAllProcess(pn) {
			$.ajax({
				url : "${ctp}/servicectrl/prod/json",
				type : "get",
				data : "pn=" + pn,
				beforeSend : function() {
					index = layer.load();
				},
				success : function(result) {
					console.log(result);
					//显示数据到页面上
					showProcessToTable($("#adsTable"), result)
					//显示分页条数据
					//buildPageLi(result);
					//关闭
					layer.close(index);
				}
			});
		}
		//构建每行tr
		function showProcessToTable(tabEle, data) {
			//显示之前先移除之前的数据
			tabEle.find("tbody").empty();
			//表单中写数据；
			$.each(data,function() {
								var tr = $("<tr></tr>").append(
										"<td>" + this.id + "</td>").append(
										"<td>" + this.name + "</td>").append(
										"<td>" + this.key + "</td>")
										.append("<td>" + this.version + "</td>");

								var showImg = $("<button type='button' url='"+this.id+"' class='btn btn-success btn-xs showimg'><i class='glyphicon glyphicon-eye-open'></i></button>")
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
			var pid = $(this).attr("url");
			
			
			layer.open({
				type : 1,
				skin : 'layui-layer-rim', //加上边框
				area : [ '600px', '400px' ], //宽高
				//用js插件；
				content : "<img style='height:300px;width:380px;' src='${ctp}/servicectrl/prod/process.jpg?pid="+pid+"'/>"
			});
		})

		/* function showImgFuntion(){
			alert("Nihao");
		} */
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
			getAllProcess(1);
		});
		//应该展示数据之前有一个等待操作；

		//点击新增弹出广告添加的模态框
		$("#adAdd_btn").click(function() {
			$("#ad_add_model").find(".imgdiv").empty();
			$("#ad_add_model").modal("show");
		});

		//广告新增
		$("#submitBtn").click(function() {
			var fd = new FormData();
			//添加一项要提交的内容；使用append即可
			fd.append("name", $("#ad_name_input").val());
			fd.append("processfile", $("#ad_file_input")[0].files[0])
			$.ajax({
				url : "${ctp }/servicectrl/prod/upload",
				type : "post",
				//data:new FormData($("#ad_form")[0]),
				data : fd,
				processData : false,//告诉ajax不要处理和编码这些数据，直接提交
				contentType : false,//不使用默认的内容类型
				success : function(result) {
					layer.msg(result);
					//异步的，所以应该成功以后再去查询，否则就经常查不到东西
					//3、刷新list页面；初始化页面显示；新增显示最后一页
					getAllProcess(99999);

				},
				error : function(e) {
					layer.msg(e);
				}
			});
			
			//2、关闭模态框
			$("#ad_add_model").modal("hide");
			
		});
	</script>
</body>
</html>
