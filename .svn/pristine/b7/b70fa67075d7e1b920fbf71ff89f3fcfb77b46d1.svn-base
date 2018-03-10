<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html>
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
					uploader : '${base}project/uploadApply',
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
						document.getElementById("df").href="${base}project/applyDownLoad?attach_file="+data;
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
		var significance=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		var goal=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
		var content=$(document.getElementsByTagName("iframe")[2].contentWindow.document.body).html();
		var key_problem=$(document.getElementsByTagName("iframe")[3].contentWindow.document.body).html();
		var feasibility=$(document.getElementsByTagName("iframe")[4].contentWindow.document.body).html();
		var schedule=$(document.getElementsByTagName("iframe")[5].contentWindow.document.body).html();
		if(significance==''){
			$.dialog.tips("研究现状和意义不能为空");
			return false;
		}else if(goal==''){
			$.dialog.tips("研究目标不能为空");
			return false;
		}else if(content==''){
			$.dialog.tips("主要研究内容不能为空");
			return false;
		}else if(key_problem==''){
			$.dialog.tips("拟解决的关键问题不能为空");
			return false;
		}else if(feasibility==''){
			$.dialog.tips("拟采取的研究方法、技术路线、实验方案及可行性分析不能为空");
			return false;
		}else if(schedule==''){
			$.dialog.tips("进度安排不能为空");
			return false;
		}else if($("#fj tr").length<2)
		{ 
			$.dialog.tips("请上传附件");
			return false;
		}else{
			$("#flag").val(str);
			return true;
		}
	}

</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}project/apply">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">项目申报管理</a></li>
		</ul>
	</div>
	<form action="${base}project/txApplySave" method="post"
		class="form-horizontal validate-form">
		<input type="hidden" name="batch_id" value="${batch.batch_id}">
		<input type="hidden" name="flag" id="flag"/>
		<div class="formbody">
			<div class="formtitle">
				<span>申报新项目</span>
			</div>
			<cqu:formcols cols="1">
				<col label="项目名称" required="required">
				<input type="text" class="form-control input-sm" name="project_name"
					datatype="*" id="project_name"/>
				</col>
				<col label="学科分类" required="required">
				<select name="subject_cat_id" class="form-control input-sm">
					<c:forEach items="${subCategory}" var="sub">
						<option value="${sub.subject_cat_id}">${sub.subject_name}</option>
					</c:forEach>
			    </select>
				</col>				
				<col label="承担单位" required="required">
				<input type="text" class="form-control input-sm" name="school_name"
					datatype="*" id="school_name" value="${sch.school_name}" readonly/><input type="hidden" name="school_id" value="${sch.school_id}">
				</col>
				<col label="项目实验基地" required="required">
				<input type="text" class="form-control input-sm" name="lab_name"
					datatype="*" id="lab_name"/>
				</col>
				<col label="项目负责人" required="required">
				<input type="text" class="form-control input-sm" name="leader_name"
					datatype="*" id="leader_name"/>
				</col>
				<col label="联系电话" required="required">
				<input type="text" class="form-control input-sm" name="phone_number"
					datatype="m" id="phone_number"/>
				</col>
				<col label="一、研究现状及意义" full="full">
					<textarea class="simple-editor" name="significance" id="significance" rows="10" cols="105"></textarea>
				</col>
				<col label="二、研究目标、主要研究内容和拟解决的关键问题" full="full">
				</col>
				<col label="1.研究目标（包括科研方面的研究目标和人才培养方面的成效）" full="full">
					<textarea class="simple-editor" name="goal" id="goal" rows="10" cols="105"></textarea>
				</col>
				<col label="2.主要研究内容" full="full">
					<textarea class="simple-editor" name="content" id="content" rows="10" cols="105"></textarea>
				</col>
				<col label="3.拟解决的关键问题" full="full">
					<textarea class="simple-editor" name="key_problem" id="key_problem" rows="10" cols="105"></textarea>
				</col>
				<col label="三、拟采取的研究方法、技术路线、实验方案及可行性分析" full="full">
					<textarea class="simple-editor" name="feasibility" id="feasibility" rows="10" cols="105"></textarea>
				</col>
				<col label="四、进度安排" full="full">
					<textarea class="simple-editor" name="schedule" id="schedule" rows="10" cols="105"></textarea>
				</col>
				<col label="五、附件">
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
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn" onclick="return save('save')">
					<span class="glyphicon glyphicon-floppy-disk"></span>保存
				</button>
				<button type="submit" class="btn btn-primary" id="submit_btn" onclick="return save('submit')">
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
</cqu:right>