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
			<li><a href="#">组队审核</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/teamCheck" method="post"
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
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">承担单位</span>  <select
							name="schoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>全部</option>
								<c:forEach items="${schooList}" var="bat">
									<option value="${bat.school_id}" ${schoolId==bat.school_id?"selected='selected'":"" }>${bat.school_name}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学科分类</span>  <select
							name="subjectCatId" class="form-control input-sm">
							<option value="-1" ${subjectCatId==-1?"selected='selected'":"" }>全部</option>
								<c:forEach items="${subjectList}" var="bat">
									<option value="${bat.subject_cat_id}" ${subjectCatId==bat.subject_cat_id?"selected='selected'":"" }>${bat.subject_name}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">负责人</span> <input
							type="text" name="leaderName" class="form-control input-sm"
							value="${leaderName}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">中学学校</span>  <select
							name="highSchoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>全部</option>
								<c:forEach items="${highSchooList}" var="bat">
									<option value="${bat.school_id}" ${highSchoolId==bat.school_id?"selected='selected'":"" }>${bat.school_name}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">审核状态</span>  <select
							name="teamStatus" class="form-control input-sm">
							<option value="-1" ${teamStatus==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${teamStatus==0?"selected='selected'":"" }>未审核</option>
							<option value="1" ${teamStatus==1?"selected='selected'":"" }>初审未通过</option>
							<option value="2" ${teamStatus==2?"selected='selected'":"" }>初审通过</option>
							<option value="3" ${teamStatus==3?"selected='selected'":"" }>复审未通过</option>
							<option value="4" ${teamStatus==4?"selected='selected'":"" }>复审通过</option>
						</select>
					</div>
				</div>
				
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;<a pm="XMGL_ZUSHGL_IMPORTALL" href="${base}project/txImportBatchInitialize"
						class="btn btn-default btn-sm"><span
						></span>批次导出学生</a>					
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
					<th>项目负责人</th>
					<th>中学学校</th>
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
						<td>${data.school_name}</td>
						<td>${data.subject_name}</td>
						<td>${data.leader_name}</td>
						<td>${data.highschool_name}</td>
						<c:if test="${data.team_status==0}">
							<td>未审核</td>
						</c:if>
						<c:if test="${data.team_status==1}">
							<td>初审未通过</td>
						</c:if>
						<c:if test="${data.team_status==2}">
							<td>初审通过</td>
						</c:if>
						<c:if test="${data.team_status==3}">
							<td>复审未通过</td>
						</c:if>
						<c:if test="${data.team_status==4}">
							<td>复审通过</td>
						</c:if>
							<td width="150"> <a	pm="XMGL_ZUSHGL_TEAMDETAIL" href="${base}project/txTeamCheckDetailView?project_id=${data.project_id}"
							class="tablelink">组队详情</a>
							<c:if test="${role==4&&batchNow.batch_id==data.batch_id&&data.team_status==0}">
								&nbsp;<a pm="XMGL_ZUSHGL_CHECKONEINIT" href="${base}project/txTeamCheck1?project_id=${data.project_id}&&status=0"
							class="tablelink">初审</a>
							</c:if> 
							<c:if test="${role==6&&batchNow.batch_id==data.batch_id&&data.team_status==2}">
								&nbsp;<a pm="XMGL_ZUSHGL_CHECKTWOINIT" href="${base}project/txTeamCheck2?project_id=${data.project_id}&&status=1"
							class="tablelink">复审</a>
							</c:if>
							<c:if test="${role==6&&batchNow.batch_id==data.batch_id&&data.team_status==4&&data.submit_status!=8}">
								&nbsp;<a pm="XMGL_ZUSHGL_RELEASE" href="${base}project/txProjectRelease?project_id=${data.project_id}"
							class="tablelink confirm">发布</a>
							</c:if>
							<c:if test="${role==6&&data.team_status==4&&data.submit_status==8}">
								&nbsp;<a pm="XMGL_ZUSHGL_IMPORTONE" href="${base}project/txProjectImportStudent?project_id=${data.project_id}&&flag=one"
							class="tablelink confirm">导出名单</a>
							</c:if>   
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