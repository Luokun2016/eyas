﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript" src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}project/choose">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">项目筛选与反馈</a></li>
		</ul>
	</div>
	<form action="${base}project/txChooseProjectAdd" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">
		<input type="hidden" name="project_id" id="project_id" value="${projectApply.project_id}"/>
		<input type="hidden" name="batch_id" id="batch_id" value="${projectApply.batch_id}"/>
			<div class="formtitle">
				<span>项目详情</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称" required="required">
				<input type="text" class="form-control input-sm" name="project_name"
					datatype="*" id="project_name" value="${projectApply.project_name}"/>
				</col>
				<col label="学科分类" required="required">
				<input type="text" class="form-control input-sm" name="subject_cat_id"
					datatype="*" id="subject_cat_id" value="${projectApply.subject_name}"/>
				</col>				
				<col label="承担单位" required="required">
				<input type="text" class="form-control input-sm" name="school_name"
					datatype="*" id="school_name" value="${projectApply.school_name}"/>
				</col>
				<col label="项目实验基地" required="required">
				<input type="text" class="form-control input-sm" name="lab_name"
					datatype="*" id="lab_name" value="${projectApply.lab_name}"/>
				</col>
				<col label="项目负责人" required="required">
				<input type="text" class="form-control input-sm" name="leader_name"
					datatype="*" id="leader_name" value="${projectApply.leader_name}"/>
				</col>
				<col label="联系电话" required="required">
				<input type="text" class="form-control input-sm" name="phone_number"
					datatype="*" id="phone_number" value="${projectApply.phone_number}"/>
				</col>
				<col label="一、研究现状及意义" full="full">
					<textarea class="simple-editor" name="significance" rows="10" cols="105">${projectApply.significance}</textarea>
				</col>
				<col label="二、研究目标、主要研究内容和拟解决的关键问题" full="full">
				</col>
				<col label="1.研究目标（包括科研方面的研究目标和人才培养方面的成效）" full="full">
					<textarea class="simple-editor" name="goal" rows="10" cols="105">${projectApply.goal}</textarea>
				</col>
				<col label="2.主要研究内容" full="full">
					<textarea class="simple-editor" name="content" rows="10" cols="105">${projectApply.content}</textarea>
				</col>
				<col label="3.拟解决的关键问题" full="full">
					<textarea class="simple-editor" name="key_problem" rows="10" cols="105">${projectApply.key_problem}</textarea>
				</col>
				<col label="三、拟采取的研究方法、技术路线、实验方案及可行性分析" full="full">
					<textarea class="simple-editor" name="feasibility" rows="10" cols="105">${projectApply.feasibility}</textarea>
				</col>
				<col label="四、进度安排" full="full">
					<textarea class="simple-editor" name="schedule" rows="10" cols="105">${projectApply.schedule}</textarea>
				</col>
				<col label="五、附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj"
					 style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<c:if test="${projectApply.project_attach!=null&&projectApply.project_attach!=''}">
					<tr>
						<td><input type="text" class="form-control input-sm"
							name="attach_name" value="${projectApply.project_attach}" readonly>
							<input type="hidden" name="attach_file"
							value="${projectApply.project_attach}"></td>
						<td><a
							href='${base}project/applyDownLoad?attach_file=${projectApply.project_attach}'
							id='df' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
				    </c:if>
				</table>
				<div id="some_file_queue" /></div>
				</col>

				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn">
					<span class="glyphicon glyphicon-floppy-disk"></span>选择该项目
				</button>
				</col>		
			</cqu:formcols>
		</div>
	
	</form>
</body>
</html>