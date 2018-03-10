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
			<li><a href="#">项目申报管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/apply" method="post"
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
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">项目名称</span> <input
							type="text" name="projectName" class="form-control input-sm"
							value="${projectName}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">承担单位</span> <input
							type="text" name="schoolName" class="form-control input-sm"
							value="${schoolName}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">负责人</span> <input
							type="text" name="leaderName" class="form-control input-sm"
							value="${leaderName}" />
					</div>
				</div>
				
				<div class="col-md-3 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="XMGL_XMSBGL_ADDINIT" href="${base}project/txAddApplyInitialize"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>新项目申报</a>
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
					<th>提交时间</th>
					<th>项目状态</th>
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
						<td>${data.leader_name}</td>
						<td><fmt:formatDate value="${data.submit_time}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<c:if test="${data.submit_status==0}">
							<td>申报未提交</td>
						</c:if>
						<c:if test="${data.submit_status==1}">
							<td>申报已提交</td>
						</c:if>
						<c:if test="${data.submit_status==2}">
							<td>不予立项</td>
						</c:if>
						<c:if test="${data.submit_status==3}">
							<td>予以立项</td>
						</c:if>
						<c:if test="${data.submit_status==4}">
							<td>筛选与反馈</td>
						</c:if>
						<c:if test="${data.submit_status==5}">
							<td>高校发布</td>
						</c:if>
						<c:if test="${data.submit_status==6}">
							<td>学生报名</td>
						</c:if>
						<c:if test="${data.submit_status==7}">
							<td>中学组队</td>
						</c:if>
						<c:if test="${data.submit_status==8}">
							<td>创新学院发布</td>
						</c:if>
						<c:if test="${data.submit_status==9}">
							<td>结题</td>
						</c:if>			
						<c:if test="${data.project_status==0}">
							<td>未审核</td>
						</c:if>
						<c:if test="${data.project_status==1}">
							<td>初审通过</td>
						</c:if>
						<c:if test="${data.project_status==2}">
							<td>初审未通过</td>
						</c:if>
						<c:if test="${data.project_status==3}">
							<td>复审通过</td>
						</c:if>
						<c:if test="${data.project_status==4}">
							<td>复审未通过</td>
						</c:if>
							<td width="180"><a pm="XMGL_XMSBGL_REQUIREMENT" href="${base}project/applyRequirement?batch_id=${data.batch_id}"
								class="tablelink">立项要求</a>
								<a pm="XMGL_XMSBGL_DETAIL" href="${base}project/txApplyView?project_id=${data.project_id}"
								class="tablelink">项目详情</a>
							<c:if test="${data.project_status==0||data.project_status==2||data.project_status==4}">
								<a pm="XMGL_XMSBGL_EDIT" href="${base}project/txApplyEdit?project_id=${data.project_id}" class="tablelink">修改</a>
 							    <a pm="XMGL_XMSBGL_DEL" href="${base}project/txApplyDel?project_id=${data.project_id}" class="tablelink confirm">删除</a> 
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