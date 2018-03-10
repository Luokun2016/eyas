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
	<div class="tabson">
		<fieldset disabled="disabled">
			<form action="" method="post"
				class="form-horizontal validate-form">
				<div class="formbody">
					<div class="formtitle">
						<span>立项详情</span>
					</div>
					<cqu:formcols cols="1">
						<col label="立项名称" required="required">
						<input type="text" class="form-control input-sm" name="batch_name"
							datatype="*" id="batch_name" value="${batch.batch_name}" readonly />
						</col>
						<col label="发布时间" required="required">
						<input type="text" class="form-control input-sm Wdate datetime"
							name="begin_date"
							value="<fmt:formatDate value="${batch.begin_date}" pattern='yyyy-MM-dd HH:mm'/>"
							datatype="*" id="begin_date" />
						</col>
						<col label="申报截止时间" required="required">
						<input type="text" class="form-control input-sm Wdate datetime"
							name="apply_end_date"
							value="<fmt:formatDate value="${batch.apply_end_date}" pattern='yyyy-MM-dd HH:mm'/>"
							datatype="*" id="apply_end_date" />
						</col>
						<col label="审核截止时间" required="required">
						<input type="text" class="form-control input-sm Wdate datetime"
							name="check_end_time"
							value="<fmt:formatDate value="${batch.check_end_time}" pattern='yyyy-MM-dd HH:mm'/>"
							datatype="*" id="check_end_time" />
						</col>
						<col label="内容" full="full">
						<textarea class="simple-editor" name="requirement"
							rows="10" cols="105">${batch.requirement}</textarea>
						</col>
						<col label="立项要求附件">
						<div id="file_upload"></div>
						<table class="table table-bordered" id="fj" style="width: 770px;">
							<tr>
								<td width="600px;">名称</td>
								<td width="270px;">操作</td>
							</tr>
							<c:if
								test="${batch.require_attach!=null&&batch.require_attach!=''}">
								<tr>
									<td><input type="text" class="form-control input-sm"
										name="attach_name" value="${batch.require_attach}" readonly>
										<input type="hidden" name="attach_file"
										value="${batch.require_attach}"></td>
									<td><a
										href='${base}project/downLoad?attach_file=${batch.require_attach}'
										id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr>
							</c:if>
						</table>
						<div id="some_file_queue" /></div>
						</col>
						<col label="项目申报书模板">
						<div id="file_upload1"></div>
						<table class="table table-bordered" id="fj1" style="width: 770px;">
							<tr>
								<td width="600px;">名称</td>
								<td width="270px;">操作</td>
							</tr>
							<c:if test="${batch.apply_temp!=null&&batch.apply_temp!=''}">
								<tr>
									<td><input type="text" class="form-control input-sm"
										name="attach_name1" value="${batch.apply_temp}" readonly>
										<input type="hidden" name="attach_file1"
										value="${batch.apply_temp}"></td>
									<td><a
										href='${base}project/downLoad?attach_file=${batch.apply_temp}'
										class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr>
							</c:if>
						</table>
						<div id="some_file_queue1" /></div>
						</col>
						<col label="学生中期报告模板">
						<div id="file_upload2"></div>
						<table class="table table-bordered" id="fj2" style="width: 770px;">
							<tr>
								<td width="600px;">名称</td>
								<td width="270px;">操作</td>
							</tr>
							<c:if
								test="${batch.interim_report!=null&&batch.interim_report!=''}">
								<tr>
									<td><input type="text" class="form-control input-sm"
										name="attach_name2" value="${batch.interim_report}" readonly>
										<input type="hidden" name="attach_file2"
										value="${batch.interim_report}"></td>
									<td><a
										href='${base}project/downLoad?attach_file=${batch.interim_report}'
										class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr>
							</c:if>
						</table>
						<div id="some_file_queue2" /></div>
						</col>
						<col label="学生结业报告模板">
						<div id="file_upload3"></div>
						<table class="table table-bordered" id="fj3" style="width: 770px;">
							<tr>
								<td width="600px;">名称</td>
								<td width="270px;">操作</td>
							</tr>
							<c:if test="${batch.final_report!=null&&batch.final_report!=''}">
								<tr>
									<td><input type="text" class="form-control input-sm"
										name="attach_name3" value="${batch.final_report}" readonly>
										<input type="hidden" name="attach_file3"
										value="${batch.final_report}"></td>
									<td><a
										href='${base}project/downLoad?attach_file=${batch.final_report}'
										class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr>
							</c:if>
						</table>
						<div id="some_file_queue3" /></div>
						</col>
						<col label="教师结业报告模板">
						<div id="file_upload4"></div>
						<table class="table table-bordered" id="fj4" style="width: 770px;">
							<tr>
								<td width="600px;">名称</td>
								<td width="270px;">操作</td>
							</tr>
							<c:if
								test="${batch.conclusion_report!=null&&batch.conclusion_report!=''}">
								<tr>
									<td><input type="text" class="form-control input-sm"
										name="attach_name4" value="${batch.conclusion_report}"
										readonly> <input type="hidden" name="attach_file4"
										value="${batch.conclusion_report}"></td>
									<td><a
										href='${base}project/downLoad?attach_file=${batch.conclusion_report}'
										class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</tr>
							</c:if>
						</table>
						<div id="some_file_queue4" /></div>
						</col>
					</cqu:formcols>
				</div>

			</form>
		</fieldset>
	</div>
</body>
</html>