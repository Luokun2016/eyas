<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<link href="${base}assets/css/style.css" rel="stylesheet" type="text/css" />
<%
	String url = request.getParameter("url");
	Object basePath = session.getAttribute("base");
	Object actionPath = session.getAttribute("actionPath");
	String baseUrl = basePath.toString() + actionPath.toString().substring(1);
	if(url!=null){
		baseUrl += url;
	}
%>
<script type="text/javascript">
<!--
function goPage(pageNumber){
	$(".search-form").append("<input type='hidden' name='pageNumber' value='"+pageNumber+"'/>");
	$(".search-form").submit();
}
//-->
</script>
<%
Map<String, Object> o = (Map<String, Object>) request.getAttribute("pagination");
if(o==null){
%>
<ul class="pagination pagination-sm pull-right">
  <li class="disabled"><a href="#">首页</a></li>
  <li class="disabled"><a href="#">上页</a></li>
  <li class="disabled"><a href="#">下页</a></li>
  <li class="disabled"><a href="#">末页</a></li>
</ul>
<ul class="pagination pagination-sm">
	<li class="disabled"><a>当前第1页/共1页&nbsp;&nbsp;共0条数据</a></li>
</ul>
<div class="clearfix"></div>
<%
	return;
}
%>
<ul class="pagination pull-right pagination-sm">
	<li><a href="javascript:goPage(1)">首页</a></li>
	<%
			int totlePage = Integer.parseInt(o.get("totalPage").toString());
			int curentPage = Integer.parseInt(o.get("pageNumber").toString());
			// 前一页
			int pre = curentPage - 1;
			if (pre >= 1) {
				out.print("<li><a href='javascript:goPage(" + pre + ");'>上页</a></li>");
			} else {
				out.print("<li class=\"disabled\"><a>上页</a></li>");
			}
			// 下一页
			int next = curentPage + 1;
			if (next <= totlePage) {
				out.print("<li><a href='javascript:goPage(" + next + ")'>下页</a></li>");
			} else {
				out.print("<li class=\"disabled\"><a>下页</a></li>");
			}
	%>
	<li><a href="javascript:goPage(${pagination.totalPage==0?1:pagination.totalPage})">末页</a></li>
</ul>
<ul class="pagination pagination-sm" id="tools-line">
	<li class="disabled"><a>当前第${pagination.pageNumber}页/共${pagination.totalPage==0?1:pagination.totalPage}页&nbsp;&nbsp;共${pagination.totalRow}条数据</a></li>
</ul>
<div class="clearfix"></div>