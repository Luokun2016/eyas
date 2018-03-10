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
				url : "${base}recommend/getTeachers",
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
		}
	}
	
	function judge1(str){
		if(str=='unpass')
		{
			var judge=$(document.getElementsByTagName("iframe")[3].contentWindow.document.body).html();
			if(judge==""){
				$.dialog.tips("请给出审核意见！");
				return false;
			}else{
				$("#status").val("unpass");
				return true;
			}
		}else{
			$("#status").val("pass");
			return true;
		}
	}
	</script>
  </head>
  <body onload="getTeacherList()">
	<div class="place">
	<div class="pull-right backbtn">
			<a href="${base}${base}recommend/projectManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">项目推优</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>推优项目审核</span>
		</div>
		<form action="${base}recommend/txExaProject" method="post" class="form-horizontal validate-form">
			
			<input type="hidden" name="batch_id" value="${project.batch_id}"/>
			<input type="hidden" name="status" id="status"/>
			<cqu:formcols cols="1">
				<col label="推荐项目" required="required">
					<select name="project_id" id="projectId" class="form-control input-sm" >
						<option value="${project.project_id}" selected="selected">${project.project_name}</option>
					</select>
				</col>
				<col label="分工" full="full">
					<textarea class="simple-editor" name="assign" rows="12" cols="100"  >${project.assign}</textarea>
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
						<input type="text" id="teacher_mobile" class="form-control input-sm" style="width:100px" /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="teacher_course" class="form-control input-sm" style="width:100px" /></div>
					</col>
				</cqu:formcols>
				</col>
				<col label="研究成果获奖情况" full="full">
					<textarea class="simple-editor" name="achievement" cols="105" rows="15" >${project.achievement}</textarea>
				</col>
				<col label="雏鹰计划学院专题项目研究情况概述（600字左右）" full="full">
					<textarea class="simple-editor" name="description" cols="105" rows="15" >${project.description}</textarea>
				</col>
				<col label="审核意见" full="full">
					<textarea class="simple-editor" name="remark" cols="105" rows="15" >${project.remark }</textarea>
				</col>
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn"
					onclick="return judge1('pass')">
					<span class="glyphicon glyphicon-floppy-disk"></span>通过
				</button>
				<button type="submit" class="btn btn-primary" id="submit_btn"
					onclick="return judge1('unpass')">
					<span class="glyphicon glyphicon-floppy-disk"></span>不通过
				</button>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>