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
			<a href="${base}school/schoolManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">基础管理</a></li>
			<li><a href="#">学校管理</a></li>
			<li><a href="#">查看学校信息</a></li>
		</ul>
	</div>
	
	<form action="" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">

			<div class="formtitle">
				<span>学校信息</span>
			</div>
		

			<cqu:formcols cols="1">
				
				<col label="学校名称" >				
				<input type="text" name="schoolName" class="form-control input-sm"
					value="${school.school_name}" readonly/>
				</col>

				<col label="学校类别" >
				<c:if test="${school.school_type==0}">
					<input type="text" name=schoolType class="form-control input-sm"
					value="高校" readonly/></c:if>
				<c:if test="${school.school_type==1}">
					<input type="text" name=schoolType class="form-control input-sm"
					value="中学" readonly/></c:if>				
				
				</col>

				<col label="学校负责人" >
				<input type="text" name=manager class="form-control input-sm"
					value="${school.manager}" readonly/>
				</col>
				
				<col label="学校地址" >
				<input type="text" name="address" class="form-control input-sm"
					value="${school.address}" readonly/>
				</col>
				
				<col label="学校联系电话"  >
				<input type="tel" pattern="[0-9]{11}" name="phone" class="form-control input-sm"
					value="${school.phone}" readonly/>
				</col>
				
				<col label="学校简介" >
				<textarea class="simple-editor" name="remark" rows="15"
					cols="110" readonly>${school.remark}</textarea>
				</col>
				
				
			</cqu:formcols>
		</div>
	</form>
	
	
	
</body>
</html>