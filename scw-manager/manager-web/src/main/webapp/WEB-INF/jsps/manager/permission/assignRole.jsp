<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%@include file="/WEB-INF/includes/css-file.jsp" %>
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

    <%@include file="/WEB-INF/includes/nav-bar.jsp" %>
    <%
	//设置导航条上的显示
	pageContext.setAttribute("navinfo", "用户维护"); 
	//设置点击高亮效果
	pageContext.setAttribute("curUrl", "permission/user/list");
	%>

    <div class="container-fluid">
      <div class="row">
        <%@include file="/WEB-INF/includes/user_menu.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${ctp}/#">首页</a></li>
				  <li><a href="${ctp}/#">数据列表</a></li>
				  <li class="active">分配角色</li>
				</ol>
			<div class="panel panel-default">
			  <div class="panel-body">
				<form role="form" class="form-inline">
				  <div class="form-group">
					<label for="exampleInputPassword1">未分配角色列表</label><br>
					<select class="form-control unroles" multiple size="10" style="width:100px;overflow-y:auto;">
                        <c:forEach items="${unroles}" var="role">
                        	<option value="${role.id }">${role.name }</option>
                        </c:forEach>
                    </select>
				  </div>
				  <div class="form-group">
                        <ul>
                            <li class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                            <br>
                            <li class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                        </ul>
				  </div>
				  <div class="form-group" style="margin-left:40px;">
					<label for="exampleInputPassword1">已分配角色列表</label><br>
					<select class="form-control roles_select" multiple size="10" style="width:100px;overflow-y:auto;">
                        <c:forEach items="${roles }" var="role">
                        	<option value="${role.id }">${role.name }</option>
                        </c:forEach>
                    </select>
				  </div>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    <%@include file="/WEB-INF/includes/js-file.jsp" %>
    <!-- 动态显示页面高亮效果的js -->
	<%@include file="/WEB-INF/includes/common-js.jsp" %>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
            });
            
            
            
            $(".glyphicon-chevron-right").click(function(){
            	var rids = "";
            	$(".unroles :selected").each(function(){
            		rids+=$(this).val()+",";
            	});
            	rids = rids.substring(0,rids.length-1);
            	
            	//2、选中的得进行处理添加到权限中
            	//发送请求给当前用户添加这几个角色，必须带上权限id的拼串和userid
            	
            	var uid = "${param.uid}"
            	$.get("${ctp}/permission/user/assignrole?opt=add&uid="+uid+"&rids="+rids,function(data){
            		//1、选中的过去；分配成功以后过去
    				$(".unroles :selected").appendTo(".roles_select");  	
            		//alert("成功！");
            	})
            });
            
            $(".glyphicon-chevron-left").click(function(){
            	var uid = "${param.uid}";
            	var rids = "";
            	$(".roles_select :selected").each(function(){
            		rids+=$(this).val()+",";
            	});
            	rids = rids.substring(0,rids.length-1);
            	//0、发送请求移除
            	$.get("${ctp}/permission/user/assignrole?opt=remove&uid="+uid+"&rids="+rids,function(data){
            		//1、显示移除的效果；
            		$(".roles_select :selected").appendTo(".unroles");
            	})
            	
            	
            });
        </script>
  </body>
</html>
