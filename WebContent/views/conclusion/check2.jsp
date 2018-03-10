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
	if(str=='unpass')
	{
		var judge=$(document.getElementsByTagName("iframe")[2].contentWindow.document.body).html();
		if(judge==""){
			$.dialog.tips("请给出审核意见！");
			return false;
		}else{
			$("#conclusion_status").val("unpass");
			return true;
		}
	}else{
		$("#conclusion_status").val("pass");
		return true;
	}
}
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}conclusion/review">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">教师结题报告复审</a></li>
		</ul>
	</div>
	<form action="${base}conclusion/check2Conclusion" method="post"
		class="form-horizontal validate-form">
		<input type="hidden" name="conclusion_id"
			value="${conclusion.conclusion_id}" />
		<input type="hidden" name="conclusion_status" id="conclusion_status">
		<div class="formbody">
			<div class="formtitle">
				<span>教师结题报告复审</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称">
				<input type="text" class="form-control input-sm" name="project_name"
					datatype="*" value="${conclusion.project_name}" />
				</col>
				<col label="结题报告模板">
				<a
					href="${base}project/downLoad?attach_file=${conclusion.conclusion_path}"
					class="btn btn-default btn-sm"><span></span>点击下载</a>
				</col>
				<col label="学习报告名称">
				<input type="text" class="form-control input-sm"
					name="conclusion_name" datatype="*"
					value="${conclusion.conclusion_name}" />
				</col>
				<col label="报告描述" full="full">
				<textarea class="simple-editor" name="conclusion_des" rows="15"
					cols="105">${conclusion.conclusion_des}</textarea>
				</col>
				<col label="附件">
				<table class="table table-bordered" id="fj" style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<tr>
						<td><input type="text" class="form-control input-sm"
							id="doc_name" name="attach_name"
							value="${conclusion.conclusion_path}" readonly><input
							type="hidden" id="attach_file" name="attach_file"
							value="${conclusion.conclusion_path}"></td>
						<td><a
							href='${base}conclusion/downLoad1?attach_file=${conclusion.conclusion_path}'
							id='df' class='tablelink'>下载</a></td>
					</tr>
				</table>
				<div id="some_file_queue" /></div>
				</col>
				<col label="高校审核意见" full="full">
				<textarea class="simple-editor" name="college_remark" cols="105"
					rows="15">${conclusion.college_remark}</textarea>
				</col>
				<col label="复审意见" full="full">
				<textarea class="simple-editor" name="innovation_remark" cols="105"
					rows="15"></textarea>
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