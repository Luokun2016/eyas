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
			<a href="${base}class/classManage?gradeId=${gradeId}">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">基础管理</a></li>
			<li><a href="#">年级管理</a></li>
			<li><a href="#">查看班级信息</a></li>
		</ul>
	</div>
	
	<form action="" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">

			<div class="formtitle">
				<span>班级信息</span>
			</div>
		

			<cqu:formcols cols="1">
				
				<col label="班级名称" >		
				<input type="text" name="className" class="form-control input-sm"
					value="${class.class_name}" readonly/>
				</col>				
				
				<col label="班级简介" >
				<textarea class="simple-editor" name="remark" rows="15"
					cols="110" readonly>${class.remark}</textarea>
				</col>
				
				
			</cqu:formcols>
		</div>
	</form>
	
	
	
</body>
</html>