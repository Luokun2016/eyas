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
	function getTchType(){
		var project_id = $("#projectId").val();
		if(!(project_id==-1)){
			$("#tType").empty();
			$("#tType").append(
					"<option value='"+-1+"'>请选择推荐类型</option>");
			$("#tType").append(
							"<option value='"+2+"'>优秀高校导师</option>");
			$("#tType").append(
					"<option value='"+1+"'>优秀中学导师</option>");
		}else{
			$("#tType").empty();
			$("#tType").append("<option value='"+-1+"'>请选择推荐类型</option>");
			$("#teacherId").empty();
			$("#teacherId").append("<option value='"+-1+"'>请选择老师</option>");
			$("#schoolName").val("");
			$("#major").val("");
			$("#degree").val("");
			$("#teachCourse").val("");
			$("#academicPos").val("");
		}
	}
	
	function getTeachers() {
		var project_id = $("#projectId").val();
		var tType = $("#tType").val();
		if(!(tType==-1)){
			$.ajax({
				type:"POST",
				url : "${base}recommend/getTchTeachers",
				data:{"project_id":project_id,"t_type":tType},
				dataType:"json",
				success:function(data){
					if(""==data.teacherList){
						$("#teacherId").empty();
						$("#teacherId").append("<option value='"+-1+"'>没有老师</option>");
					}else{
						var listT=data.teacherList;
						$("#teacherId").empty();
						$("#teacherId").append(
										"<option value='"+-1+"'>请选择老师</option>");
						for (var i = 0; i < listT.length; i++) {
							$("#teacherId").append("<option value='"+listT[i].user_id+"'>"+listT[i].name+"</option>");
						}
					}
				}
			});
		}else{
			$("#teacherId").empty();
			$("#teacherId").append("<option value='"+-1+"'>请选择老师</option>");
			$("#schoolName").val("");
			$("#major").val("");
			$("#degree").val("");
			$("#teachCourse").val("");
			$("#academicPos").val("");
		}
	}
	
	function getTeaInfo(){
		var teacher_id = $("#teacherId").val();
		if(!(teacher_id==-1)){
		$.ajax({
			type:"POST",
			url : "${base}recommend/getTeaInfo",
			data:{"teacher_id":teacher_id},
			dataType:"json",
			success:function(data){
				if(!(data.teacherM=="")){
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
				}else{
					$("#schoolName").val("");
					$("#major").val("");
					$("#degree").val("");
					$("#teachCourse").val("");
					$("#academicPos").val("");
				}
			},
			error:function(jqXHR){
				alert("发生错误："+jqXHR.status);
			}
		});
		}else{
			$("#schoolName").val("");
			$("#major").val("");
			$("#degree").val("");
			$("#teachCourse").val("");
			$("#academicPos").val("");
		}
	}
	
	function save(){
		var projectId=$("#projectId").val();
		var typeId=$("#tType").val();
		var teacher_Id=$("#teacherId").val();
		var text1=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		if(projectId==-1){
			$.dialog.tips("请选择某一个项目");
			return false;
		}else if(typeId==-1){
			$.dialog.tips("请选择推荐类型");
			return false;
		}else if(typeId==-1){
			$.dialog.tips("请选择推荐老师");
			return false;
		}else if(text1==''){
			$.dialog.tips("从事雏鹰计划组织指导工作情况概述不能为空");
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
			<a href="${base}${base}recommend/teacherManage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">导师推优</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>添加导师推优</span>
		</div>
		<form action="${base}recommend/txAddTeacher" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="batch_id" id="batchId" value="${batchId}"/>
			<cqu:formcols cols="1">
				<col label="推荐项目" required="required">
					<select name="project_id" id="projectId" class="form-control input-sm" onchange="getTchType()" >
						<option value="-1" selected="selected">请选择项目</option>
						<c:forEach items="${listP}" var="l" varStatus="i">
							<option value="${l.project_id }" ${project_id=="${l.project_id}"?"selected='selected'":""} >${l.project_name }</option>
						</c:forEach>
					</select>
				</col>
				<col label="推荐类型" required="required">
					<select name="t_type" id="tType" class="form-control input-sm" onchange="getTeachers()">
					<option value="-1" selected="selected">请选择推荐类型</option>
					</select>
				</col>
				<col label="推荐老师" required="required">
					<select name="teacher_id" id="teacherId" class="form-control input-sm" onchange="getTeaInfo()" >
						<option value="-1" selected="selected">请选择老师</option>
					</select>
				</col>
				<col label="所在单位">
					<div class="input-group">
						<input type="text" id="schoolName" class="form-control input-sm" style="width:440px"  /></div>
				</col>
				<col label="导师信息" >
				<cqu:formcols cols="2">
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm"> 专 业 </span>
						<input type="text" id="major" class="form-control input-sm" style="width:150px"  /></div>
					</col>
					<col>
					<div class="input-group" >
						<span class="input-group-addon input-sm"> 学 历 </span>
						<input type="text" id="degree" class="form-control input-sm" style="width:150px"  /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm"> 学 科 </span>
						<input type="text" id="teachCourse" class="form-control input-sm" style="width:150px" /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm"> 职 称 </span>
						<input type="text" id="academicPos" class="form-control input-sm" style="width:150px" /></div>
					</col>
				</cqu:formcols>
				</col>

				<col label="从事雏鹰计划组织指导工作情况概述（600字左右）" full="full">
					<textarea class="simple-editor" name="supervise_des" cols="105" rows="15"></textarea>
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