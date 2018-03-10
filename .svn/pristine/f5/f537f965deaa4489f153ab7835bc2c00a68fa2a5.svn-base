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
			<li><a href="#">培养计划查询</a></li>
		</ul>
	</div >
	<div class="rightinfo">
		<form action="${base}study/queryProgramme" method="post" class="search-form form-inline">
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
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学科分类</span> <select
							name="subjectCatId" class="form-control input-sm">
							<option value="-1" ${subjectCatId==-1?"selected='selected'":"" }>所有</option>
							<c:forEach items="${subjectList}" var="data" varStatus="i">
								<option value="${data.subject_cat_id}"
									${subjectCatId==data.subject_cat_id?"selected='selected'":""}>${data.subject_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">承担单位</span> <select
							name="schoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>所有</option>
							<c:forEach items="${schoolList}" var="data" varStatus="i">
								<option value="${data.school_id}"
									${schoolId==data.school_id?"selected='selected'":""}>${data.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">中学学校</span> <select
							name="middleSchoolId" class="form-control input-sm">
							<option value="-1"
								${middleSchoolId==-1?"selected='selected'":"" }>所有</option>
							<c:forEach items="${middleSchoolList}" var="data" varStatus="i">
								<option value="${data.school_id}"
									${middleSchoolId==data.school_id?"selected='selected'":""}>${data.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学生姓名</span> <input
							type="text" name="studentName" class="form-control input-sm"
							value="${studentName}" />
					</div>
				</div>

				<div class="col-md-3 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
					&nbsp;
				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>培养计划列表</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>批次名称</th>
					<th>项目名称</th>
					<th>学科分类</th>
					<th>承担单位</th>
					<th>项目负责人</th>
					<th>中学学校</th>
					<th>年级</th>
					<th>班级</th>
					<th>学生</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${planList}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.batch_name}</td>
						<td>${data.project_name}</td>
						<td>${data.subject_name}</td>
						<td>${data.school_name}</td>
						<td>${data.leader_name}</td>
						<td>${data.middleSchool}</td>
						<td>${data.grade_name}</td>
						<td>${data.class_name}</td>
						<td>${data.student_name}</td>
						<td width="150"><a pm="XXGL_PYJHCXGL_VIEW"
							href="${base}study/detailPlanView?
							batch_id=${data.batch_id}&&project_id=${data.project_id}&&student_id=${data.user_id}"
							class="tablelink">查看培养计划</a></td>
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