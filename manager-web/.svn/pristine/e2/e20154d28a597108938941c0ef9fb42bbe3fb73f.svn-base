<%@page import="com.atguigu.scw.manager.constant.Constants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="col-sm-3 col-md-2 sidebar">
	<div class="tree">
		<ul style="padding-left: 0px;" class="list-group">
			<li class="list-group-item tree-closed"><a href="${ctp }/main.html"><i
					class="glyphicon glyphicon-dashboard"></i> 控制面板</a></li>
			<!-- 遍历菜单 -->
			<c:forEach items="<%=session.getAttribute(Constants.USER_MENUS) %>" var="p_menu">
				<li class="list-group-item tree-closed"><span>
					<i class="${p_menu.icon }"></i> ${p_menu.name } 
						<span class="badge" style="float: right">${fn:length(p_menu.childs)}</span></span>
					<ul style="margin-top: 10px; display: none;">
					<c:forEach items="${p_menu.childs}" var="c_menu">
						<li style="height: 30px;"><a href="${ctp }/${c_menu.url }"><i
								class="${c_menu.icon }"></i> ${c_menu.name }</a></li>
					</c:forEach>
					</ul>
				</li>
			
			</c:forEach>
		</ul>
	</div>
</div>