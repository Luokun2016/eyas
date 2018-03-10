<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript"
	src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
<script language="javascript">
function check() {
	var id=$("#teacherId").val();
	if(id==-1){
		$.dialog.tips("请选择一个中学指导老师");
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
			<a href="${base}project/team">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">组队报名</a></li>
			<li><a href="#">选择老师</a></li>
		</ul>
	</div>
	<form action="${base}project/txTeamAddTeam" method="post"
		class="form-horizontal validate-form" onsubmit="return check();">
		<input type="hidden" name="project_id" value="${projectId}">
		<div class="formbody">
			<div class="formtitle">
				<span>选择指导教师</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称">
				<input type="text" name="projectName" class="form-control input-sm"
					value="${projectApply.project_name}" readonly />
				</col>
				<col label="学科分类">
				<input type="text" name="subjectName" class="form-control input-sm"
					value="${projectApply.subject_name}" readonly />
				</col>
				<col label="中学指导老师">
				<select name="teacherId" id="teacherId" class="form-control input-sm">
					<option value="-1" ${teamTable==null?"selected='selected'":"" }></option>
					<c:forEach items="${teacherList}" var="bat">
						<option value="${bat.user_id}" ${teamTable!=null&&teamTable.user_id==bat.user_id?"selected='selected'":"" }>${bat.name}</option>
					</c:forEach>
				</select>
				</col>

				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn">
					<span class="glyphicon glyphicon-floppy-disk"></span>下一步
				</button>
				</col>
			</cqu:formcols>
		</div>

	</form>
</body>
</html>