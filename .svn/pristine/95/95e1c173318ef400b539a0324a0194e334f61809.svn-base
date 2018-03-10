<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<!DOCTYPE html>
	<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
	<div class="pull-right backbtn">
			<a href="${base}project/teamCheck">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">组队审核</a></li>
			<li><a href="#">组队详情</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/txTeamCheckDetailView" method="post"
			class="search-form form-inline">
			<input type="hidden" name="project_id" value="${projectId}">
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <input
							type="text" name="batchName" class="form-control input-sm"
							value="${projectApply.batch_name}"/>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">项目名称</span> <input
							type="text" name="projectName" class="form-control input-sm"
							value="${projectApply.project_name}"/>
					</div>
				</div>

				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学科分类</span><input
							type="text" name="subjectName" class="form-control input-sm"
							value="${projectApply.subject_name}"/>
					</div>
				</div>
				
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">中学指导老师</span>
						<input
							type="text" name="teacherName" class="form-control input-sm"
							value="${teacher.name}"/>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">用户名</span> <input
							type="text" name="stuUserName" class="form-control input-sm"
							value="${stuUserName}"/>
					</div>
				</div>

				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学生姓名</span><input
							type="text" name="stuName" class="form-control input-sm"
							value="${stuName}"/>
					</div>
				</div>
				<div class="col-md-6 margin5 ">
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
					<th>用户名</th>
					<th>姓名</th>
					<th>性别</th>
					<th>班级</th>
					<th>学生来源</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.user_name}</td>
						<td>${data.name}</td>
						<td>${data.sex==0?"女":"男"}</td>
						<td></td>
						<td>${data.source==0?"报名":"调剂"}</td>
						<td width="150"><a
							href="${base}project/txTeamStudentView?user_id=${data.user_id}"
							class="tablelink">详情</a></td>					
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