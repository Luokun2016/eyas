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
			<li><a href="#">新闻管理</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<!-- 搜索、添加 -->
		<form action="${base}news" method="post"
			class="search-form form-inline">
			<div class="row">
				<div class="col-md-4 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">搜索</span> <input
							type="text" name="keyWord" class="form-control input-sm"
							value="${keyWord}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">新闻类别</span> 
						<select name="news_type" class="form-control input-sm" >
							<option value="-1" ${news_type=="-1"?"selected='selected'":"" }>全部</option>
							<c:forEach items="${typeList}" var="list">
								<option value="${list.news_type_id }" ${news_type==list.news_type_id?"selected='selected'":"" }>${list.news_type_name }</option>
							</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="JCGL_XWGL_ADDINIT" href="${base}news/add"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>发布新闻</a>
				</div>
			</div>
		</form>

		<div class="formtitle">
			<span>信息列表</span>
		</div>
		<table id="example" class="tablelist">
			<thead>
				<tr>
					<th width="400">标题</th>
					<th width="100">类型</th>
					<th width="150">时间</th>
					<th width="150">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index"></c:set>
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td><a href="${base}news/show?news_id=${data.news_id}">${data.title}</a></td>
						<td>${data.news_type_name}</td>
						<td>${data.publish_time}</td>
						<td>
							<a pm="JCGL_XWGL_VIEW" href="${base}news/show?news_id=${data.news_id}" class="tablelink">查看</a>
							<a pm="JCGL_XWGL_EDITINIT" href="${base}news/edit?news_id=${data.news_id}" class="tablelink">修改</a>
							<a pm="JCGL_XWGL_DEL" href="${base}news/txDelNews?news_id=${data.news_id}" class="tablelink confirm">删除</a>
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