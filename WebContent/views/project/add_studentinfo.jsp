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
					uploader : '${base}project/uploadSignup',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					multi:false,
					onUploadSuccess : function(file, data, response) {
						document.getElementById("fj").style.display="";
						if($("#fj tr").length>1)
							$("#fj tr:last").remove();
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name" name="attach_name" readonly><input type="hidden" name="attach_file" id="attach_file"></td>';
						content+="<td><a href='#' id='df' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj").append(content);
						$("#doc_name").val(file.name);
						$("#attach_file").val(data);
						document.getElementById("df").href="${base}project/signupDownLoad?attach_file="+data;
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
	
	function save(){
		var interest=$(document.getElementsByTagName("iframe")[0].contentWindow.document.body).html();
		var introduction=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
		var plan=$(document.getElementsByTagName("iframe")[2].contentWindow.document.body).html();
		if(interest==''){
			$.dialog.tips("特长爱好及准备选择的学科不能为空");
			return false;
		}else if(introduction==''){
			$.dialog.tips("自我介绍不能为空");
			return false;
		}else if(plan==''){
			$.dialog.tips("参与重庆市青少年创新人才培养雏鹰计划的规划不能为空");
			return false;
		}else if($("#fj tr").length<2)
		{ 
			$.dialog.tips("必须上传佐证材料！");
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
			<a href="${base}project/signup">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学生报名管理</a></li>
		</ul>
	</div>
	<form action="${base}project/txSignupStudentSave" method="post"
		class="form-horizontal validate-form">
		<div class="formbody">
			<div class="formtitle">
				<span>个人信息填报</span>
			</div>
			<cqu:formcols cols="2">
				<col label="姓名" required="required">
				<input type="text" class="form-control input-sm" name="name"
					datatype="*" id="name" value="${user.name}" readonly/>
				</col>
				<col label="学校名称" required="required">
				<input type="text" class="form-control input-sm" name="school_name"
					datatype="*" id="school_name" value="${school.school_name}" readonly/>
				</col>
				<col label="年级" required="required">
				<input type="text" class="form-control input-sm" name="grade_name"
					datatype="*" id="school_name" value="${grade.grade_name}" readonly/>
				</col>
				<col label="班级" required="required">
				<input type="text" class="form-control input-sm" name="class_name"
					datatype="*" id="class_name" value="${classes.class_name}" readonly/>
				</col>
				<col label="联系电话" required="required">
				<input type="text" class="form-control input-sm" name="mobile"
					datatype="m" id="mobile" value="${user.mobile}"/>
				</col>
				<col label="QQ" required="required">
				<input type="text" class="form-control input-sm" name="qq"
					datatype="qq" id="qq" value="${user.qq}"/>
				</col>
				<col label="微信" required="required">
				<input type="text" class="form-control input-sm" name="wechat"
					datatype="*" id="wechat" value="${user.wechat}"/>
				</col>
				<col label="家庭住址" required="required">
				<input type="text" class="form-control input-sm" name="address"
					datatype="*" id="address" value="${detailInformation==null?"":detailInformation.address}"/>
				</col>
				<col label="班级职务" required="required">
				<input type="text" class="form-control input-sm" name="post"
					datatype="*" id="post" value="${detailInformation==null?"":detailInformation.post}"/>
				</col>
				<col label="班主任姓名" required="required">
				<input type="text" class="form-control input-sm" name="t_name"
					datatype="*" id="t_name" value="${detailInformation==null?"":detailInformation.t_name}"/>
				</col>
				<col label="任教学科" required="required">
				<input type="text" class="form-control input-sm" name="t_subject"
					datatype="*" id="t_subject" value="${detailInformation==null?"":detailInformation.t_subject}"/>
				</col>
				<col label="班主任电话" required="required">
				<input type="text" class="form-control input-sm" name="t_number"
					datatype="m" id="t_number" value="${detailInformation==null?"":detailInformation.t_number}"/>
				</col>
				<col label="父亲姓名" required="required">
				<input type="text" class="form-control input-sm" name="f_name"
					datatype="*" id="f_name" value="${detailInformation==null?"":detailInformation.f_name}"/>
				</col>
				<col label="母亲姓名" required="required">
				<input type="text" class="form-control input-sm" name="m_name"
					datatype="*" id="m_name" value="${detailInformation==null?"":detailInformation.m_name}"/>
				</col>
				<col label="父亲工作单位" required="required">
				<input type="text" class="form-control input-sm" name="f_unit"
					datatype="*" id="f_unit" value="${detailInformation==null?"":detailInformation.f_unit}"/>
				</col>
				<col label="母亲工作单位" required="required">
				<input type="text" class="form-control input-sm" name="m_unit"
					datatype="*" id="m_unit" value="${detailInformation==null?"":detailInformation.m_unit}"/>
				</col>
				<col label="父亲学历专业" required="required">
				<input type="text" class="form-control input-sm" name="f_qualification_major"
					datatype="*" id="f_qualification_major" value="${detailInformation==null?"":detailInformation.f_qualification_major}"/>
				</col>
				<col label="母亲学历专业" required="required">
				<input type="text" class="form-control input-sm" name="m_qualification_major"
					datatype="*" id="m_qualification_major" value="${detailInformation==null?"":detailInformation.m_qualification_major}"/>
				</col>
				<col label="父亲职务职称" required="required">
				<input type="text" class="form-control input-sm" name="f_title"
					datatype="*" id="f_title" value="${detailInformation==null?"":detailInformation.f_title}"/>
				</col>
				<col label="母亲职务职称" required="required">
				<input type="text" class="form-control input-sm" name="m_title"
					datatype="*" id="m_title" value="${detailInformation==null?"":detailInformation.m_title}"/>
				</col>
				<col label="父亲联系电话" required="required">
				<input type="text" class="form-control input-sm" name="f_number"
					datatype="m" id="f_number" value="${detailInformation==null?"":detailInformation.f_number}"/>
				</col>
				<col label="母亲联系电话" required="required">
				<input type="text" class="form-control input-sm" name="m_number"
					datatype="m" id="m_number" value="${detailInformation==null?"":detailInformation.m_number}"/>
				</col>
				<col label="父亲专业领域" required="required">
				<input type="text" class="form-control input-sm" name="f_business"
					datatype="*" id="f_business" value="${detailInformation==null?"":detailInformation.f_business}"/>
				</col>
				<col label="母亲专业领域" required="required">
				<input type="text" class="form-control input-sm" name="m_business"
					datatype="*" id="m_business" value="${detailInformation==null?"":detailInformation.m_business}"/>
				</col>
			</cqu:formcols>
			<cqu:formcols  cols="1">
				<col label="特长爱好及准备选择的学科" full="full">
					<textarea class="simple-editor" name="interest" cols="105">${detailInformation==null?"":detailInformation.interest}</textarea>
				</col>
				<col label="自我介绍（包括学习情况，学习能力和兴趣爱好等，参加过的科技实践活动及取得的成绩，300字左右）" full="full">
					<textarea class="simple-editor" name="s_introduce" cols="105">${detailInformation==null?"":detailInformation.s_introduce}</textarea>
				</col>
				<col label="参与重庆市青少年创新人才培养雏鹰计划的规划（包括申请参加项目的理由和摄像，感兴趣的方向及关注的问题，学习能力，300字左右）" full="full">
					<textarea class="simple-editor" name="s_plan" cols="105">${detailInformation==null?"":detailInformation.s_plan}</textarea>
				</col>
				<col label="佐证材料">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj"
					style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<c:if test="${detailInformation!=null&&detailInformation.proof_path!=null&&detailInformation.proof_path!=''}">
					<tr>
						<td><input type="text" class="form-control input-sm" name="attach_name" value="${detailInformation.proof_path}" readonly>
						<input type="hidden" name="attach_file" value="${detailInformation.proof_path}"></td>
						<td><a href='${base}project/signupDownLoad?attach_file=${detailInformation.proof_path}' id='df' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td>
					</tr>
					</c:if>
				</table>
				<div id="some_file_queue" /></div>
				</col>
				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn" onclick="return save()">
					<span class="glyphicon glyphicon-floppy-disk"></span>下一步
				</button>
				</col>
			</cqu:formcols>
		</div>
	
	</form>
</body>
</html>