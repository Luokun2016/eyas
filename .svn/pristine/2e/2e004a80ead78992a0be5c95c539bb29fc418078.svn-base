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
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">教师结题报告查询</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}conclusion/select" method="post"
			class="search-form form-inline">
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <select
							name="batchId" class="form-control input-sm">
							<option value="-1" ${batchId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${batchList}" var="bat">
								<option value="${bat.batch_id}"
									${batchId==bat.batch_id?"selected='selected'":"" }>${bat.batch_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">项目名称</span> <select
							name="projectId" class="form-control input-sm">
							<option value="-1" ${projectId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${projectList}" var="bat">
								<option value="${bat.project_id}"
									${projectId==bat.project_id?"selected='selected'":"" }>${bat.project_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">承担单位</span> <select
							name="schoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${schoolList}" var="bat">
								<option value="${bat.school_id}"
									${schoolId==bat.school_id?"selected='selected'":"" }>${bat.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">审核状态</span> <select
							name="checkStatus" class="form-control input-sm">
							<option value="-1" ${checkStatus==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${checkStatus==0?"selected='selected'":"" }>未审核</option>
							<option value="1" ${checkStatus==1?"selected='selected'":"" }>高校审核未通过</option>
							<option value="2" ${checkStatus==2?"selected='selected'":"" }>高校审核通过</option>
							<option value="3" ${checkStatus==3?"selected='selected'":"" }>创新学院未通过</option>
							<option value="4" ${checkStatus==4?"selected='selected'":"" }>创新学院通过</option>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">题目搜索</span> <input
							type="text" name="keyWord" class="form-control input-sm"
							value="${keyWord}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">负责人</span> <input
							type="text" name="leaderName" class="form-control input-sm"
							value="${leaderName}" />
					</div>
				</div>
				<div class="col-md-3 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search">查询</span>
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
					<th>批次名称</th>
					<th>项目名称</th>
					<th>项目负责人</th>
					<th>单位</th>
					<th>结题报告名称</th>
					<th>审核状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.batch_name}</td>
						<td>${data.project_name}</td>
						<td>${data.name}</td>
						<td>${data.school_name}</td>
						<td>${data.conclusion_name}</td>
						<td><c:if test="${data.conclusion_status==0}">未审核</c:if> <c:if
								test="${data.conclusion_status==1}">
								高校审核未通过
							</c:if> <c:if test="${data.conclusion_status==2}">
								高校审核通过
							</c:if> <c:if test="${data.conclusion_status==3}">
								创新学院审核未通过
							</c:if> <c:if test="${data.conclusion_status==4}">
								创新学院审核通过
							</c:if></td>
						<td> <a
							href="${base}conclusion/selectViewC?conclusion_id=${data.conclusion_id}"
							class="tablelink">查看</a></td>
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