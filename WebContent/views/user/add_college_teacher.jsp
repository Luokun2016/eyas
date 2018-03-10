<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script src="${base}assets/js/md5.js" type="text/javascript"></script>
<script type="text/javascript"
	src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript">
var flagName = false;
var flagIdCard = false;
var flagPhone = false;
var flagEmail = false;
	function md5() {
		var pw = $("#password").val();
		if (pw.length > 0) {
			$("#password").val(hex_md5(pw));
		}
	}
	
	function checkName(){
		var userName = $("#userName").val();
		if(userName.length > 0){
			$.ajax({
				type:"POST",
				url : "${base}index/checkName",
				data:{"userName":userName},
				success:function(data) {				
					if (data.flag == "false") {
						$("#userName")[0].focus();
						$.dialog.tips("用户名已存在,请从新输入！");					
					}else {
						flagName = true;
					}
				},
				error:function(jqXHR){
					alert("发生错误："+jqXHR.status);
				}
			});
		}		
	}
	
	function checkCertificate() {
		var certificate = $("#certification").val();
		if (certificate.length > 0) {
			$.ajax({
				type : "POST",
				url : "${base}index/checkCertificate",
				data : {
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
		var mobile = $("#mobile").val();
		if (mobile.length > 0) {
			$.ajax({
				type : "POST",
				url : "${base}index/checkPhone",
				data : {
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
		var email = $("#email").val();
		if (email.length > 0) {
			$.ajax({
				type : "POST",
				url : "${base}index/checkEmail",
				data : {
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
	
	function checkPW() {
		var pw = $("#password1").val();
		if (pw.length > 0) {
			$("#password1").val(hex_md5(pw));
		}
		var pw1 = $("#password").val();
	}
	
	
	function sub(){
		var schoolId = $("#school").val();
		var degree = $("#degree").val();
		var pw = $("#password1").val();
		var pw1 = $("#password").val();
		if(schoolId == -1){
			$("#school")[0].focus();
			$.dialog.tips("请选择学校");
			return false;
		}else if(degree == -1){
			$("#degree")[0].focus();
			$.dialog.tips("请选择学历");
			return false;
		}else if(pw != pw1){
			$("#password")[0].focus();
			$.dialog.tips("两次密码不一样，请重新输入！");
			return false;
		}else if (!flagName) {
			$("#userName")[0].focus();
			return false;
		} else if (!flagIdCard) {
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
			<a href="${base}user/index">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">用户信息</a></li>
		</ul>
	</div>
	<form action="${base}user/txAdd" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">
			<div class="formtitle">
				<span>添加用户</span>
			</div>
			<cqu:formcols cols="1">

				<col label="用户名" required="required">
				<input type="hidden" name="user_type" class="input-sm" value="3" />
				<input type="text" name="user_name" class="input-sm form-control"
					id="userName" onblur="checkName()" datatype="uName" required="required" placeholder="2位以上字母数字下划线组合" />
				</col>
				<col label="密码" required="required">
				<input type="password" name="password" onchange="md5()"
					id="password" class=" input-sm form-control" datatype="*" placeholder="请输入密码"
					required="required" />
				</col>
				<col label="确认密码" required="required">
				<input type="password" name="password1" onchange="checkPW()"
					id="password1" class="input-sm form-control" datatype="*" placeholder="请再次输入密码"
					required="required" />
				</col>
				<col label="姓名" required="required">
				<input type="text" name="name" class="input-sm form-control"
					datatype="*" required="required" />
				</col>

				<col label="性别">
				<select name="sex" class="form-control input-sm">
					<option value="1">男</option>
					<option value="0">女</option>
				</select>
				</col>

				<col label="年龄" required="required">
				<input type="text" name="age" class="form-control input-sm"
					datatype="n" required="required" />
				</col>

				<col label="执教学校">
				<select name="school_id" class="form-control input-sm" id="school">
					<option value="-1" selected="selected">请选择学校</option>
					<c:forEach items="${schoolList}" var="data" varStatus="i">
						<option value="${data.school_id}"
							${school_id=="${data.school_id}"?"selected='selected'":""}>${data.school_name}</option>
					</c:forEach>
				</select>
				</col>

				<col label="所在学院" required="required">
				<input type="text" name="depart" required="required"
					class="form-control input-sm" datatype="*" />
				</col>

				<col label="身份证号" required="required">
				<input type="text" name="certification" id="certification"
					required="required" class="form-control input-sm" datatype="idcard"
					onblur="checkCertificate()" />
				</col>

				<col label="学历">
				<select name="degree" class="form-control input-sm" id="degree">
					<option value="-1">请选择学历</option>
					<option value="高职(专科)">高职(专科)</option>
					<option value="本科">本科</option>
					<option value="硕士研究生">硕士研究生</option>
					<option value="博士研究生">博士研究生</option>
				</select>
				</col>

				<col label="职称" required="required">
				<input type="text" name="academic_pos" class="form-control input-sm"
					datatype="*" required="required" />
				</col>

				<col label="职务">
				<input type="text" name="position" class="form-control input-sm" />
				</col>

				<col label="从事专业" required="required">
				<input type="text" name="major" class="form-control input-sm" 
					datatype="*" required="required"/>
				</col>

				<col label="研究领域" required="required">
				<input type="text" name="research_field"
					class="form-control input-sm" datatype="*" required="required"/>
				</col>


				<col label="联系电话" required="required">
				<input type="text" name="mobile" id="mobile" class="form-control input-sm"
					datatype="m" required="required" onblur="checkPhone()"/>
				</col>

				<col label="邮箱" required="required">
				<input type="text" name="email" id="email" class="form-control input-sm"
					datatype="e" required="required" onblur="checkEmail()"/>
				</col>

				<col label="ＱＱ">
				<input type="text" name="qq" class="form-control input-sm"
					datatype="qq" ignore="ignore" />
				</col>

				<col label="微信">
				<input type="text" name="wechat" class="form-control input-sm" />
				</col>

				<col label="个人简介">
				<textarea class="simple-editor" name="introduction" rows="10"
					cols="105"></textarea>
				</col>

				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" onclick="return sub()">
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