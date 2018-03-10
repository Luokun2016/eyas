<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<cqu:right>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
  </head>
  <body>
  	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">基础数据</a></li>
			<li><a href="#">新闻与政策管理</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<div class="row">
			<div class="col-md-2 margin5 ">
				<a pm="JCGL_XWLBGL_ADDINIT" href="${base}news/addType"class="btn btn-default btn-sm">
					<span class="glyphicon glyphicon-plus"></span>新增类型
				</a>
			</div>
		</div>
		<div class="formtitle">
			<span>类型列表</span>
		</div>
		<table id="example" class="tablelist">
			<thead>
				<tr>
					<th width="50">ID</th>
					<th width="200">类型</th>
					<th width="150">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index"></c:set>
				<c:forEach items="${typeList}" var="list" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${list.news_type_id}</td>
						<td>${list.news_type_name}</td>
						<td>
							<a pm="JCGL_XWLBGL_EDITINIT" href="${base}news/editType?type_id=${list.news_type_id}" class="tablelink">修改</a>
							<a pm="JCGL_XWLBGL_DEL" href="${base}news/txDelType?type_id=${list.news_type_id}" class="tablelink">删除</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${index==0}">
					<tr>
						<td colspan="6">没有找到数据！</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<jsp:include page="../common/paginate.jsp"></jsp:include>
	</div>
</body>
</html>
</cqu:right>