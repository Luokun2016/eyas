<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<html>

<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}study/queryProgramme">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">查看培养计划</a></li>
		</ul>
	</div>
<div class="rightinfo">
	<div class="formtitle">
		<span>项目计划详情</span>
	</div>

<form class="form-horizontal validate-form">
	<cqu:formcols cols="1" >
		<col label="项目名称">
		<input type="text" name="project_name" class="form-control input-sm"
			value="${pa.project_name}" readonly />
		</col>

		<col label="学科分类">
		<input type="text" name="subject_name" class="form-control input-sm"
			value="${pa.subject_name}" readonly />
		</col>

		<col label="承担单位">
		<input type="text" name="school_name" class="form-control input-sm"
			value="${pa.school_name}" readonly />
		</col>

		<col label="项目负责人">
		<input type="text" name=user_name class="form-control input-sm"
			value="${pa.leader_name}" readonly />
		</col>


		<col label="中期报告截止日期" >
		<input type="text" 
			class="form-control input-sm " name="m_report_date" 		 
			value="${trainingPlanMain.m_report_date}" pattern='yyyy-MM-dd HH:mm' readonly/>
		</col>

		<col label="结业报告截止日期" >
		<input type="text" 
			class="form-control input-sm " name="e_report_date"
			
			value="${trainingPlanMain.e_report_date}" pattern='yyyy-MM-dd HH:mm' readonly/>
		</col>

		<col label="学习记录提交次数" >
		<input type="text" name="l_record_time" 
			class="form-control input-sm" 
			value="${trainingPlanMain.l_record_time}"  readonly />
		</col>

		<col label="学习记录截止日期" >
		<input type="text" 
			class="form-control input-sm " name="l_record_date"			
			value="${trainingPlanMain.l_record_date}" pattern='yyyy-MM-dd HH:mm' readonly />
		</col>
		<col label="项目培养计划" full="full">
				<textarea class="simple-editor" name="plan_content" rows="10"
					cols="111" readonly>${trainingPlanDetail.plan_content} </textarea>
		</col>	
			
	</cqu:formcols>
</form>		
</div>




</body>
	</html>
</cqu:right>