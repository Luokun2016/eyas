<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<%@ taglib uri="/WEB-INF/tld/fmt.tld" prefix="fmt"%>
<cqu:right>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
  </head>
  <body>
  	<div class="place">
  		<div class="pull-right backbtn">
			<a href="${base}index/body">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">公告消息</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<!-- 搜索、添加 -->
		<form action="${base}index/getNewsList" method="post"
			class="search-form form-inline">
		</form>

		<div class="col-md-12">
				<div class="panel panel-default">
				  <div class="panel-heading">
						<span class="glyphicon glyphicon-tasks"></span>&nbsp;&nbsp;公告消息</a>
				  </div>
				  <div class="panel-body">
					<ul>
						<c:forEach items="${pagination.list}" var="data" varStatus="i">
						<li><a style="font-size: 14px;" href="${base}index/getNews?news_id=${data.news_id}&&flag=1" title="${data.title}">${data.title}</a><span style="float: right;font-size: 14px;"><fmt:formatDate value="${data.publish_time}"
								pattern="yyyy-MM-dd" /></span></li>
						</c:forEach>
					</ul>
				  </div>
				</div>
		<jsp:include page="../common/paginate.jsp"></jsp:include>
			</div>
	</div>
</body>
</html>
</cqu:right>