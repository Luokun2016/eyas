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
	function getTeacherList() {
		var project_id = $("#projectId").val();
		if(project_id==-1){
			$("#tutor_name").empty();
			$("#tutor_mobile").empty();
			$("#tutor_course").empty();
			$("#teacher_name").empty();
			$("#teacher_mobile").empty();
			$("#teacher_course").empty();
		}else{
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
			$.ajax({
				type:"POST",
				url : "${base}recommend/getListS",
				data:{"project_id":project_id},
				dataType:"json",
				success:function(data){
					if(""==data.listStudents){
						$("#studentId").empty()
						$("#studentId").append("<option value='"+-1+"'>没有学生</option>");
					}else{
						var listS=data.listStudents;
						var batchId=listS[0].batch_id;
						$("#batchId").val(batchId);
						$("#studentId").empty()
						$("#studentId").append(
										"<option value='"+-1+"'>请选择学生</option>");
						for (var i = 0; i < listS.length; i++) {
							$("#studentId").append("<option value='"+listS[i].user_id+"'>"+listS[i].name+"</option>");
						}
					}
				}
			});
		}
	}
	
	function getStudentsList(){
		var student_id = $("#studentId").val();
		if(student_id==-1){
			$("#schoolName").empty();
			$("#studentGrade").empty();
			$("#studentClass").empty();
		}else{
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
	}
	
	function save(){
		var projectId=$("#projectId").val();
		var studentId=$("#studentId").val();
		var text1=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		var text2=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
		if(projectId==-1){
			$.dialog.tips("请选择某一个项目");
			return false;
		}else if(studentId==-1){
			$.dialog.tips("请选择一个学生");
			return false;
		}else if(text1==''){
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
  <body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}${base}recommend/studentManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学生推优</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>添加推优学生</span>
		</div>
		<form action="${base}recommend/txAddStudent" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="batch_id" id="batchId" value="${batchId}" />
			<cqu:formcols cols="1">
				<col label="推荐项目" required="required">
					<select name="project_id" id="projectId" class="form-control input-sm" onchange="getTeacherList()" >
						<option value="-1" selected="selected">请选择项目</option>
						<c:forEach items="${listP}" var="l" varStatus="i">
							<option value="${l.project_id }" ${project_id=="${l.project_id}"?"selected='selected'":""} >${l.project_name }</option>
						</c:forEach>
					</select>
				</col>
				<col label="推荐学生" required="required">
					<select name="student_id" id="studentId" class="form-control input-sm" onchange="getStudentsList()" >
						<option value="-1" selected="selected">请选择学生</option>
					</select>
				</col>
				<col label="学生信息" >
				<cqu:formcols cols="3">
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学校</span>
						<input type="text" id="schoolName" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col>	
					<div class="input-group">
						<span class="input-group-addon input-sm">年级</span>
						<input type="text" id="studentGrade" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">班级</span>
						<input type="text" id="studentClass" class="form-control input-sm" style="width:100px" /></div>
					</col>
				</cqu:formcols>
				</col>
				<col label="导师信息" >
				<cqu:formcols cols="3">
					<col >
					<div class="input-group">
						<span class="input-group-addon input-sm">导师</span>
						<input type="text" id="tutor_name" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col >
					<div class="input-group">
						<span class="input-group-addon input-sm">电话</span>
						<input type="text" id="tutor_mobile" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="tutor_course" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col>
					<div class="input-group" >
						<span class="input-group-addon input-sm">老师</span>
						<input type="text" id="teacher_name" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">电话</span>
						<input type="text" id="teacher_mobile" class="form-control input-sm" style="width:100px"/></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="teacher_course" class="form-control input-sm" style="width:100px"/></div>
					</col>
				</cqu:formcols>
				</col>
				<col label="研究成果获奖情况" full="full">
					<textarea class="simple-editor" name="achievement" cols="105" rows="15"></textarea>
				</col>
				<col label="雏鹰计划学院专题项目研究情况概述（600字左右）" full="full">
					<textarea class="simple-editor" name="description" cols="105" rows="15"></textarea>
				</col>
				<col label="&nbsp;">
					<button type="submit" class="btn btn-primary"  onclick="return save()"><span class="glyphicon glyphicon-floppy-disk"></span>提交</button>
					<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>