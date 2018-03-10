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
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet">
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script language="javascript">
	function isSubmit() {
		var value = $("#projectNowId").val();
		if (value == -1) {
			$.dialog.tips("请选择项目名称");
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
		<form action="${base}conclusion/addC" method="post"
		onsubmit="return isSubmit()">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">请选择项目</h4>
					</div>
					<div class="modal-body">
						<div class="col-md-6">
							<div class="input-group">
								<span class="input-group-addon input-sm">项目名称</span> <select
									name="projectNowId" id="projectNowId"
									class="form-control input-sm">
									<option value="-1">请选择</option>
									<c:forEach items="${projectNowList}" var="bat">
										<option value="${bat.project_id}">${bat.project_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="modal-footer" style="margin-top: 28px;">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="submit" class="btn btn-primary">确定</button>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学习管理</a></li>
			<li><a href="#">教师结题报告维护</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}conclusion/addC" method="post"
			class="search-form form-inline">
			<div class="row">
			  <div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <select name="batchId" class="form-control input-sm">
							<option value="-1" ${batchId==-1?"selected='selected'":"" }>全部</option>
								<c:forEach items="${batchList}" var="bat">
									<option value="${bat.batch_id}" ${batchId==bat.batch_id?"selected='selected'":"" }>${bat.batch_name}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">项目名称</span>
							<input type="text" name="project_key" class="form-control input-sm" value="${project_key}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">结题名称</span> 
							<input type="text" name="keyWord" class="form-control input-sm" value="${keyWord}" />
					</div>
				</div>
				<div class="col-md-4 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;					
					<a pm="XXGL_JSBGWHGL_ADDINIT" href="#"
						class="btn btn-default btn-sm"  data-toggle="modal" data-target="#myModal"><span
						class="glyphicon glyphicon-plus"></span>新增报告</a>
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
					<th>单位</th>
					<th>结题报告名称</th>
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
						<td>${data.name}</td>
						<td>${data.school_name}</td>
						<td>${data.conclusion_name}</td>
						<td>
							<c:if test="${data.conclusion_status==0}">未审核</c:if>
							<c:if test="${data.conclusion_status==1}">高校审核未通过</c:if>
							<c:if test="${data.conclusion_status==2}">高校审核通过</c:if>
							<c:if test="${data.conclusion_status==3}">创新学院审核未通过</c:if>
							<c:if test="${data.conclusion_status==4}">创新学院审核通过</c:if>
						</td>
						<td>
							<a pm="XXGL_JSBGWHGL_VIEW" href="${base}conclusion/viewC?conclusion_id=${data.conclusion_id}" class="tablelink">查看</a> 
							<c:if test="${data.conclusion_status!=2&&data.conclusion_status!=4}"><a pm="XXGL_JSBGWHGL_EDITINIT" href="${base}conclusion/editC?conclusion_id=${data.conclusion_id}" class="tablelink">修改</a>
 							<a pm="XXGL_JSBGWHGL_DEL" href="${base}conclusion/txDelConclusion?conclusion_id=${data.conclusion_id}" class="tablelink confirm">删除</a></c:if>
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