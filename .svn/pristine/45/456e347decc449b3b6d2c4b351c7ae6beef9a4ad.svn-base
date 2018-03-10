<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<!DOCTYPE html>
<html>
   <head>
   <script type="text/javascript" src="${base}assets/jq/jquery-1.10.2.min.js"></script>
	<jsp:include page="../common/common.jsp"></jsp:include>
	<script type="text/javascript">
	function getInitList(){
		var project_id = $("#projectId").val();
		$.ajax({
			type:"POST",
			url : "${base}recommend/getStuTeachers",
			data:{"project_id":project_id},
			dataType:"json",
			success:function(data){
				if(!data.teacherList==""){
					var teacherList=data.teacherList;
					var tutor_name=teacherList[0].name;
					var tutor_mobile=teacherList[0].mobile;
					var tutor_course=teacherList[0].teach_course;
					$("#tutor_name").val(tutor_name);
					$("#tutor_mobile").val(tutor_mobile);
					$("#tutor_course").val(tutor_course);
					var teacher_name=teacherList[1].name;
					var teacher_mobile=teacherList[1].mobile;
					var teacher_course=teacherList[1].teach_course;
					$("#teacher_name").val(teacher_name);
					$("#teacher_mobile").val(teacher_mobile);
					$("#teacher_course").val(teacher_course);
				}else{
					$("#tutor_name").empty();
					$("#tutor_mobile").empty();
					$("#tutor_course").empty();
					$("#teacher_name").empty();
					$("#teacher_mobile").empty();
					$("#teacher_course").empty();
				}
			},
			
			error:function(jqXHR){
				alert("发生错误："+jqXHR.status);
			}
		});
		var student_id = $("#studentId").val();
		$.ajax({
			type:"POST",
			url : "${base}recommend/getStudents",
			data:{"student_id":student_id},
			dataType:"json",
			success:function(data){
				if(!data.stuMessage==""){
					var student=data.stuMessage;
					var schoolName=student.school_name;
					var studentGrade=student.grade_name;
					var studentClass=student.class_name;
					$("#schoolName").val(schoolName);
					$("#studentGrade").val(studentGrade);
					$("#studentClass").val(studentClass);
				}
			},
			error:function(jqXHR){
				alert("发生错误："+jqXHR.status);
			}
		});
	}
	
	function save(){
		var text1=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		var text2=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
		if(text1==''){
			$.dialog.tips("研究成果获奖情况不能为空");
			return false;
		}else if(text2==''){
			$.dialog.tips("雏鹰计划学院专题项目研究情况概述不能为空");
			return false;
		}else{
			return true;
		}
	}
	</script>
  </head>
  <body onload="getInitList()" >
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学生推优</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>发布</span>
		</div>
		<form action="${base}recommend/txEditStudent" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="project_id" id="projectId" value="${projectM.project_id }"/>
			<input type="hidden" name="student_id" id="studentId" value="${studentM.student_id }"/>
			<input type="hidden" name="batch_id" value="${studentM.batch_id }" />
			<cqu:formcols cols="1">
				<col label="推荐项目" required="required">
					<input  name="project_name"  class="form-control input-sm" value="${projectM.project_name }"></input>
				</col>
				<col label="推荐学生" required="required">
					<input  name="name" class="form-control input-sm" value="${studentM.name }"></input>
				</col>
				<col label="学生信息" >
				<cqu:formcols cols="3">
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学校</span>
						<input type="text" id="schoolName" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col>	
					<div class="input-group">
						<span class="input-group-addon input-sm">年级</span>
						<input type="text" id="studentGrade" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">班级</span>
						<input type="text" id="studentClass" class="form-control input-sm" style="width:100px"  /></div>
					</col>
				</cqu:formcols>
				</col>
				<col label="导师信息" >
				<cqu:formcols cols="3">
					<col >
					<div class="input-group">
						<span class="input-group-addon input-sm">导师</span>
						<input type="text" id="tutor_name" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col >
					<div class="input-group">
						<span class="input-group-addon input-sm">电话</span>
						<input type="text" id="tutor_mobile" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="tutor_course" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col>
					<div class="input-group" >
						<span class="input-group-addon input-sm">老师</span>
						<input type="text" id="teacher_name" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">电话</span>
						<input type="text" id="teacher_mobile" class="form-control input-sm" style="width:100px"  /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="teacher_course" class="form-control input-sm" style="width:100px" /></div>
					</col>
				</cqu:formcols>
				</col>
				<col label="研究成果获奖情况" full="full">
					<textarea class="simple-editor" name="achievement" cols="105" rows="15">${studentM.achievement }</textarea>
				</col>
				<col label="雏鹰计划学院专题项目研究情况概述（600字左右）" full="full">
					<textarea class="simple-editor" name="description" cols="105" rows="15">${studentM.description }</textarea>
				</col>
				<col label="创新学院审核" full="full">
				<c:if test="${studentM.status==0}">
					<input type="text" class="form-control input-sm" value="未审核"/></c:if>
				</col>
				<c:if test="${studentM.status==1}">
					<input type="text" class="form-control input-sm" value="创管学院审核未通过"/></c:if>
				</col>
				<c:if test="${studentM.status==2}">
					<input type="text" class="form-control input-sm" value="创管学院审核通过"/></c:if>
				</col>
				<col label="创新学院审核时间">
				<input type="text" class="form-control input-sm" name="innovation_date"
					 value="<fmt:formatDate value="${studentM.audit_date}" pattern='yyyy-MM-dd HH:mm'/>"/>
				</col>
				<col label="创新学院审核意见" full="full">
					<textarea class="simple-editor" name="remark2" cols="105" rows="15">${studentM.remark }</textarea>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>