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
			<li><a href="#">学习记录评阅</a></li>
		</ul>
	</div >
	<div class="rightinfo">
		<form action="${base}record/review" method="post" class="search-form form-inline">
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
						<span class="input-group-addon input-sm">记录类别</span> <select
							name="recordTypeId" class="form-control input-sm">
							<option value="-1"
								${recordTypeId==-1?"selected='selected'":"" }>全部</option>							
							<c:forEach items="${recordTypeList}" var="record">
									<option value="${record.l_record_type_id}" ${recordTypeId==record.l_record_type_id?"selected='selected'":"" }>${record.l_record_type}</option>
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
							<c:forEach items="${middleSchool}" var="data" varStatus="i">
								<option value="${data.school_id}"
									${middleSchoolId==data.school_id?"selected='selected'":""}>${data.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">评阅状态</span> <select
							name="reviewstatus" class="form-control input-sm">
							<option value="-1" ${reviewstatus==-1?"selected='selected'":"" }>全部</option>							
							<option value="0" ${reviewstatus==0?"selected='selected'":"" }>未评阅</option>								
							<option value="1" ${reviewstatus==1?"selected='selected'":"" }>已评阅</option>	
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
					<th>学生姓名</th>			
					<th>中学学校</th>					
					<th>学习记录名称</th>
					<th>记录类别</th>
					<th>评价状态</th>
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
						<td>${data.name}</td>						
						<td>${data.school_name}</td>
						<td>${data.l_record_name}</td>
						<td>${data.l_record_type}</td>
						<c:if test="${data.status==0}">
							<td>未审阅</td>
						</c:if>
						<c:if test="${data.status==1}">
							<td>已审阅</td>
						</c:if>
						<td><fmt:formatDate value="${data.review_date}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						
						<td width="150">
						<a pm="XXGL_XXJLPYGL_VIEW"	href="${base}record/learnRecordView1?recordId=${data.l_record_id}"			
							class="tablelink">查看</a>
						<c:if test="${data.status=='0'}">
						<a pm="XXGL_XXJLPYGL_VIEWREVIEW" href="${base}record/reviewLearnRecordView?recordId=${data.l_record_id}"			
							class="tablelink">评阅</a></c:if>
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