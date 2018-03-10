<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet">
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script language="javascript">
	function isSubmit(){
		var value=$("#projectNowId").val();
		if(value==-1){
			$.dialog.tips("请选择项目名称");
			return false;
		}else{
			var f=true;
			$.ajax({
				async:false,
				type : "POST",
				url : "${base}record/checkAddRecord",
				data : {
					"projectId" : value
				},
				success : function(data) {
					if (data.flag == "false") {	
						f=false;
						$.dialog.tips("该项目状态为已结题或当前时间大于记录提交截止时间，不能添加学习记录！");
					}else if (data.flag1 == "false") {	
						f=false;
						$.dialog.tips("该项目添加学习记录次数已达到要求！");
					}else{
						f=true;
					}
				},
				error : function(jqXHR) {
					alert("发生错误：" + jqXHR.status);
					return false;
				}
			});
			return f;
		}
	}
</script>
</head>
<body>
	<form action="${base}record/txAddInitialize" method="post"
		onsubmit="return isSubmit()">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">请选择项目</h4>
					</div>
					<div class="modal-body">
						<div class="col-md-6">
							<div class="input-group">
								<span class="input-group-addon input-sm">项目名称</span> <select
									name="projectNowId" id="projectNowId"
									class="form-control input-sm">
									<option value="-1">请选择</option>
									<c:forEach items="${projectNowList}" var="bat">
										<option value="${bat.project_id}">${bat.project_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="modal-footer" style="margin-top: 28px;">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="submit" class="btn btn-primary">确定</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学习记录维护</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}record/maintain" method="post"
			class="search-form form-inline">
			<div class="row">
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <select
							name="batchId" class="form-control input-sm">
							<option value="-1" ${batchId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${batchList}" var="bat">
								<option value="${bat.batch_id}"
									${batchId==bat.batch_id?"selected='selected'":"" }>${bat.batch_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">项目名称</span> <select
							name="projectId" class="form-control input-sm">
							<option value="-1" ${projectId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${projectList}" var="bat">
								<option value="${bat.project_id}"
									${projectId==bat.project_id?"selected='selected'":"" }>${bat.project_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">记录类别</span> <select
							name="recordTypeId" class="form-control input-sm">
							<option value="-1"
								${recordTypeId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${recordTypeList}" var="record">
								<option value="${record.l_record_type_id}"
									${recordTypeId==record.l_record_type_id?"selected='selected'":"" }>${record.l_record_type}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">记录名称</span> <input
							type="text" name="recordName" class="form-control input-sm"
							value="${recordName}" />
					</div>
				</div>

				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a pm="XXGL_XXJLWHGL_ADDINIT" href="#"
						class="btn btn-default btn-sm" data-toggle="modal"
						data-target="#myModal"><span></span>添加学习记录</a>

				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>学习记录列表</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>批次名称</th>
					<th>项目名称</th>
					<th>学科分类</th>
					<th>学习记录名称</th>
					<th>记录类别</th>
					<th>评阅状态</th>
					<th>录入时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.batch_name}</td>
						<td>${data.project_name}</td>
						<td>${data.subject_name}</td>
						<td>${data.l_record_name}</td>
						<td>${data.l_record_type}</td>
						<td><c:if test="${data.status=='0'}">未评阅</c:if>
							<c:if test="${data.status=='1'}">已评阅</c:if>
						</td>
						<td>${data.upload_time}</td>
						<td width="150"><a pm="XXGL_XXJLWHGL_VIEW"
							href="${base}record/learnRecordView?recordId=${data.l_record_id}"
							class="tablelink">查看</a>&nbsp;&nbsp; 
							<c:if test="${data.status=='0'}">
							<a pm="XXGL_XXJLWHGL_EDITINIT" href="${base}record/editLearnRecordView?recordId=${data.l_record_id}"
							class="tablelink">修改</a>&nbsp;&nbsp; 
							<a pm="XXGL_XXJLWHGL_DEL" href="${base}record/txDeleteLearnRecord?recordId=${data.l_record_id}"
							class="tablelink confirm">删除</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${index==0}">
					<tr>
						<td colspan="100">没有找到数据！</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<jsp:include page="../common/paginate.jsp"></jsp:include>
	</div>
</body>
	</html>
</cqu:right>