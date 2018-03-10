<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/cqu.tld" prefix="cqu"%>
<%@ taglib uri="/WEB-INF/tld/fmt.tld" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<script type="text/javascript">
function WebOffice1_NotifyCtrlReady() {
    document.all.WebOffice1.LoadOriginalFile("", "doc");
}
</script>
</head>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
		</ul>
	</div>
	
	<div class="mainindex">
		<div class="welinfo">
			<span><img src="${base}assets/img/sun.png" alt="天气" /></span> <b>[ ${username} ] 欢迎使用雏鹰计划信息管理系统</b>
			<a href="${base}index/userEdit"> 个人信息设置</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			或者<a href="${base}index/logout" class="confirm" title="是否确认退出系统？" > 退出系统</a>
		</div>
		<br/>
		<div class="xline"></div>
		<div class="box"></div>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
				  <div class="panel-heading">
						<span class="glyphicon glyphicon-tasks"></span>&nbsp;&nbsp;公告消息</a>
						<span style="float: right;font-size: 14px;"><a href="${base}index/getNewsList">更多</a></span>
				  </div>
				  <div class="panel-body">
					<ul>
						<c:forEach items="${listNews}" var="data" varStatus="i">
						<li><a style="font-size: 14px;" href="${base}index/getNews?news_id=${data.news_id}&&flag=0" title="${data.title}">${data.title}</a><span style="float: right;font-size: 14px;"><fmt:formatDate value="${data.publish_time}"
								pattern="yyyy-MM-dd" /></span></li>
						</c:forEach>
					</ul>
				  </div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
				  <div class="panel-heading">
						<span class="glyphicon glyphicon-tasks"></span>&nbsp;&nbsp;新闻政策</a>
						<span style="float: right;font-size: 14px;"><a href="${base}index/getPolicyList">更多</a></span>
				  </div>
				   <div class="panel-body">
					<ul>
						<c:forEach items="${listPolicy}" var="data" varStatus="i">
						<li><a style="font-size: 14px;" href="${base}index/getNews?news_id=${data.news_id}&&flag=0" title="${data.title}">${data.title}</a><span style="float: right;font-size: 14px;"><fmt:formatDate value="${data.publish_time}"
								pattern="yyyy-MM-dd" /></span></li>
						</c:forEach>
					</ul>
				  </div>
				</div>
			</div>
		</div>

		<div class="xline"></div>
    
	</div>
</body>
</html>