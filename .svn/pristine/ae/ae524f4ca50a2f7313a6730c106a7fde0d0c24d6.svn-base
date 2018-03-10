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
			<li><a href="#">项目正式发布</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/release" method="post"
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
						<span class="input-group-addon input-sm">项目负责人</span> <input
							type="text" name="leaderName" class="form-control input-sm"
							value="${leaderName}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">发布状态</span> <select
							name="isPublish" class="form-control input-sm">
							<option value="-1" ${isPublish==-1?"selected='selected'":"" }>所有</option>
							<option value="0" ${isPublish==0?"selected='selected'":"" }>未发布</option>
							<option value="1" ${isPublish==1?"selected='selected'":"" }>已发布</option>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5 ">
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
					<th>批次名称</th>
					<th>项目名称</th>
					<th>项目负责人</th>
					<th>发布状态</th>
					<th>发布时间</th>
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
						<td>${data.leader_name}</td>
						<c:if test="${data.is_publish==0}">
							<td>未发布</td>	
						</c:if>
						<c:if test="${data.is_publish==1}">
							<td>已发布</td>	
						</c:if>  
						<td><fmt:formatDate value="${data.publish_date}"
								pattern="yyyy-MM-dd HH:mm" /></td>
							<td width="150">
								<a pm="XMGL_ZSFBGL_FEEDBACK" href="${base}project/txReleaseSchoolView?project_id=${data.project_id}" class="tablelink">反馈中学</a>
								<a pm="XMGL_ZSFBGL_FENPEI" href="${base}project/txReleaseView?project_id=${data.project_id}" class="tablelink">分配情况</a>
								<c:if test="${data.is_publish==0}">
								<a pm="XMGL_ZSFBGL_RELEASEINIT" href="${base}project/txReleaseInitialize?project_id=${data.project_id}" class="tablelink">发布</a>
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