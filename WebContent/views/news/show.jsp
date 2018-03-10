<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
  </head>
  <body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">基础设置</a></li>
			<li><a href="#">新闻管理</a></li>
			<li><a href="#">查看新闻</a></li>
		</ul>
	</div>
	<div class="formbody">
	<input type="hidden" name="news_id" value="${oneNews.news_id }"/>
		<h1 style="text-align:center;font-weight:bold;color:black" >${oneNews.title  }</h1>
		<hr>
		<div style="min-height:300px" >${oneNews.content }</div>
		<div id="file_upload"></div>
				<table class="table table-bordered" id="fj" style="width: 770px;">
					<tr>
						<td width="600px;">附件名称</td>
						<td width="270px;">操作</td>
					</tr>
					<c:forEach items="${attachList }" var="data" varStatus="i" >
					<tr>
						<td>
							<input type="text" class="form-control input-sm" id="doc_name" name="attach_name" value="${data.file_name }" readonly>
							<input type="hidden" id="attach_file" name="attach_file" value="${data.file_path } ">
						</td>
						
						<td>
							<a href="${base}news/downLoad?attach_file=${data.file_path }" id='df' class='tablelink'>下载</a>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div id="some_file_queue" /></div>
		</div>
	</div>
</body>
</html>