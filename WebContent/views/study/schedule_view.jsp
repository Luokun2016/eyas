<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript"
	src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />

<script type="text/javascript">
	function compare() {
		var mReportDate = $("#m_report_date").val(); // 中期报告截止日期
		var eReportDate = $("#e_report_date").val(); // 结业报告截止日期
		var lRecordTime = $("#l_record_time").val(); // 学习记录提交次数
		var lRecordDate = $("#l_record_date").val(); // 学习记录截止日期
		if (mReportDate == '' || eReportDate == '' || lRecordTime == ''
				|| lRecordDate == '') {
			$.dialog.tips("中期报告截止日期、结业报告截止日期、学习记录提交次数和学习记录截止日期不能为空");
			return false;
		} else {
			var now = new Date();
			var d1 = new Date(mReportDate.replace(/\-/g, "\/"));
			var d2 = new Date(eReportDate.replace(/\-/g, "\/"));
			var d3 = new Date(lRecordDate.replace(/\-/g, "\/"));
			if (now >= d1){
				$.dialog.tips("中期报告截止日期应该大于当前时间");
				return false;
			}else if (d1 >= d2){
				$.dialog.tips("结业报告截止日期应大于中期报告截止日期");
				return false;
			}else if (d3 >= d2){
				$.dialog.tips("结业报告截止日期应大于学习记录截止日期");
				return false;
			}else if(lRecordTime<1){
				$.dialog.tips("学习记录提交次数大于等于1");
				return false;
			}else
				return true;
		}
	}
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}study/index">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">设置培养计划</a></li>
			<li><a href="#">进度安排</a></li>
		</ul>
	</div>

	<form action="${base}study/txSetSchedule" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">

			<div class="formtitle">
				<span>进度安排</span>
			</div>
			<input type="hidden" name="batch_id" value="${project.batch_id}" />
			<input type="hidden" name="project_id" value="${project.project_id}" />
			<input type="hidden" name="plan_id"
				value="${trainingPlanMain.plan_id}" />

			<cqu:formcols cols="1">
				<col label="项目名称">
				<input type="text" name="project_name" class="form-control input-sm"
					value="${project.project_name}" readonly />
				</col>

				<col label="学科分类">
				<input type="text" name="subject_name" class="form-control input-sm"
					value="${project.subject_name}" readonly />
				</col>

				<col label="承担单位">
				<input type="text" name="school_name" class="form-control input-sm"
					value="${project.school_name}" readonly />
				</col>

				<col label="项目负责人">
				<input type="text" name=user_name class="form-control input-sm"
					value="${project.leader_name}" readonly />
				</col>


				<col label="中期报告截止日期" required="required">
				<input type="text" required="required"
					class="form-control input-sm Wdate datetime" name="m_report_date"
					datatype="*" id=m_report_date
					value="<fmt:formatDate value="${trainingPlanMain.m_report_date}" pattern='yyyy-MM-dd HH:mm'/>" />
				</col>

				<col label="学习记录提交次数" required="required">
				<input type="text" name="l_record_time" required="required"
					class="form-control input-sm"
					value="${trainingPlanMain.l_record_time}" datatype="n"
					id="l_record_time" />
				</col>

				<col label="学习记录截止日期" required="required">
				<input type="text" required="required"
					class="form-control input-sm Wdate datetime" name="l_record_date"
					datatype="*" id="l_record_date"
					value="<fmt:formatDate value="${trainingPlanMain.l_record_date}" pattern='yyyy-MM-dd HH:mm'/>" />
				</col>

				<col label="结业报告截止日期" required="required">
				<input type="text" required="required"
					class="form-control input-sm Wdate datetime" name="e_report_date"
					datatype="*" id="e_report_date"
					value="<fmt:formatDate value="${trainingPlanMain.e_report_date}" pattern='yyyy-MM-dd HH:mm'/>" />
				</col>

				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn"
					onclick="return compare()">
					<span class="glyphicon glyphicon-floppy-disk"></span>提交
				</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button type="reset" class="btn btn-default">
					<span class="glyphicon glyphicon-refresh"></span>重置
				</button>
				</col>
			</cqu:formcols>
		</div>
	</form>



</body>
	</html>
</cqu:right>