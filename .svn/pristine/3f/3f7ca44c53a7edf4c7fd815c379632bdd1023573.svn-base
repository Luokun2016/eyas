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
			<li><a href="#">学习记录查询</a></li>
		</ul>
	</div >
	<div class="rightinfo">
		<form action="${base}record/queryProgramme" method="post" class="search-form form-inline">
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
							name="collegeSchoolId" class="form-control input-sm">
							<option value="-1"
								${collegeSchoolId==-1?"selected='selected'":"" }>全部</option>							
							<c:forEach items="${collegeSchoolList}" var="data">
									<option value="${data.school_id}" ${collegeSchoolId==data.school_id?"selected='selected'":"" }>${data.school_name}</option>
							</c:forEach>							
						</select>
					</div>
				</div>
								
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">中学学校</span> <select
							name="highSchoolId" class="form-control input-sm">
							<option value="-1"
								${highSchoolId==-1?"selected='selected'":"" }>所有</option>
							<c:forEach items="${highSchoolList}" var="data" varStatus="i">
								<option value="${data.school_id}"
									${highSchoolId==data.school_id?"selected='selected'":""}>${data.school_name}</option>
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
			<span>学习记录列表</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>批次名称</th>
					<th>项目名称</th>
					<th>承担单位</th>					
					<th>中学学校</th>					
					<th>学生姓名</th>			
					<th>学习记录名称</th>
					<th>记录类别</th>					
					<th>评价时间</th>
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
						<td>${data.collegeSchool}</td>
						<td>${data.highSchool}</td>
						<td>${data.name}</td>						
						<td>${data.l_record_name}</td>
						<td>${data.l_record_type}</td>
						<td>${data.review_date}</td>
						
						<td width="150">
						<a href="${base}record/queryView?recordId=${data.l_record_id}"			
							class="tablelink">查看</a>						
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