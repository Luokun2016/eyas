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
	
	function removetr(obj){
		$.dialog.confirm("确定是否删除该附件？", function(){
			$(obj).parent().parent().remove(); 
		}, function(){
		    return;
		});
	}
	
	function save(str){
		var type=$("#l_report_type").val();
		var significance=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		if(type==-1){
			$.dialog.tips("请选择学习报告类别");
			return false;
		}
		else if(significance==''){
			$.dialog.tips("报告描述不能为空");
			return false;
		}else if($("#fj tr").length<2)
		{ 
			$.dialog.tips("请上传报告附件");
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
			<a href="${base}report">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">修改学习报告</a></li>
		</ul>
	</div>
	<form action="${base}report/txEdit" method="post"
		class="form-horizontal validate-form">
		<input type="hidden" name="project_id" value="${learnReport.project_id}"/>
		<input type="hidden" name="l_report_id" value="${learnReport.l_report_id}"/>
		<input type="hidden" name="batch_id" value="${learnReport.batch_id}"/>
		<input type="hidden" name="flag" value="update"/>
		<div class="formbody">
			<div class="formtitle">
				<span>修改学习报告</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称">
				<input type="text" class="form-control input-sm" name="project_name"
					datatype="*" id="project_name" value="${projectApply.project_name}"/>
				</col>
				<col label="中期报告截止日期">
				<input type="text" class="form-control input-sm" name="center_date"
					datatype="*" value="${trainPlanMain.m_report_date}"/>
				</col>
				<col label="中期报告模板">
				<a href="${base}project/downLoad?attach_file=${batch.interim_report}"
						class="btn btn-default btn-sm"><span
						></span>点击下载</a>	
				</col>
				<col label="结业报告截止日期">
				<input type="text" class="form-control input-sm" name="end_date"
					datatype="*" value="${trainPlanMain.e_report_date}"/>
				</col>
				<col label="结业报告模板">
				<a href="${base}project/downLoad?attach_file=${batch.final_report}"
						class="btn btn-default btn-sm"><span
						></span>点击下载</a>	
				</col>
				<col label="学习报告名称" required="required">
				<input type="text" class="form-control input-sm" name="l_report_name"
					datatype="*" value="${learnReport.l_report_name}"/>
				</col>
				
				<col label="学习报告类别" required="required">
				<select name="l_report_type" id="l_report_type" class="form-control input-sm">
					<option value="0" ${learnReport.l_report_type==0?"selected='selected'":"" }>中期报告</option>
					<option value="1" ${learnReport.l_report_type==1?"selected='selected'":"" }>结业报告</option>
			    </select>
				</col>				

				<col label="报告描述" full="full">
					<textarea class="simple-editor" name="l_report_des" id="l_report_des" rows="10" cols="105">${learnReport.l_report_des}</textarea>
				</col>
				<col label="附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj"
					style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<c:if test="${learnReport.l_record_path!=null&&learnReport.l_record_path!=''}">
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
				<col label="&nbsp;">

				<button type="submit" class="btn btn-primary" id="submit_btn" onclick="return save()">
					<span class="glyphicon glyphicon-floppy-disk"></span>提交
				</button>
				<button type="reset" class="btn btn-default">
					<span class="glyphicon glyphicon-refresh"></span>重置
				</button>
				</col>
			</cqu:formcols>
		</div>
	
	</form>
</body>
</html>