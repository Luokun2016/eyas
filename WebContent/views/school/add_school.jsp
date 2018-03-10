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
	
<script type="text/javascript">
function checkSchoolName() {
	var schoolName = $("#schoolName").val();
	var flag = false;
	if (schoolName.length > 0) {
		$.ajax({
			type : "POST",
			async: false,
			url : "${base}school/checkSchoolName",
			data : {
				"schoolName" : schoolName
			},
			success : function(data) {
				if (data.flag == "false") {
					$("#schoolName")[0].focus();
					$.dialog.tips("学校已存在，请从新输入！");					
				}else{
					flag = true;
				}
			},
			error : function(jqXHR) {
				alert("发生错误：" + jqXHR.status);
			}
		});
	}
	return flag;
}
</script>
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
			<li><a href="#">添加学校</a></li>
		</ul>
	</div>
	
	<form action="${base}school/txAddSchool" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">

			<div class="formtitle">
				<span>学校信息</span>
			</div>
		

			<cqu:formcols cols="1">
				<col label="学校名称" required="required">
				<input type="text" name="schoolName" class="form-control input-sm" id="schoolName"
					datatype="*"  onblur="checkSchoolName()"/>
				</col>

				<col label="学校类别" required="required">
				<select	name="schoolType" class="form-control input-sm">					
					<option value="0" >高校</option>
					<option value="1" >中学</option>
				</select>
				</col>

				<col label="学校负责人" required="required">
				<input type="text" name=manager class="form-control input-sm"
					datatype="*" />
				</col>
				
				<col label="学校地址" required="required">
				<input type="text" name="address" class="form-control input-sm"
					datatype="*" />
				</col>
				
				<col label="学校联系电话" required="required" >
				<input type="tel" pattern="[0-9]{11}" name="phone" class="form-control input-sm"
					  datatype="m" />
				</col>
				
				<col label="学校简介" >
				<textarea class="simple-editor" name="remark" rows="15"
					cols="110"></textarea>
				</col>

				
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary"  onclick="return checkSchoolName()">
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