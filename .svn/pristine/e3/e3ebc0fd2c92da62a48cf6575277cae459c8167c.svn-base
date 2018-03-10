<%@ page language="java" contentType="text/html; charset=UTF-8"
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
			<a href="${base}project/signup">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学生报名</a></li>
		</ul>
	</div>
	<form action="${base}project/txApplyJudge" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">
			<div class="formtitle">
				<span>项目详情</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称">
				<input type="text" class="form-control input-sm" name="project_name"
					datatype="*" id="project_name" value="${projectApply.project_name}"/>
				</col>
				<col label="学科分类">
				<input type="text" class="form-control input-sm" name="subject_cat_id"
					datatype="*" id="subject_cat_id" value="${projectApply.subject_name}"/>
				</col>				
				<col label="承担单位">
				<input type="text" class="form-control input-sm" name="school_name"
					datatype="*" id="school_name" value="${projectApply.school_name}"/>
				</col>
				<col label="项目实验基地">
				<input type="text" class="form-control input-sm" name="lab_name"
					datatype="*" id="lab_name" value="${projectApply.lab_name}"/>
				</col>
				<col label="项目负责人">
				<input type="text" class="form-control input-sm" name="leader_name"
					datatype="*" id="leader_name" value="${projectApply.leader_name}"/>
				</col>
				<col label="联系电话">
				<input type="text" class="form-control input-sm" name="phone_number"
					datatype="*" id="phone_number" value="${projectApply.phone_number}"/>
				</col>
				<col label="一、研究现状及意义" full="full">
					<textarea class="simple-editor" name="significance" cols="105">${projectApply.significance}</textarea>
				</col>
				<col label="二、研究目标、主要研究内容和拟解决的关键问题" full="full">
				</col>
				<col label="1.研究目标（包括科研方面的研究目标和人才培养方面的成效）" full="full">
					<textarea class="simple-editor" name="goal" cols="105">${projectApply.goal}</textarea>
				</col>
				<col label="2.主要研究内容" full="full">
					<textarea class="simple-editor" name="content" cols="105">${projectApply.content}</textarea>
				</col>
				<col label="3.拟解决的关键问题" full="full">
					<textarea class="simple-editor" name="key_problem" cols="105">${projectApply.key_problem}</textarea>
				</col>
				<col label="三、拟采取的研究方法、技术路线、实验方案及可行性分析" full="full">
					<textarea class="simple-editor" name="feasibility" cols="105">${projectApply.feasibility}</textarea>
				</col>
				<col label="四、进度安排" full="full">
					<textarea class="simple-editor" name="schedule" cols="105">${projectApply.schedule}</textarea>
				</col>
				<col label="五、附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj"
					 width: 770px;">
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
				<col label="申报教师信息">
				</col>
				<col label="姓名">
				<input type="text" class="form-control input-sm" name="name"
					datatype="*" id="name" value="${user.name}"/>
				</col>
				<col label="性别">
				<input type="text" class="form-control input-sm" name="school_name"
					datatype="*" id="school_name" value="${user.sex==0?"女":"男"}"/>
				</col>
				<col label="执教学校">
				<input type="text" class="form-control input-sm" name="class"
					datatype="*" id="class" value="${projectApply.school_name}"/>
				</col>
				<col label="学历">
				<input type="text" class="form-control input-sm" name="name"
					datatype="*" id="name" value="${user.degree}"/>
				</col>
				<col label="研究领域">
				<input type="text" class="form-control input-sm" name="mobile"
					datatype="*" id="mobile" value="${user.research_fild}"/>
				</col>
				<col label="从事专业">
				<input type="text" class="form-control input-sm" name="mobile"
					datatype="*" id="mobile" value="${user.major}"/>
				</col>
				<col label="联系电话">
				<input type="text" class="form-control input-sm" name="mobile"
					datatype="*" id="mobile" value="${user.mobile}"/>
				</col>
				<col label="QQ">
				<input type="text" class="form-control input-sm" name="qq"
					datatype="*" id="qq" value="${user.qq}"/>
				</col>
				<col label="微信">
				<input type="text" class="form-control input-sm" name="wechat"
					datatype="*" id="wechat" value="${user.wechat}"/>
				</col>
				<col label="个人简介" full="full">
					<textarea class="simple-editor" name="introduction" cols="105">${user.introduction}</textarea>
				</col>
			</cqu:formcols>
		</div>
	
	</form>
</body>
</html>