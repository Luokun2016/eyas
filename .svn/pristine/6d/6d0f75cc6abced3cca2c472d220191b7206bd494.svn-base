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
			<li><a href="#">学校管理</a></li>
		</ul>
	</div>
<div class="rightinfo">
	<form action="${base}school/schoolManage" method="post"
		class="search-form form-inline">
		<div class="formbody">			
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学校名称</span>					
							<input type="text" name="school_name"
								class="form-control input-sm" value="${school_name}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">类别</span> <select
							name="school_type" class="form-control input-sm">
							<option value="-1" ${school_type==-1?"selected='selected'":"" }>所有</option>
							<option value="0" ${school_type==0?"selected='selected'":"" }>高校</option>
							<option value="1" ${school_type==1?"selected='selected'":"" }>中学</option>
						</select>
					</div>
				</div>


				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a pm="JCGL_XXGL_ADDINIT" href="${base}school/addSchoolView"
						class="btn btn-default btn-sm"><span
						class="glyphicon glyphicon-plus"></span>添加</a>
				</div>

			</div>
		</div>
	</form>

	
	<div class="formtitle">
		<span>学校信息</span>
	</div>
	
	<table class="tablelist">
			<thead>
				<tr>
					<th>学校名称</th>
					<th>学校类别</th>
					<th>学校负责人</th>
					<th>学校地址</th>
					<th>学校联系电话</th>
					<th>操作</th>					
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.school_name}</td>
						<td><c:if test="${data.school_type=='0'}">高校</c:if>
							<c:if test="${data.school_type=='1'}">中学</c:if>
						</td>
						<td>${data.manager}</td>
						<td>${data.address}</td>
						<td>${data.phone}</td>
						<td>
						<a pm="JCGL_XXGL_EDITINIT" href="${base}school/editSchoolView?schoolId=${data.school_id}"
						class="tablelink">修改</a>
						<a pm="JCGL_XXGL_DEL" href="${base}school/txDeleteSchool?schoolId=${data.school_id}"
						class="tablelink confirm">删除</a>
						<a pm="JCGL_XXGL_VIEW" href="${base}school/showSchoolView?schoolId=${data.school_id}"
						class="tablelink">查看</a>
						<c:if test="${data.school_type=='0'}">
							<a pm="JCGL_XXGL_VIEWRELATION" href="${base}school/setSchoolRelationshipView?schoolId=${data.school_id}"
								class="tablelink">关联学校</a>
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