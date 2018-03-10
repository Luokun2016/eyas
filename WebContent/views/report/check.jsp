<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<!DOCTYPE html>
	<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet">
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学习报告审核</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}report" method="post"
			class="search-form form-inline">
			<div class="row">
				<div class="col-md-3 margin5">
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
				<div class="col-md-3 margin5">
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
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">报告类别</span> <select
							name="typeId" class="form-control input-sm">
							<option value="-1" ${typeId==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${typeId==0?"selected='selected'":"" }>中期报告</option>
							<option value="1" ${typeId==1?"selected='selected'":"" }>结业报告</option>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">审核状态</span> <select
							name="reportStatus" class="form-control input-sm">
							<option value="-1" ${reportStatus==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${reportStatus==0?"selected='selected'":"" }>未审核</option>
							<option value="1" ${reportStatus==1?"selected='selected'":"" }>大学教师未通过</option>
							<option value="2" ${reportStatus==2?"selected='selected'":"" }>大学教师通过</option>
							<option value="3" ${reportStatus==3?"selected='selected'":"" }>大学管理员未通过</option>
							<option value="4" ${reportStatus==4?"selected='selected'":"" }>大学管理员通过</option>
							<option value="5" ${reportStatus==5?"selected='selected'":"" }>创新学院未通过</option>
							<option value="6" ${reportStatus==6?"selected='selected'":"" }>创新学院通过</option>
						</select>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">报告名称</span> <input
							type="text" name="reportName" class="form-control input-sm"
							value="${reportName}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学生姓名</span> <input
							type="text" name="studentName" class="form-control input-sm"
							value="${studentName}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">中学名称</span> <select
							name="schoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${schoolList}" var="bat">
								<option value="${bat.school_id}"
									${schoolId==bat.school_id?"selected='selected'":"" }>${bat.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-md-3 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>信息列表</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>批次名称</th>
					<th>项目名称</th>
					<th>学生姓名</th>
					<th>所在中学</th>
					<th>学习报告名称</th>
					<th>报告类别</th>
					<th>审核状态</th>
					<th>审核时间</th>
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
						<td>${data.name}</td>
						<td>${data.school_name}</td>
						<td>${data.l_report_name}</td>
						<td>${data.l_report_type==0?"中期报告":"结业报告"}</td>
						<c:if test="${data.l_report_status==0}">
							<td>未审核</td>
						</c:if>
						<c:if test="${data.l_report_status==1}">
							<td>教师审核未通过</td>
						</c:if>
						<c:if test="${data.l_report_status==2}">
							<td>教师审核通过</td>
						</c:if>
						<c:if test="${data.l_report_status==3}">
							<td>大学管理员审核未通过</td>
						</c:if>
						<c:if test="${data.l_report_status==4}">
							<td>大学管理员审核通过</td>
						</c:if>
						<c:if test="${data.l_report_status==5}">
							<td>创新学院审核未通过</td>
						</c:if>
						<c:if test="${data.l_report_status==6}">
							<td>创新学院审核通过</td>
						</c:if>
						<c:choose>
							<c:when
								test="${data.innovation_date!=null&&data.innovation_date!=''}">
								<td><fmt:formatDate value="${data.innovation_date}"
										pattern="yyyy-MM-dd HH:mm" /></td>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when
										test="${data.college_date!=null&&data.college_date!=''}">
										<td><fmt:formatDate value="${data.college_date}"
												pattern="yyyy-MM-dd HH:mm" /></td>
									</c:when>
									<c:otherwise>
										<td><fmt:formatDate value="${data.teacher_date}"
												pattern="yyyy-MM-dd HH:mm" /></td>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>

						<td width="150"><a pm="XXGL_XXBGSHGL_VIEW"
							href="${base}report/checkView?l_report_id=${data.l_report_id}"
							class="tablelink">查看</a> <c:if
								test="${role==3&&data.l_report_status==0||role==4&&data.l_report_status==2||role==6&&data.l_report_status==4}">
								<a pm="XXGL_XXBGSHGL_CHECKVIEW" href="${base}report/txcheckInitialize?l_report_id=${data.l_report_id}"
									class="tablelink">审核</a>
							</c:if></td>
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