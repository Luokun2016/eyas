<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
  </head>
  <body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}dept/index">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">基础管理</a></li>
			<li><a href="#">部门管理</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>添加</span>
		</div>
		<form action="${base}dept/txAdd" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="flag" value="save"/>
			<cqu:formcols cols="1">
				<col label="隶属机构"  >
					<input type="text" class="form-control input-sm" value="${org.org_name }" readonly="readonly" datatype="*" />
					<input type="hidden" name="org_id" value="${org_id }"/>
					<input type="hidden" name="orgId" value="${org_id }"/>
				</col>
				<col label="部门名称" required="required"  >
					<input type="text" class="form-control input-sm" name="dep_name" value="${dep_name }" datatype="*" />
				</col>
				<col label="描述" full="full">
					<textarea class="simple-editor" name="dep_desc" cols="105">${dep_desc }</textarea>
				</col>
				<col label="&nbsp;">
					<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span>提交</button>
					<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
				</col>
			</cqu:formcols>
		</form>
	</div>
	
</body>
</html>