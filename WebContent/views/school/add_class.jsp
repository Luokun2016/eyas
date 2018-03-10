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
			<li><a href="#">班级管理</a></li>
			<li><a href="#">添加班级</a></li>
		</ul>
	</div>
	
	<form action="${base}class/txAddClass" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">

			<div class="formtitle">
				<span>年级信息</span>
			</div>
		

			<cqu:formcols cols="1">
				<col label="年级名称" ">
				<input type="hidden" name="grade_id" class="form-control input-sm"
					value="${gradeId}" />
				<input type="hidden" name="gradeId" class="form-control input-sm"
					value="${gradeId}" />
				<input type="text" name="gradeName" class="form-control input-sm"
					value="${gradeName}"  readonly/>
				</col>				

				<col label="班级名称" required="required">
				<input type="text" name=className class="form-control input-sm"
					datatype="*" />
				</col>	
				
				<col label="班级简介" >
				<textarea class="simple-editor" name="remark" rows="15"
					cols="110"></textarea>
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