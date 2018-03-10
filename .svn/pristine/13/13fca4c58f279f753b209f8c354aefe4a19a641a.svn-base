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
<script language="javascript">
	function compare() {
		var b = false;
		var count = 0;
		var checkboxs = document.getElementsByName("projectId");
		for (var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked == true) {
				b = true;
				count++;
			}
		}
		if (b == true) {
			if (count > 2) {
				$.dialog.tips("一个批次最多选择两个项目");
			} else {
				obj = document.getElementsByName("projectId");
				box = [];
				for (k in obj) {
					if (obj[k].checked)
						box.push(obj[k].value);
				}
				$("#projectList").val(box);
				$("#signup")[0].submit();
			}
		} else {
			$.dialog.tips("请至少选中一个中学学校分配项目");
		}
	}
</script>
</head>
<body>
	<div class="place">
	<div class="pull-right backbtn">
			<a href="${base}project/txSignupAddInitialize">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">学生新增报名</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/txSignupStudentNext" method="post"
			class="search-form form-inline">
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">项目名称</span> <input
							type="text" name="projectName" class="form-control input-sm"
							value="${projectName}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">单位名称</span> <select
							name="schoolId" class="form-control input-sm">
							<option value="-1" ${schoolId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${schoolList}" var="bat">
								<option value="${bat.school_id}"
									${schoolId==bat.school_id?"selected='selected'":"" }>${bat.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学科分类</span> <select
							name="subjectCatId" class="form-control input-sm">
							<option value="-1" ${subjectCatId==-1?"selected='selected'":"" }>全部</option>
							<c:forEach items="${subjectCategoryList}" var="bat">
								<option value="${bat.subject_cat_id}"
									${subjectCatId==bat.subject_cat_id?"selected='selected'":"" }>${bat.subject_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5 ">
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
					<th></th>
					<th>项目名称</th>
					<th>承担单位</th>
					<th>学科分类</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td><input type="checkbox" name="projectId"
							value="${data.project_id}" /></td>
						<td>${data.project_name}</td>
						<td>${data.school_name}</td>
						<td>${data.subject_name}</td>
						<td width="150"><a pm="XMGL_XSBMGL_ADD_DETAIL"
							href="${base}project/txSignupAddView?project_id=${data.project_id}"
							class="tablelink">项目详情</a></td>
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
		<form action="${base}project/txSignupAdd" method="post" id="signup"
		class="form-horizontal validate-form">
		<input type="hidden" name="projectList" id="projectList"/>
		<button type="button" class="btn btn-primary" id="submit_btn"
			onclick="compare()">
			<span class="glyphicon glyphicon-floppy-disk"></span>提交
		</button>
		</form>
	</div>
</body>
	</html>
</cqu:right>