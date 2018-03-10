<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">基础管理</a></li>
			<li><a href="#">年级管理</a></li>
		</ul>
	</div>
<div class="rightinfo">
	<form action="${base}grade/gradeManage" method="post"
		class="search-form form-inline">
		<div class="formbody">			
			<div class="row">
			<input	type="hidden" name="schoolId" class="form-control input-sm" 
						value="${school.school_id}" readonly/>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学校名称</span>	
						<input	name="schoolName" class="form-control input-sm" 
						value="${school.school_name}" readonly/>						
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">年级名称</span> 
						<input name="grade_name" class="form-control input-sm" value="${grade_name}"/>						
					</div>
				</div>
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="JCGL_NJGL_ADDINIT" href="${base}grade/addGradeView?schoolId=${school.school_id}"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>添加年级</a>
				</div>
			</div>
		</div>
	</form>	
	<div class="formtitle">
		<span>年级信息</span>
	</div>	
	<table class="tablelist">
			<thead>
				<tr>
					<th>年级名称</th>
					<th>年级介绍</th>					
					<th>操作</th>					
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.grade_name}</td>						
						<td>${data.remark}</td>					
						<td>
						<a pm="JCGL_NJGL_EDITINIT" href="${base}grade/editGradeView?gradeId=${data.grade_id}"
						class="tablelink">修改</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a pm="JCGL_NJGL_DEL" href="${base}grade/txDeleteGrade?gradeId=${data.grade_id}"
						class="tablelink confirm">删除</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a pm="JCGL_NJGL_VIEW" href="${base}grade/showGradeView?gradeId=${data.grade_id}"
						class="tablelink">查看</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a pm="JCGL_NJGL_BJGL" href="${base}class/classManage?gradeId=${data.grade_id}"
						class="tablelink">班级管理</a>
						</td>
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