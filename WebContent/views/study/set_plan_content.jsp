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
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}study/planView?project_id=${project_id}">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">培养计划制定</a></li>
		</ul>
	</div>

	<form action="${base}study/txSetPlanContent" method="post"
		class="form-horizontal validate-form">
		<input type="hidden" name="plan_id" value="${plan_id}" />
		<input type="hidden" name="user_id" value="${user_id}" />
		<input type="hidden" name="project_id" value="${project_id}" />
		<input type="hidden" name="plan_id1" value="${planDetail.plan_id}" />
		<input type="hidden" name="user_id1" value="${planDetail.user_id}" />
		<div class="formbody">
			<div class="formtitle">
				<span>培养计划内容</span>
			</div>
			<cqu:formcols cols="1">
				<col label="" full="full">
				<textarea class="simple-editor" name="plan_content" rows="15"
					cols="105">${planDetail.plan_content}</textarea>
				</col>

				<col label="&nbsp;">
				<button type="submit" class="btn btn-primary" id="submit_btn"
					>
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