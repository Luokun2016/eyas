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
	var flagIdCard = false;
	var flagPhone = false;
	var flagEmail = false;

	function checkCertificate() {
		var userName = $("#userName").val();
		var certificate = $("#certification").val();
		if (certificate.length > 0) {
			$.ajax({
				type : "POST",
				async:false,
				url : "${base}index/editCheckCertificate",
				data : {
					"userName": userName,
					"certificate" : certificate
				},
				success : function(data) {
					if (data.flag == "false") {
						$("#certification")[0].focus();
						$.dialog.tips("身份证号已存在,请从新输入！");
					} else {
						flagIdCard = true;
					}
				},
				error : function(jqXHR) {
					alert("发生错误：" + jqXHR.status);
				}
			});
		}
	}
	function checkPhone() {
		var userName = $("#userName").val();
		var mobile = $("#mobile").val();
		if (mobile.length > 0) {
			$.ajax({
				type : "POST",
				async:false,
				url : "${base}index/editCheckPhone",
				data : {
					"userName": userName,
					"mobile" : mobile
				},
				success : function(data) {
					if (data.flag == "false") {
						$("#mobile")[0].focus();
						$.dialog.tips("电话号码已存在,请从新输入！");
					} else {
						flagPhone = true;
					}
				},
				error : function(jqXHR) {
					alert("发生错误：" + jqXHR.status);
				}
			});
		}
	}

	function checkEmail() {
		var userName = $("#userName").val();
		var email = $("#email").val();
		if (email.length > 0) {
			$.ajax({
				type : "POST",
				async:false,
				url : "${base}index/editCheckEmail",
				data : {
					"userName": userName,
					"email" : email
				},
				success : function(data) {
					if (data.flag == "false") {
						$("#email")[0].focus();
						$.dialog.tips("邮箱已存在,请从新输入！");
					} else {
						flagEmail = true;
					}
				},
				error : function(jqXHR) {
					alert("发生错误：" + jqXHR.status);
				}
			});
		}
	}
	function sub() {
		checkCertificate();
		checkPhone();
		checkEmail();
		if (!flagIdCard) {
			$("#certification")[0].focus();
			return false;
		} else if (!flagPhone) {
			$("#mobile")[0].focus();
			return false;
		} else if (!flagEmail) {
			$("#email")[0].focus();
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}index/body">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">添加页面</a></li>
		</ul>
	</div>

	<form action="${base}index/txUpdateUser" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">
			<div class="formtitle">
				<span>用户信息</span>
			</div>
			<cqu:formcols cols="1">
				<col label="用户名" required="required">
				<input type="text" class="form-control input-sm" name="user_name" id="userName"
					datatype="*" value="${userInfo.user_name }" readonly />
				</col>
				<col label="姓名" required="required">
				<input type="text" class="form-control input-sm" name="name"
					datatype="*" value="${userInfo.name }" />
				</col>
				<col label="性别" required="required">
				<select name="sex" class="form-control input-sm">
					<option value="1"
						<c:if test='${userInfo.sex==1}'>selected</c:if>>男</option>
					<option value="0"
						<c:if test='${userInfo.sex==0}'>selected</c:if>>女</option>
				</select>
				</col>
				<col label="年龄" required="required">
				<input type="text" class="form-control input-sm" name="age"
					datatype="n" value="${userInfo.age }" />
				</col>
				<col label="学校" required="required">
				<select name="school_id" class="form-control input-sm">
					<c:forEach items="${schoolInfo}" var="data">
						<option value="${data.school_id }"
							${userInfo.school_id==data.school_id?"selected='selected'":"" }>${data.school_name}</option>
					</c:forEach>
				</select>
				</col>
				<col label="身份证号" required="required">
				<input type="text" class="form-control input-sm"
					name="certification" id="certification" onblur="checkCertificate()"
					datatype="idcard" value="${userInfo.certification }" />
				</col>

				<col label="联系电话" required="required">
				<input type="tel" class="form-control input-sm" name="mobile"
					id="mobile" onblur="checkPhone()" datatype="m" value="${userInfo.mobile }" />
				</col>
				<col label="电子邮箱" required="required">
				<input type="email" class="form-control input-sm" id="email"
					name="email" onblur="checkEmail()" value="${userInfo.email }" datatype="e" />
				</col>
				<col label="QQ" >
				<input type="text" class="form-control input-sm" name="qq"
					value="${userInfo.qq }" datatype="qq" ignore="ignore"/>
				</col>
				<col label="微信" >
				<input type="text" class="form-control input-sm" name="wechat"
					value="${userInfo.wechat }" />
				</col>
				<col label="个人介绍" full="full">
				<textarea class="simple-editor" name="introduction" rows="10"
					cols="105">${userInfo.introduction }</textarea>
				</col>
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" onclick="return sub()">
					<span class="glyphicon glyphicon-floppy-disk"></span>提交
				</button>
				<button type="reset" class="btn btn-default">
					<span class="glyphicon glyphicon-refresh"></span>重置
				</button>
				</col>
			</cqu:formcols>
		</div>
	</form>
</body>
</html>