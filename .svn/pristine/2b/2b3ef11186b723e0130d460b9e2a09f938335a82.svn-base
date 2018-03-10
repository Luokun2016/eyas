<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<cqu:right>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}project/release">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">反馈学校信息</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/txReleaseSchoolView" method="post"
			class="search-form form-inline">
			<input type="hidden" name="project_id" id="project_id" value="${project_id}"/>
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">中学名称</span> <input
							type="text" name="schoolName" class="form-control input-sm"
							value="${schoolName}" />
					</div>
				</div>
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>信息列表</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>学校名称</th>
					<th>学校类别</th>
					<th>负责人</th>
					<th>联系方式</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.school_name}</td>
						<c:if test="${data.school_type==0}">
							<td>高校</td>	
						</c:if>
						<c:if test="${data.school_type==1}">
							<td>中学</td>	
						</c:if>  
						<td>${data.manager}</td>
						<td>${data.phone}</td>
					</tr>
				</c:forEach>
				<c:if test="${index==0}">
					<tr>
						<td colspan="100">没有找到数据！</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<jsp:include page="../common/paginate.jsp"></jsp:include>
	</div>
</body>
</html>
</cqu:right>