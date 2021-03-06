﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<!DOCTYPE html>
<html>
   <head>
   <script type="text/javascript" src="${base}assets/jq/jquery-1.10.2.min.js"></script>
	<jsp:include page="../common/common.jsp"></jsp:include>
	<script type="text/javascript">
	function getTeaInfo(){
		var teacher_id = $("#teacherId").val();
		$.ajax({
			type:"POST",
			url : "${base}recommend/getTeaInfo",
			data:{"teacher_id":teacher_id},
			dataType:"json",
			success:function(data){
				if(!(data.TMessage=="")){
					var TMessage=data.teacherM;
					var schoolName=TMessage.school_name;
					var major=TMessage.major;
					var degree=TMessage.degree;
					var teachCourse=TMessage.teach_course;
					var academicPos=TMessage.academic_pos;
					$("#schoolName").val(schoolName);
					$("#major").val(major);
					$("#degree").val(degree);
					$("#teachCourse").val(teachCourse);
					$("#academicPos").val(academicPos);
				}
			},
			error:function(jqXHR){
				alert("发生错误："+jqXHR.status);
			}
		});
	}
	
	function save(){
		var text1=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		if(text1==''){
			$.dialog.tips("从事雏鹰计划组织指导工作情况概述不能为空");
			return false;
		}else{
			return true;
		}
	}
	</script>
  </head>
  <body onload="getTeaInfo()">
	<div class="place">
	<div class="pull-right backbtn">
			<a href="${base}${base}recommend/teacherManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">导师推优</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>修改导师推优</span>
		</div>
		<form action="${base}recommend/txEditTeacher" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="project_id" id="projectId" value="${projectM.project_id }"/>
			<input type="hidden" name="teacher_id" id="teacherId" value="${teacherM.teacher_id }"/>
			<input type="hidden" name="batch_id" value="${teacherM.batch_id }" />
			<cqu:formcols cols="1">
				<col label="推荐项目" required="required">
					<input  name="project_name"  class="form-control input-sm" value="${projectM.project_name }" readonly/>
				</col>
				<col label="推荐类型" required="required">
					<c:if test="${teacherM.t_type==2}">
						<input  name="t_type" id="tType"  class="form-control input-sm" value="优秀高校导师" readonly/>
					</c:if>
					<c:if test="${teacherM.t_type==1}">
						<input  name="t_type" id="tType"  class="form-control input-sm" value="优秀中学导师" readonly/>
					</c:if>	
				</col>
				<col label="推荐老师" required="required">
					<input  name="name" class="form-control input-sm" value="${teacherM.name }" readonly/>
				</col>
				<col label="所在单位">
					<div class="input-group">
						<input type="text" id="schoolName" class="form-control input-sm" style="width:440px" readonly /></div>
				</col>
				<col label="导师信息" >
				<cqu:formcols cols="2">
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm"> 专 业 </span>
						<input type="text" id="major" class="form-control input-sm" style="width:150px" readonly /></div>
					</col>
					<col>
					<div class="input-group" >
						<span class="input-group-addon input-sm"> 学 历 </span>
						<input type="text" id="degree" class="form-control input-sm" style="width:150px" readonly /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm"> 学 科 </span>
						<input type="text" id="teachCourse" class="form-control input-sm" style="width:150px" readonly/></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm"> 职 称 </span>
						<input type="text" id="academicPos" class="form-control input-sm" style="width:150px" readonly/></div>
					</col>
				</cqu:formcols>
				</col>

				<col label="从事雏鹰计划组织指导工作情况概述（600字左右）" full="full">
					<textarea class="simple-editor" name="supervise_des" cols="105" rows="15">${teacherM.supervise_des }</textarea>
				</col>
				<col label="创新学院审核" full="full">
				<c:if test="${teacherM.status==0}">
					<input type="text" class="form-control input-sm" value="未审核"/></c:if>
				</col>
				<c:if test="${teacherM.status==1}">
					<input type="text" class="form-control input-sm" value="创管学院审核未通过"/></c:if>
				</col>
				<c:if test="${teacherM.status==2}">
					<input type="text" class="form-control input-sm" value="创管学院审核通过"/></c:if>
				</col>
				<col label="创新学院审核时间">
				<input type="text" class="form-control input-sm" name="innovation_date"
					 value="<fmt:formatDate value="${teacherM.audit_date}" pattern='yyyy-MM-dd HH:mm'/>"/>
				</col>
				<col label="创新学院审核意见" full="full">
					<textarea class="simple-editor" name="remark2" cols="105" rows="15">${teacherM.remark }</textarea>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>