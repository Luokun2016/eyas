<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<cqu:right>
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
					uploader : '${base}record/upload',
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
						document.getElementById("df").href="${base}record/downLoad?attach_file="+data;
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
	
	function isSubmit(){
		var des=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		var value=$("#recordType").val();
		if(value==-1){
			$.dialog.tips("请选择学习记录类别");
			return false;
		}else if(des==''){
			$.dialog.tips("学习记录描述不能为空");
			return false;
		}else if($("#fj tr").length<2){ 
			$.dialog.tips("请上传学习记录附件");
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
			<a href="${base}record/maintain">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学习记录维护</a></li>
			<li><a href="#">添加学习记录</a></li>
		</ul>
	</div>

	<form action="${base}record/txAddRecord" method="post"
		class="form-horizontal validate-form" onsubmit="return isSubmit()">
		<input type="hidden" name="project_id" value="${projectApply.project_id}"/>
		<input type="hidden" name="batch_id" value="${projectApply.batch_id}"/>
		<div class="formbody">
			<div class="formtitle">
				<span>学习记录信息</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称" >
				<input type="hidden" name="batch_id" class="form-control input-sm"
					value="${projectApply.batch_id}" readonly />
				<input type="hidden" name="project_id" class="form-control input-sm"
					value="${projectApply.project_id}" readonly />			
				<input type="text" name="projectName" class="form-control input-sm"
					value="${projectApply.project_name}" readonly />
				</col>
			
				<col label="学习记录名称" required="required">
				<input type="text" name="l_record_name" class="form-control input-sm"
					datatype="*"  />
				</col>
				
				<col label="学习记录类别" required="required">
				<select	name="l_record_type_id" class="form-control input-sm" id="recordType">
					<option value="-1"	${l_record_type_id==-1?"selected='selected'":"" }>请选择类别</option>							
					<c:forEach items="${recordTypeList}" var="record">
						<option value="${record.l_record_type_id}" ${l_record_type_id==record.l_record_type_id?"selected='selected'":"" }>${record.l_record_type}</option>
					</c:forEach>							
				</select>
				</col>					
				
				<col label="学习记录描述">
				<textarea class="simple-editor" name="l_record_des" rows="15"
					cols="100"> </textarea>
				</col>
				
				<col label="学习记录附件" >
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
				
				</col>
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn"
					>
					<span class="glyphicon glyphicon-floppy-disk"></span>提交
				</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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