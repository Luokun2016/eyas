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
<script language="javascript">
	function status() {
		var status=$("#conclusionStatus").val();
		var i=Number(status);
		switch (i) {
		case 0:
			$("#status1").val("未审核");
			$("#status2").val("未审核");
			break;
		case 1:
			$("#status1").val("高校审核未通过");
			$("#status2").val("未审核");
			break;
		case 2:
			$("#status1").val("高校审核通过");
			$("#status2").val("未审核");
			break;
		case 3:
			$("#status1").val("高校审核通过");
			$("#status2").val("创新学院未通过");
			break;
		case 4:
			$("#status1").val("高校审核通过");
			$("#status2").val("创新学院通过");
			break;
			
		default:
			break;
		}
	}
	
	function change() {
		var listMessage=listP;
	}

	var uploadify;	
	$(function() {
		$("#file_upload").uploadify(
				{	
					queueID : 'some_file_queue',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}report/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj").style.display="";
						if($("#fj tr").length>1)
							$("#fj tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name" name="attach_name" readonly><input type="hidden" id="attach_file" name="attach_file"></td>';
						content+="<td><a href='#' id='df' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj").append(content);
						$("#doc_name").val(file.name);
						$("#attach_file").val(data);
						document.getElementById("df").href="${base}report/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
					}
				});
	});

</script>
</head>
<body onload="status()">
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}conclusion/manage">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">添加结题报告</a></li>
		</ul>
	</div>
	<form action="${base}conclusion/manage" method="post"
		class="form-horizontal validate-form">
		<input type="hidden" name="batch_id" value="${conclusion.batch_id}"/>
		<input type="hidden" name="conclusion_id" value="${conclusion.conclusion_id}"/>
		<input type="text" name="conclusion_status" id="conclusionStatus" value="${conclusion.conclusion_status}"/>
		<div class="formbody">
			<div class="formtitle">
				<span>结题报告初审</span>
			</div>
			<cqu:formcols cols="1">
				<col label="学习报告名称" required="required">
				<input type="text" class="form-control input-sm" name="l_report_name" datatype="*" value="${conclusion.conclusion_name}"/>
				</col>			
				<col label="报告描述" full="full">
					<textarea class="simple-editor" name="l_report_des" id="l_report_des" rows="15" cols="105" >${conclusion.conclusion_des}</textarea>
				</col>
				<col label="附件">
				<table class="table table-bordered" id="fj" style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<tr>
						<td><input type="text" class="form-control input-sm" id="doc_name" name="attach_name" value="${conclusion.conclusion_path}" readonly><input type="hidden" id="attach_file" name="attach_file" value="${conclusion.conclusion_path}"></td>
						<td><a href='${base}conclusion/downLoad1?attach_file=${conclusion.conclusion_path}' id='df' class='tablelink'>下载</a></td>
					</tr>
				</table>
				</col>
				<col label="高校审核" full="full">
					<input type="text" class="form-control input-sm" id="status1"/>
				</col>
				<col label="审核意见" full="full">
					<textarea class="simple-editor" name="remark1" cols="105" rows="12">${conclusion.college_remark}</textarea>
				</col>
				<col label="创新学院审核" full="full">
					<input type="text" class="form-control input-sm" id="status2"/>
				</col>
				<col label="创新学院审核意见" full="full">
					<textarea class="simple-editor" name="remark2" cols="105" rows="12">${conclusion.innovation_remark }</textarea>
				</col>
			</cqu:formcols>
		</div>
	
	</form>
</body>
</html>