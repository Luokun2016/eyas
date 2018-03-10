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
			<li><a href="#">基础管理</a></li>
			<li><a href="#">学科类别管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}subject/subjectManage" method="post"
			class="search-form form-inline">
			<div class="formbody">
				<div class="row">
					<div class="col-md-3 margin5">
						<div class="input-group">
							<span class="input-group-addon input-sm">学科类别名称</span> <input
								type="text" name="subjectName" class="form-control input-sm"
								value="${subjectName}" />
						</div>
					</div>
					<div class="col-md-3 margin5">
						<div class="input-group">
							<span class="input-group-addon input-sm">类别描述</span> <input
								type="text" name="Descript" class="form-control input-sm"
								value="${Descript}">
						</div>
					</div>


					<div class="col-md-4 margin5 ">
						<button type="submit" class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-search"></span>查询
						</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a 
						pm="JCGL_XKLBGL_ADDINIT" href="${base}subject/addSubjectView"
							class="btn btn-default btn-sm"><span
							class="glyphicon glyphicon-plus"></span>添加</a>
					</div>

				</div>
			</div>
		</form>


		<div class="formtitle">
			<span>学科信息</span>
		</div>

		<table class="tablelist">
			<thead>
				<tr>
					<th>学科名称</th>
					<th>学科描述</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.subject_name}</td>
						<td>${data.descript}</td>
						<td><a
							pm="JCGL_XKLBGL_EDITINIT" href="${base}subject/editSubjectView?subjectId=${data.subject_cat_id}"
							class="tablelink">修改</a> <a
							pm="JCGL_XKLBGL_DEL" href="${base}subject/txDeleteSubject?subjectId=${data.subject_cat_id}"
							class="tablelink confirm">删除</a> <a
							pm="JCGL_XKLBGL_VIEW" href="${base}subject/showSubjectView?subjectId=${data.subject_cat_id}"
							class="tablelink">查看</a></td>
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