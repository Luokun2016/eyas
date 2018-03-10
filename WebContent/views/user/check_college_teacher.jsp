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
function check1(){
	var check=$("input[type='radio']:checked").val();
	var significance=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
	if(check==null){
		$.dialog.tips("请选择审核状态");
		return false
	}else if(check==2&&significance==''){
		$.dialog.tips("请填写审核意见");
		return false;
	}else
		return true;
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
	
	<form action="${base}user/userCheckSubmit" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">

			<div class="formtitle">
				<span>用户信息</span>
			</div>
			<cqu:formcols cols="1" >
				<col label="用户名" required="required"  >
					<input type="text" class="form-control input-sm checkItem" name="user_name" datatype="*" value="${userInfo.user_name }" readonly/>
				</col>
				<col label="姓名" required="required"  >
					<input type="text" class="form-control input-sm" name="name" datatype="*" value="${userInfo.name }"/>
				</col>
				<col label="性别" required="required"  >
					<input type="text" class="form-control input-sm" name="sex" datatype="*" value="${userInfo.sex==1?'男':'女' }"/>
				</col>
				<col label="年龄" required="required"  >
					<input type="text" class="form-control input-sm" name="age" datatype="*" value="${userInfo.age }"/>
				</col>
				<col label="执教学校" required="required"  >
					<input type="text" class="form-control input-sm" name="school" datatype="*" value="${userInfo.school_name }"/>
				</col>
					<col label="所在学院" required="required" >
						<input type="text" class="form-control input-sm needVaild" name="depart"   value="${userInfo.depart }"/>
					</col>
					<col label="身份证号" required="required" >
						<input type="text" class="form-control input-sm needVaild" name="certification"  value="${userInfo.certification }"/>
					</col>
					<col label="学历" required="required" >
						<input type="text" class="form-control input-sm needVaild" name="degree"   value="${userInfo.degree }"/>
					</col>
					<col label="职称" required="required" >
						<input type="text" class="form-control input-sm needVaild" name="academic_pos"   value="${userInfo.academic_pos }"/>
					</col>
					<col label="职务" >
						<input type="text" class="form-control input-sm needVaild" name="position"   value="${userInfo.position }"/>
					</col>
					<col label="从事专业" required="required" >
						<input type="text" class="form-control input-sm needVaild" name="major"   value="${userInfo.major }"/>
					</col>
					<col label="研究领域" required="required" >
						<input type="text" class="form-control input-sm needVaild" name="research_fild"   value="${userInfo.research_fild }"/>
					</col>

				<col label="联系电话"  >
					<input type="text" class="form-control input-sm" name="mobile"  value="${userInfo.mobile }"/>
				</col>
				<col label="电子邮箱"   >
					<input type="email" class="form-control input-sm needVaild" name="email" value="${userInfo.email }"/>
				</col>
				<col label="QQ"   >
					<input type="text" class="form-control input-sm needVaild" name="qq"  value="${userInfo.qq }" />
				</col>
				<col label="微信"  >
					<input type="text" class="form-control input-sm" name="wechat"  value="${userInfo.wechat }"/>
				</col>
				<col label="个人介绍" full="full">
					<textarea class="simple-editor" name="user_desc" rows = "10" cols="105">${userInfo.introduction }</textarea>
				</col>
				<col label="审核状态" full="full">
					<input type="radio" name="checkStatus" value="1" ${userInfo.check_status==1?"checked":"" }> 审核通过</>
					<input type="radio" name="checkStatus" value="2" ${userInfo.check_status==2?"checked":"" }>审核不通过</>
				</col>
				<col label="审核意见" full="full">
					<textarea class="simple-editor" name="remark" rows = "10" cols="105">${userInfo.uremark }</textarea>
				</col>
				<col label="&nbsp;">
					<button type="submit" class="btn btn-primary"  onclick="return check1()"><span class="glyphicon glyphicon-floppy-disk"></span>提交</button>
					<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
				</col>
			</cqu:formcols>
			
		</div>
	</form>
	
	
	
</body>
</html>