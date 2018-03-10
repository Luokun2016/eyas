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
	function SelectAll() {
		var checkboxs = document.getElementsByName("userStuId");
		for (var i = 0; i < checkboxs.length; i++) {
			var e = checkboxs[i];
			e.checked = !e.checked;
		}
	}

	function check() {
		var b = false;
		var checkboxs = document.getElementsByName("userStuId");
		for (var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked == true) {
				b = true;
			}
		}
		if (b == true) {
			obj = document.getElementsByName("userStuId");
			box = [];
			for (k in obj) {
				if (obj[k].checked)
					box.push(obj[k].value);
			}
			$("#stuList").val(box);
			$("#addStuApply")[0].submit();
		} else {
			$.dialog.tips("请至少选中一个学生");
		}
	}
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}project/txTeamAddInitialize?project_id=${projectId}">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">添加其他学生</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/txAddOtherStudentInitialize"
			method="post" class="search-form form-inline">
			<input type="hidden" name="project_id" value="${projectId}">
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">用户名</span> <input
							type="text" name="stuUserName" class="form-control input-sm"
							value="${stuUserName}"/>
					</div>
				</div>

				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学生姓名</span><input
							type="text" name="stuName" class="form-control input-sm"
							value="${stuName}"/>
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
					<th><input type="checkbox" onclick="SelectAll();" /></th>
					<th>用户名</th>
					<th>姓名</th>
					<th>性别</th>
					<th>联系电话</th>

				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td><input type="checkbox" name="userStuId"
							value="${data.user_id}"/></td>
						<td>${data.user_name}</td>
						<td>${data.name}</td>
						<td>${data.sex==0?"女":"男"}</td>
						<td>${data.mobile}</td>
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
		<form action="${base}project/txAddOtherStudent" method="post" id="addStuApply"
			class="form-horizontal validate-form">
			<input type="hidden" name="stuList" id="stuList" />
			<input type="hidden" name="paproject_id" value="${projectId}">
			<button type="button" class="btn btn-primary" id="submit_btn"
				onclick="check()">
				<span class="glyphicon glyphicon-floppy-disk"></span>提交
			</button>
		</form>
	</div>
</body>
	</html>
</cqu:right>