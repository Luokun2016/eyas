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
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学生报名</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/signup" method="post"
			class="search-form form-inline">
			<div class="row">
			<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <select
							name="batchId" class="form-control input-sm">
							<option value="-1" ${batchId==-1?"selected='selected'":"" }>全部</option>
								<c:forEach items="${batchList}" var="bat">
									<option value="${bat.batch_id}" ${batchId==bat.batch_id?"selected='selected'":"" }>${bat.batch_name}</option>
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
						<span class="input-group-addon input-sm">学科分类</span> <select
							name="subjectCatId" class="form-control input-sm">
							<option value="-1" ${subjectCatId==-1?"selected='selected'":"" }>全部</option>
								<c:forEach items="${subjectCategoryList}" var="bat">
									<option value="${bat.subject_cat_id}" ${subjectCatId==bat.subject_cat_id?"selected='selected'":"" }>${bat.subject_name}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="XMGL_XSBMGL_ADDINIT" href="${base}project/txSignupAddInitialize"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>新增报名</a>
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
					<th>学科分类</th>
					<th>是否组队</th>
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
						<td>${data.subject_name}</td>
						<td>${data.team_id==null?"否":"是"}</td>
							<td width="150">
								<a pm="XMGL_XSBMGL_DETAIL" href="${base}project/txSignupView?project_id=${data.project_id}" class="tablelink">项目详情</a>
								<a pm="XMGL_XSBMGL_CANCEL" href="${base}project/txSignupDel?project_id=${data.project_id}" class="tablelink confirm">取消报名</a>
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