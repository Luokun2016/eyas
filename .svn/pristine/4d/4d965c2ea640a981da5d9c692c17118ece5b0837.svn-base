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
			<li><a href="#">项目筛选与反馈</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/choose" method="post"
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
						<span class="input-group-addon input-sm">项目名称</span> <input
							type="text" name="projectName" class="form-control input-sm"
							value="${projectName}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">承担单位</span> <select
							name="schoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${schoolList}" var="sch">
								<option value="${sch.school_id}"
									${schoolId==sch.school_id?"selected='selected'":"" }>${sch.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp; <a pm="XMGL_XMSXGL_ADDINIT"
						href="${base}project/txChooseAddInitialize"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>新增</a>
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
					<th>承担单位</th>
					<th>项目负责人</th>
					<th>反馈时间</th>
					<th>是否被分配</th>
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
						<td>${data.school_name}</td>
						<td>${data.leader_name}</td>
						<td><fmt:formatDate value="${data.opt_date}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<c:if test="${data.assigned==0}">
							<td>否</td>
						</c:if>
						<c:if test="${data.assigned==1}">
							<td>是</td>
						</c:if>
						<td width="150"><c:if test="${data.submit_status<5}">
								<a pm="XMGL_XMSXGL_DEL"
									href="${base}project/txChooseProjectDel?feedback_id=${data.feedback_id}"
									class="tablelink confirm">删除</a>
							</c:if></td>
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