<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<cqu:right>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
</head>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">批次学生名单导出</a></li>
		</ul>
	</div>
	<div class="rightinfo">
		<form action="${base}project/txProjectImportAllStudent" method="post"
			class="search-form form-inline">
			<input type="hidden" name="flag" value="all">
			<div class="row">
			<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">批次名称</span> <select
							name="batchId" class="form-control input-sm">
								<c:forEach items="${batchList}" var="bat">
									<option value="${bat.batch_id}"}>${bat.batch_name}</option>
								</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="col-md-4 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span></span>导出该批次学生名单
					</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>
</cqu:right>