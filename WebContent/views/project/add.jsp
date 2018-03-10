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
	var num=0;
	var uploadify;	
	$(function() {
		$("#file_upload").uploadify(
				{	
					queueID : 'some_file_queue',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}project/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj").style.display="";
						if($("#fj tr").length>1)
							$("#fj tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name_'+num+'" name="attach_name" readonly><input type="hidden" id="attach_file_'+num+'" name="attach_file"></td>';
						content+="<td><a href='#' id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj").append(content);
						$("#doc_name_"+num).val(file.name);
						$("#attach_file_"+num).val(data);
						document.getElementById("df_"+num).href="${base}project/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
						num++;
					}
				});
		$("#file_upload1").uploadify(
				{	
					queueID : 'some_file_queue1',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}project/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj1").style.display="";
						if($("#fj1 tr").length>1)
							$("#fj1 tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name_'+num+'" name="attach_name1" readonly><input type="hidden" id="attach_file_'+num+'" name="attach_file1"></td>';
						content+="<td><a href='#' id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj1").append(content);
						$("#doc_name_"+num).val(file.name);
						$("#attach_file_"+num).val(data);
						document.getElementById("df_"+num).href="${base}project/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
						num++;
					}
				});
		$("#file_upload2").uploadify(
				{	
					queueID : 'some_file_queue2',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}project/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj2").style.display="";
						if($("#fj2 tr").length>1)
							$("#fj2 tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name_'+num+'" name="attach_name2" readonly><input type="hidden" id="attach_file_'+num+'" name="attach_file2"></td>';
						content+="<td><a href='#' id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj2").append(content);
						$("#doc_name_"+num).val(file.name);
						$("#attach_file_"+num).val(data);
						document.getElementById("df_"+num).href="${base}project/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
						num++;
					}
				});
		$("#file_upload3").uploadify(
				{	
					queueID : 'some_file_queue3',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}project/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj3").style.display="";
						if($("#fj3 tr").length>1)
							$("#fj3 tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name_'+num+'" name="attach_name3" readonly><input type="hidden" id="attach_file_'+num+'" name="attach_file3"></td>';
						content+="<td><a href='#' id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj3").append(content);
						$("#doc_name_"+num).val(file.name);
						$("#attach_file_"+num).val(data);
						document.getElementById("df_"+num).href="${base}project/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
						num++;
					}
				});
		$("#file_upload4").uploadify(
				{	
					queueID : 'some_file_queue4',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}project/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj4").style.display="";
						if($("#fj4 tr").length>1)
							$("#fj4 tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name_'+num+'" name="attach_name4" readonly><input type="hidden" id="attach_file_'+num+'" name="attach_file4"></td>';
						content+="<td><a href='#' id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj4").append(content);
						$("#doc_name_"+num).val(file.name);
						$("#attach_file_"+num).val(data);
						document.getElementById("df_"+num).href="${base}project/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
						num++;
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

	function compareDate(){
		var beginDate=$("#begin_date").val();  
		var applyEndDate=$("#apply_end_date").val(); 
		var checkEndDate=$("#check_end_time").val();
		if(beginDate==''||applyEndDate==''||checkEndDate==''){
			$.dialog.tips("发布日期、申报截止日期和审核截止日期都不能为空");
			return false;
		}else{
			var now=new Date();
			var d1 = new Date(beginDate.replace(/\-/g, "\/"));  
			var d2 = new Date(applyEndDate.replace(/\-/g, "\/"));  
			var d3 = new Date(checkEndDate.replace(/\-/g, "\/"));
			if(now>=d1){
				$.dialog.tips("发布时间应该大于当前时间");
				return false;
			}else if(d1>=d2){
				$.dialog.tips("申报截止时间应大于发布时间");
				return false;
			}else if(d2>=d3){
				$.dialog.tips("审核截止时间应大于申报截止时间");
				return false;
			}else if($("#fj tr").length<2)
			{ 
				$.dialog.tips("请上传立项要求附件");
				return false;
			}else if($("#fj1 tr").length<2)
			{ 
				$.dialog.tips("请上传项目申报书模板");
				return false;
			}else if($("#fj2 tr").length<2)
			{ 
				$.dialog.tips("请上传学生中期结业报告模板");
				return false;
			}else if($("#fj3 tr").length<2)
			{ 
				$.dialog.tips("请上传学生结业报告模板");
				return false;
			}else if($("#fj4 tr").length<2)
			{ 
				$.dialog.tips("请上传教师结题报告模板");
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
			<a href="${base}project/index">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">立项管理</a></li>
		</ul>
	</div>
	<form action="${base}project/txSave" method="post"
		class="form-horizontal validate-form" onsubmit="return compareDate();">
	
		<div class="formbody">
			<div class="formtitle">
				<span>添加立项</span>
			</div>
			<cqu:formcols cols="1">
				<col label="立项名称" required="required">
				<input type="text" class="form-control input-sm" name="batch_name"
					datatype="*" id="batch_name"/>
				</col>
				<col label="发布时间" required="required">
				<input type="text" class="form-control input-sm Wdate datetime"
					name="begin_date"
					datatype="*" id="begin_date"/>
				</col>
				<col label="申报截止时间" required="required">
				<input type="text" class="form-control input-sm Wdate datetime"
					name="apply_end_date"
					datatype="*" id="apply_end_date"/>
				</col>
				<col label="审核截止时间" required="required">
				<input type="text" class="form-control input-sm Wdate datetime"
					name="check_end_time"
					datatype="*" id="check_end_time"/>
				</col>
				<col label="内容" full="full">
					<textarea name="requirement" class="simple-editor" rows="10" cols="105"></textarea>
				</col>
				<col label="立项要求附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj"
					style="display: none; width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
				</table>
				<div id="some_file_queue" /></div>
				</col>
				<col label="项目申报书模板">
				<div id="file_upload1"></div>
				<table class="table table-bordered" id="fj1"
					style="display: none; width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
				</table>
				<div id="some_file_queue1" /></div>
				</col>
				<col label="学生中期报告模板">
				<div id="file_upload2"></div>
				<table class="table table-bordered" id="fj2"
					style="display: none; width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
				</table>
				<div id="some_file_queue2" /></div>
				</col>
				<col label="学生结业报告模板">
				<div id="file_upload3"></div>
				<table class="table table-bordered" id="fj3"
					style="display: none; width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
				</table>
				<div id="some_file_queue3" /></div>
				</col>
				<col label="教师结业报告模板">
				<div id="file_upload4"></div>
				<table class="table table-bordered" id="fj4"
					style="display: none; width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
				</table>
				<div id="some_file_queue4" /></div>
				</col>
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn">
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