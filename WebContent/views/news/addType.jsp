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
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">基础设置</a></li>
			<li><a href="#">类型管理</a></li>
			<li><a href="#">新增类型</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>发布</span>
		</div>
		<form action="${base}news/txAddType" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="flag" value="save"/>
			<cqu:formcols cols="1">
				<col label="类型名称" required="required"  >
					<input type="text" class="form-control input-sm" name="type_name" datatype="*" value="${type_name }"/>
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