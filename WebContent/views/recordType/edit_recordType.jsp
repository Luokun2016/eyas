<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript"
	src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}recordtype/recordTypeManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">基础管理</a></li>
			<li><a href="#">学习记录类别管理</a></li>
			<li><a href="#">修改类别信息</a></li>
		</ul>
	</div>
	
	<form action="${base}recordtype/txEditRecordType" method="post"
		class="form-horizontal validate-form">
		<input type="hidden" name="recordTypeId" value="${recordType.l_record_type_id}"/>
		<div class="formbody">

			<div class="formtitle">
				<span>学习记录类别信息</span>
			</div>
			<cqu:formcols cols="1">			
				<col label="类别名称" required="required">		
				<input type="text" name="recordType_name" class="form-control input-sm"
					datatype="*"  value="${recordType.l_record_type}" />
				</col>

				<col label="学科描述" >
				<input	 type="text" name="descript" class="form-control input-sm"
				datatype="*" value="${recordType.descript}">		
				</col>			
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" >
					<span class="glyphicon glyphicon-floppy-disk"></span>提交
				</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="reset" class="btn btn-default">
					<span class="glyphicon glyphicon-refresh"></span>重置
				</button>
				</col>
			</cqu:formcols>
		</div>
	</form>
	
	
	
</body>
</html>