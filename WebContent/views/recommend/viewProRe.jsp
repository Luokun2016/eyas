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
	
	function save(){
		var type=$("#projectId").val();
		var text1=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		var text2=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
		var text3=$(document.getElementsByTagName("iframe")[2].contentWindow.document.body).html();
		if(type==-1){
			$.dialog.tips("请选择推优的项目");
			return false;
		}
		else if(text1==''){
			$.dialog.tips("分工情况不能为空");
			return false;
		}else if(text2==''){
			$.dialog.tips("研究成果获奖情况不能为空");
			return false;
		}else if(text3==''){
			$.dialog.tips("雏鹰计划学院专题项目研究情况概述不能为空");
			return false;
		}else{
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
			<span>修改推优项目</span>
		</div>
		<form action="${base}recommend/txEditProject" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="batch_id" value="${project.batch_id}"/>
			<cqu:formcols cols="1">
				<col label="推荐项目" required="required">
					<select name="project_id" id="projectId" class="form-control input-sm" >
						<option value="${project.project_id}" selected="selected">${project.project_name}</option>
					</select>
				</col>
				<col label="分工" full="full">
					<textarea class="simple-editor" name="assign" rows="12" cols="100">${project.assign}</textarea>
				</col>
				<col label="导师信息" >
				<cqu:formcols cols="3">
					<col >
					<div class="input-group">
						<span class="input-group-addon input-sm">导师</span>
						<input type="text" id="tutor_name" class="form-control input-sm" style="width:100px" readonly /></div>
					</col>
					<col >
					<div class="input-group">
						<span class="input-group-addon input-sm">电话</span>
						<input type="text" id="tutor_mobile" class="form-control input-sm" style="width:100px" readonly /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="tutor_course" class="form-control input-sm" style="width:100px" readonly /></div>
					</col>
					<col>
					<div class="input-group" >
						<span class="input-group-addon input-sm">老师</span>
						<input type="text" id="teacher_name" class="form-control input-sm" style="width:100px" readonly /></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">电话</span>
						<input type="text" id="teacher_mobile" class="form-control input-sm" style="width:100px" readonly/></div>
					</col>
					<col>
					<div class="input-group">
						<span class="input-group-addon input-sm">学科</span>
						<input type="text" id="teacher_course" class="form-control input-sm" style="width:100px" readonly/></div>
					</col>
				</cqu:formcols>
				</col>
				<col label="研究成果获奖情况" full="full">
					<textarea class="simple-editor" name="achievement" cols="105" rows="15">${project.achievement}</textarea>
				</col>
				<col label="雏鹰计划学院专题项目研究情况概述（600字左右）" full="full">
					<textarea class="simple-editor" name="description" cols="105" rows="15">${project.description}</textarea>
				</col>
				<col label="创新学院审核" full="full">
				<c:if test="${project.status==0}">
					<input type="text" class="form-control input-sm" value="未审核"/></c:if>
				</col>
				<c:if test="${project.status==1}">
					<input type="text" class="form-control input-sm" value="创管学院审核未通过"/></c:if>
				</col>
				<c:if test="${project.status==2}">
					<input type="text" class="form-control input-sm" value="创管学院审核通过"/></c:if>
				</col>
				<col label="创新学院审核时间">
				<input type="text" class="form-control input-sm" name="innovation_date"
					 value="<fmt:formatDate value="${project.audit_date}" pattern='yyyy-MM-dd HH:mm'/>"/>
				</col>
				<col label="创新学院审核意见" full="full">
					<textarea class="simple-editor" name="remark2" cols="105" rows="15">${project.remark }</textarea>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>