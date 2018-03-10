<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript"
	src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
<script language="javascript">
function judge1(str){
	var r=$("#role").val();
	if(r==4){
		r=1;
	}else{
		r=2;
	}
	if(str=='unpass')
	{
		var judge=$(document.getElementsByTagName("iframe")[r].contentWindow.document.body).html();
		if(judge==""){
			$.dialog.tips("请给出审核意见！");
			return false;
		}else{
			$("#l_report_status").val("unpass");
			return true;
		}
	}else{
		$("#l_report_status").val("pass");
		return true;
	}
}
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}report/check">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学习报告审核</a></li>
		</ul>
	</div>
	<form action="${base}report/txReportCheck" method="post" class="form-horizontal validate-form">
		<div class="formbody">
		<input type="hidden" name="l_report_id" value="${learnReport.l_report_id}">
		<input type="hidden" name="l_report_status" id="l_report_status">
		<input type="hidden" name="role" id="role" value="${role}">
			<div class="formtitle">
				<span>学习报告审核</span>
			</div>
			<cqu:formcols cols="1">
				<col label="学习报告名称">
				<input type="text" class="form-control input-sm"
					name="l_report_name" value="${learnReport.l_report_name}" />
				</col>
				<col label="学习报告类别">
				<input type="text" class="form-control input-sm"
					name="l_report_type" id="l_report_type"
					value="${learnReport.l_report_type==0?'中期报告':'结业报告'}" />
				</col>

				<col label="学习报告描述" full="full">
				<textarea class="simple-editor" name="l_report_des" rows="10"
					cols="105">${learnReport.l_report_des}</textarea>
				</col>
				<col label="附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj" style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<c:if
						test="${learnReport.l_record_path!=null&&learnReport.l_record_path!=''}">
						<tr>
							<td><input type="text" class="form-control input-sm"
								name="attach_name" value="${learnReport.l_record_path}" readonly>
								<input type="hidden" name="attach_file"
								value="${learnReport.l_record_path}"></td>
							<td><a
								href='${base}report/downLoad?attach_file=${learnReport.l_record_path}'
								id='df' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						</tr>
					</c:if>
				</table>
				<div id="some_file_queue" /></div>
				</col>
				<c:if test="${role==4||role==6}">
					<col label="教师审核时间">
					<input type="text" class="form-control input-sm"
						name="teacher_date"
						value="<fmt:formatDate value="${learnReport.teacher_date}" pattern='yyyy-MM-dd HH:mm'/>" />
					</col>
					<col label="教师审核结果">
					<c:if test="${learnReport.l_report_status==0}">
						<input type="text" class="form-control input-sm"
							name="teacher_result" value="未审核" />
					</c:if>
					<c:if test="${learnReport.l_report_status==1}">
						<input type="text" class="form-control input-sm"
							name="teacher_result" value="审核未通过" />
					</c:if>
					<c:if test="${learnReport.l_report_status>1}">
						<input type="text" class="form-control input-sm"
							name="teacher_result" value="审核通过" />
					</c:if>
					</col>
					<col label="教师审核意见" full="full">
					<textarea class="simple-editor" name="teacher_remark" rows="10"
						cols="105">${learnReport.teacher_remark}</textarea>
					</col>
				</c:if>
				<c:if test="${role==6}">
				<col label="高校审核时间">
				<input type="text" class="form-control input-sm" name="college_date"
					value="<fmt:formatDate value="${learnReport.college_date}" pattern='yyyy-MM-dd HH:mm'/>" />
				</col>
					<col label="高校审核结果">
					<c:if test="${learnReport.l_report_status<3}">
						<input type="text" class="form-control input-sm"
							name="college_result" value="未审核" />
					</c:if>
					<c:if test="${learnReport.l_report_status==3}">
						<input type="text" class="form-control input-sm"
							name="college_result" value="审核未通过" />
					</c:if>
					<c:if test="${learnReport.l_report_status>3}">
						<input type="text" class="form-control input-sm"
							name="college_result" value="审核通过" />
					</c:if>
					</col>
					<col label="高校审核意见" full="full">
					<textarea class="simple-editor" name="teacher_remark" rows="10"
						cols="105">${learnReport.college_remark}</textarea>
					</col>
					</c:if>
					<col label="审核意见" full="full">
					<textarea class="simple-editor" name="remark" id="remark"
						rows="10" cols="105"></textarea>
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
		</div>
	</form>
</body>
</html>