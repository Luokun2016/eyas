<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<meta charset="utf-8">
<title>雏鹰计划信息管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${base}assets/css/bootstrap.css"
	media="screen">
<style>
ul li {
	margin: 0px;
	list-style: none;
}
</style>
<body>
	<div class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <a href="${base}" class="navbar-brand">雏鹰计划信息管理系统</a>
        </div>
      </div>
    </div>
	<div class="container">
		<div style="margin-top:60px;">
			<br/><br/>
			<div class="page-header">
			  <h1>提交失败 <small>您提交的数据有误~</small></h1>
			</div>
			<div class="alert alert-info">
				<b>提示</b><br/><hr/>
				<c:forEach items="${PAGE_ERROR}" var="d">
					<li>${d}</li>
				</c:forEach>
				<br/><br/>
				点击这里[ <a href="javascript:history.back();">返回</a> ]
			</div>
		</div>
	</div>
</body>
</html>