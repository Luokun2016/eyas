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
	function check(){
	var goal=$(document.getElementsByTagName("iframe")[1].contentWindow.document.body).html();
		var value=$('input:radio[name="grade"]:checked').val();
		if(value==null){
			$.dialog.tips("请选择评价等级");
			return false;
		}else if(goal==''){
			$.dialog.tips("请填写评语");
			return false;
		}else
			return true;
	}
			
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}record/review">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学习记录评阅</a></li>
		</ul>
	</div>

	<form action="${base}record/txReviewRecord" method="post"
		class="form-horizontal validate-form" onsubmit="return check()">
		<div class="formbody">
			<div class="formtitle">
				<span>学习记录信息</span>
			</div>
			<cqu:formcols cols="1">
				<col label="学习记录名称" >	
				<input type="hidden" name="recordId"	value="${learnRecord.l_record_id}"	/>				
				<input type="text" name="learnRecordName" class="form-control input-sm"
					value="${learnRecord.l_record_name}" readonly />
				</col>			
				
				
				<col label="学习记录类别" >
				<input type="text" name="learnRecordType" class="form-control input-sm"
					value="${lRecordType.l_record_type}" readonly />
				</col>					
				
				<col label="学习记录描述" >
				<textarea class="simple-editor" name="l_record_des" rows="15"
					cols="100">${learnRecord.l_record_des}</textarea>
				</col>
				
				<col label="学习记录附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj" style="width: 770px;">
							<tr>
								<td width="600px;">名称</td>
								<td width="270px;">操作</td>
							</tr>
							<c:if
								test="${learnRecord.l_record_path!=null&&learnRecord.l_record_path!=''}">
								<tr>
									<td><input type="text" class="form-control input-sm"
										name="attach_name" value="${learnRecord.l_record_path}" readonly>
										<input type="hidden" name="attach_file"
										value="${learnRecord.l_record_path}"></td>
									<td><a
										href='${base}record/downLoad?attach_file=${learnRecord.l_record_path}'
										id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr>
							</c:if>
						</table>						
						<div id="some_file_queue" /></div>
				</col>
				
				<col label="评价等级">
				<input type="radio" name="grade" id="grade" value="0" />优秀
				<input type="radio" name="grade" id="grade" value="1" />良好
				<input type="radio" name="grade" id="grade" value="2" />合格
				<input type="radio" name="grade" id="grade" value="3" />不合格
				</col>				
								
				<col label="评语" >
				<textarea class="simple-editor" name="remark" rows="15"
					cols="100" >${learnRecord.remark}</textarea>
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