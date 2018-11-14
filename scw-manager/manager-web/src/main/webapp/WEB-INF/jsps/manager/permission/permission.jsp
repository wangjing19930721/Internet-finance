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
</style>
</head>

<body>

	<%@include file="/WEB-INF/includes/nav-bar.jsp"%>

	<div class="container-fluid">
		<div class="row">
			<%@include file="/WEB-INF/includes/user_menu.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="glyphicon glyphicon-th-list"></i> 权限菜单列表
						<div style="float: right; cursor: pointer;" data-toggle="modal"
							data-target="#myModal">
							<i class="glyphicon glyphicon-question-sign"></i>
						</div>
					</div>
					<div class="panel-body">
						<ul id="treeDemo" class="ztree"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">权限修改</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/includes/js-file.jsp"%>
	<script type="text/javascript">
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
		});

		
		var ztreeObject;

		//初始化权限树
		function initPermissionTree() {
			var setting = {
				data : {
					simpleData : {
						enable : true,
						idKey : "id",
						pIdKey : "pid",
					},
					key : {
						url : "haha"
					}
				},
				view : {
					addDiyDom : showIcon,
					addHoverDom: showEditBtn,
					removeHoverDom: hideEditBtn
				}
			};

			
			$.getJSON("${ctp}/permission/role/json", function(nodes) {
				$.each(nodes, function() {
					if (this.pid == 0) {
						this.open = true;
					}
				})
				ztreeObject = $.fn.zTree.init($("#treeDemo"), setting,
						nodes);
			})
		}

		//鼠标放在节点上显示编辑按钮
		function showEditBtn(treeId, treeNode){
			//treeId：ztree的id；=treeDemo
			//treeNode：当前的节点
			console.log(treeNode);
			//treeNode.tId+"_a"
			$("#"+treeNode.tId+"_a").nextAll("button").remove();
			//我们使用jquery创建出对象
			var editBtn = $("<button type='button' class='btn btn-primary btn-xs editBtn'> <span class='glyphicon glyphicon-align-left' aria-hidden='true'></span></button>")
			$("#"+treeNode.tId+"_a").after(editBtn);
			//并给这个对象绑定事件
			editBtn.click(showModel);
		}
		//鼠标移出节点移出几个编辑按钮
		function hideEditBtn(treeId, treeNode){
			$("#"+treeNode.tId+"_a").nextAll("button").remove();
		}
		//显示icon
		function showIcon(treeId, treeNode) {
			$("#" + treeNode.tId + "_ico").removeClass();
			$("#" + treeNode.tId + "_ico").before(
					"<span class='"+treeNode.icon+"'></span>");
		}
		$(function() {
			//初始化权限树
			initPermissionTree();
			//只能为当前页面已有的元素进行事件
			/* $(".editBtn").on("click","li",function(){
				alert("aa");
			}) */
		});
		function showModel(){
			$("#myModal").modal("show");
		}
		
	</script>
</body>
</html>
