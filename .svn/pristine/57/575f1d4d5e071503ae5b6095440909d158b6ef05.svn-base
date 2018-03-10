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
			<li><a href="#">学生推优</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}recommend/studentManage" method="post"
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
				<div class="col-md-4 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学生姓名</span> <input
							type="text" name="keyWord" class="form-control input-sm"
							value="${keyWord}" />
					</div>
				</div>
				<div class="col-md-4 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="TYGL_XSTYGL_ADDINIT" href="${base}recommend/addS"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>新增学生</a>
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
					<th>学生名称</th>
					<th>所在学校</th>
					<th>年级</th>
					<th>班级</th>
					<th>参与项目</th>
					<th>审核状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<input type="hidden" name="${data.batch_id}" value=""/>
					<input type="hidden" name="${data.project_id}" value=""/>
					<input type="hidden" name="${data.student_id}" value=""/>
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.batch_name}</td>
						<td>${data.name}</td>
						<td>${data.school_name}</td>
						<td>${data.grade_name}</td>
						<td>${data.class_name}</td>
						<td>${data.project_name}</td>
						<td>
							<c:if test="${data.status==0}">未审核</c:if>
							<c:if test="${data.status==1}">审核未通过</c:if>
							<c:if test="${data.status==2}">审核通过</c:if>
						</td>
						<td>
							<c:if
								test="${role==4&&data.status!=2}"><a pm="TYGL_XSTYGL_EDITINIT" href="${base}recommend/editS?student_id=${data.student_id}&batch_id=${data.batch_id}&project_id=${data.project_id}" class="tablelink">修改</a>
 							<a pm="TYGL_XSTYGL_DEL" href="${base}recommend/txDelStudent?student_id=${data.student_id}&batch_id=${data.batch_id}" class="tablelink confirm">删除</a> </c:if>
							<c:if
								test="${role==6}"><c:if
								test="${data.status!=2}"><a pm="TYGL_XSTYGL_CHECKINIT" href="${base}recommend/exaS?student_id=${data.student_id}&batch_id=${data.batch_id}&project_id=${data.project_id}" class="tablelink">审核</a></c:if>
								<a pm="TYGL_XSTYGL_DEL" href="${base}recommend/txDelStudent?student_id=${data.student_id}&batch_id=${data.batch_id}" class="tablelink confirm">删除</a> </c:if>
								<a pm="TYGL_XSTYGL_VIEW" href="${base}recommend/viewS?student_id=${data.student_id}&batch_id=${data.batch_id}&project_id=${data.project_id}" class="tablelink">查看</a>
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