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
			<li><a href="#">立项管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project" method="post"
			class="search-form form-inline">
			<div class="row">
				<div class="col-md-4 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <input
							type="text" name="batchName" class="form-control input-sm"
							value="${batchName}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次状态</span> <select
							name="batchStatus" class="form-control input-sm">
							<option value="-1" ${batchStatus==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${batchStatus==0?"selected='selected'":"" }>非当前</option>
							<option value="1" ${batchStatus==1?"selected='selected'":"" }>当前</option>
						</select>
					</div>
				</div>
				
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="XMGL_LXGL_ADDINIT" href="${base}project/txAddInitialize"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>添加批次</a>
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
					<th>发布时间</th>
					<th>申报截止时间</th>
					<th>审核截止时间</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.batch_name}</td>
						<td><fmt:formatDate value="${data.begin_date}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td><fmt:formatDate value="${data.apply_end_date}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td><fmt:formatDate value="${data.check_end_time}"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td>
							${data.batch_status==0?"非当前":"当前"}
						</td>
							<td width="150"><a pm="XMGL_LXGL_VIEW" href="${base}project/view?batch_id=${data.batch_id}"
								class="tablelink">查看</a>
							<a pm="XMGL_LXGL_EDITINIT" href="${base}project/txEdit?batch_id=${data.batch_id}" class="tablelink">修改</a> 
							<a pm="XMGL_LXGL_DEL" href="${base}project/txDel?batch_id=${data.batch_id}" class="tablelink confirm">删除</a> 
							<c:if test="${data.batch_status==0}">
								<a pm="XMGL_LXGL_STATES" href="${base}project/txStatus?batch_id=${data.batch_id}" class="tablelink">当前</a>
							</c:if>
							<c:if test="${data.batch_status==1}">
								<a pm="XMGL_LXGL_STATES" href="${base}project/txStatus?batch_id=${data.batch_id}" class="tablelink">非当前</a>
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