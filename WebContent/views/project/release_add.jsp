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
	function check(obj) {
		var aa = document.getElementsByName("schoolId");
		for (var i = 0; i < aa.length; i++) {
			aa[i].checked = false;
		}
		obj.checked = true;
	}

	function compare() {
		var endDate = $("#end_date").val();
		if (endDate == '')
			$.dialog.tips("学生报名截止时间不能为空");
		else {
			var now = new Date();
			var d1 = new Date(endDate.replace(/\-/g, "\/"));
			if (now >= d1)
				$.dialog.tips("学生报名截止时间应该大于当前时间");
			else {
				var b = false;
				var checkboxs = document.getElementsByName("schoolId");
				for (var i = 0; i < checkboxs.length; i++) {
					if (checkboxs[i].checked == true) {
						b = true;
					}
				}
				if (b == true) {
					obj = document.getElementsByName("schoolId");
					box = [];
					for (k in obj) {
						if (obj[k].checked)
							box.push(obj[k].value);
					}
					$("#enddate_id").val(endDate);
					$("#schoolList").val(box);
					$("#releaseadd")[0].submit();
				} else {
					$.dialog.tips("请选中一个中学学校分配项目");
				}
			}

		}
	}
</script>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}project/release">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">项目正式发布</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/txReleaseInitialize" method="post"
			class="search-form form-inline">
			<input type="hidden" name="project_id" id="project_id"
			value="${project_id}" />
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学生报名截止时间</span> <input
							type="text" class="form-control input-sm Wdate datetime"
							name="end_date" datatype="*" id="end_date" />
					</div>
				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>中学学校</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th></th>
					<th>中学名称</th>
					<th>负责人</th>
					<th>联系方式</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index" />
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
					<c:set value="1" var="index"></c:set>
					<tr>
						<td><input type="checkbox" name="schoolId" id="schooId"
							value="${data.school_id}" onclick="check(this)" /></td>
						<td>${data.school_name}</td>
						<td>${data.manager}</td>
						<td>${data.phone}</td>
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
		<form action="${base}project/txReleaseAdd" method="post" id="releaseadd"
			class="form-horizontal validate-form">
			<input type="hidden" name="enddate_id" id="enddate_id">
			<input type="hidden" name="projectadd_id" id="projectadd_id"
			value="${project_id}" />
			<input type="hidden" name="schoolList" id="schoolList" />
			<button type="button" class="btn btn-primary" id="submit_btn"
				onclick="compare()">
				<span class="glyphicon glyphicon-floppy-disk"></span>提交
			</button>
		</form>
	</div>
</body>
	</html>
</cqu:right>