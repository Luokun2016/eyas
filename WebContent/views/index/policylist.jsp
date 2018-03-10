<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="me" uri="/WEB-INF/tld/cqu.tld"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${base}assets/css/bootstrap.css"
	media="screen" />
<title>欢迎登录雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style2.css" rel="stylesheet"
	type="text/css" />
<script language="JavaScript"
	src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script src="${base}assets/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${base}assets/lhgdialog/lhgdialog.min.js?skin=blue"></script>
<script type="text/javascript" src="${base}assets/js/common.js"></script>
<script type="text/javascript">
function fanye(pageNumber){
	$(".search-form").append("<input type='hidden' name='pageNumber' value='"+pageNumber+"'/>");
	$(".search-form").submit();
}
</script>
</head>

<body onload="${base}index/createCode"
	style="background-color: #1c77ac; background-repeat: no-repeat; background-position: center top; overflow: hidden;">

	<div class="logintop">
		<span style="font-size: 16px;">欢迎登录雏鹰计划信息管理系统</span>
		<ul>
			<li><a href="${base}index/login" style="font-size: 13px;">返回登录</a></li>
		</ul>
	</div>
	<div class="loginbody">
		<div class="row">
			<form action="${base}index/getNewsList" method="post"
				class="search-form form-inline">
				<div class="col-lg-12">
					<div class="newslist" style="margin-top: 15px;">
						<div class="newslisttitle">
							<span>政策</span>
						</div>
						<c:set value="0" var="index" />
						<div class="newslistcontent">
							<ul>
								<c:forEach items="${pagination.list}" var="data" varStatus="i">
									<c:set value="1" var="index"></c:set>
									<li><span><fmt:formatDate
												value="${data.publish_time}" pattern="yyyy-MM-dd HH:mm" /></span><a
										href="${base}index/getNews?news_id=${data.news_id}" title="${data.title}">${data.title}</a></li>
								</c:forEach>
								<c:if test="${index==0}">
									没有数据
								</c:if>
							</ul>
						</div>
						<c:if test="${index!=0}">
						<div class="pagin">
							<div class="message" style="color: #05070C;">
								当前第${pagination.pageNumber}页/共${pagination.totalPage==0?1:pagination.totalPage}页&nbsp;&nbsp;共${pagination.totalRow}条数据
							</div>
							<ul class="paginList">
								<li class="paginItem"><a href="#" onclick="fanye(1)"
									style="color: #0C0C0C"><<</a></li>
								<li class="paginItem"><a href="#"
									onclick="fanye(${pagination.pageNumber-1>0?'pagination.pageNumber-1':1})"
									style="color: #0C0C0C"><</a></li>
								<c:choose>
									<c:when test="${pagination.totalPage<=7}">
										<c:set var="num" value="1" />
										<c:forEach var="x" begin="1" end="${pagination.totalPage}"
											step="1">
											<c:choose>
												<c:when test="${num==pagination.pageNumber}">
													<li class="paginItem current"><a href="#"
														onclick="fanye(${num})" style="color: #0C0C0C">${num}</a></li>
												</c:when>
												<c:otherwise>
													<li class="paginItem"><a href="#"
														onclick="fanye(${num})" style="color: #0C0C0C">${num}</a></li>
												</c:otherwise>
											</c:choose>
											<c:set var="num" value="${num+1}" />
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when
												test="${pagination.pageNumber<=3&&pagination.pageNumber>=1}">
												<c:set var="num" value="1" />
												<c:forEach var="x" begin="1" end="6" step="1">
													<c:choose>
														<c:when test="${num==pagination.pageNumber}">
															<li class="paginItem current"><a href="#"
																onclick="fanye(${num})" style="color: #0C0C0C">${num}</a>
															</li>
														</c:when>
														<c:otherwise>
															<li class="paginItem"><a href="#"
																onclick="fanye(${num})" style="color: #0C0C0C">${num}</a>
															</li>
														</c:otherwise>
													</c:choose>
													<c:set var="num" value="${num+1}" />
												</c:forEach>
												<li class="paginItem more"><a href="#"
													onclick="fanye(7)" style="color: #0C0C0C">..</a></li>
											</c:when>

											<c:otherwise>
												<c:choose>
													<c:when
														test="${pagination.pageNumber<pagination.totalPage-2&&pagination.pageNumber>3}">
														<li class="paginItem more"><a href="#"
															onclick="fanye(${pagination.pageNumber-3})"
															style="color: #0C0C0C">..</a></li>
														<c:set var="num" value="${pagination.pageNumber-2}" />
														<c:forEach var="x" begin="${pagination.pageNumber-2}"
															end="${pagination.pageNumber-1}" step="1">
															<li class="paginItem"><a href="#"
																onclick="fanye(${num})" style="color: #0C0C0C">${num}</a>
															</li>
															<c:set var="num" value="${num+1}" />
														</c:forEach>
														<li class="paginItem current"><a href="#"
															onclick="fanye(${pagination.pageNumber})"
															style="color: #0C0C0C">${pagination.pageNumber}</a></li>
														<c:set var="num1" value="${pagination.pageNumber+1}" />
														<c:forEach var="x" begin="${pagination.pageNumber+1}"
															end="${pagination.pageNumber+2}" step="1">
															<li class="paginItem"><a href="#"
																onclick="fanye(${num1})" style="color: #0C0C0C">${num1}</a>
															</li>
															<c:set var="num1" value="${num1+1}" />
														</c:forEach>
														<li class="paginItem more"><a href="#"
															onclick="fanye(${pagination.pageNumber+3})"
															style="color: #0C0C0C">..</a></li>

													</c:when>
													<c:otherwise>
														<li class="paginItem more"><a href="#"
															onclick="fanye(${pagination.totalPage-6})"
															style="color: #0C0C0C">..</a></li>
														<c:set var="num" value="${pagination.totalPage-5}" />
														<c:forEach var="x" begin="${pagination.totalPage-5}"
															end="${pagination.totalPage}" step="1">
															<c:choose>
																<c:when test="${num==pagination.pageNumber}">
																	<li class="paginItem current"><a href="#"
																		onclick="fanye(${num})" style="color: #0C0C0C">${num}</a>
																	</li>
																</c:when>
																<c:otherwise>
																	<li class="paginItem"><a href="#"
																		onclick="fanye(${num})" style="color: #0C0C0C">${num}</a></li>
																</c:otherwise>
															</c:choose>
															<c:set var="num" value="${num+1}" />
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
								<li class="paginItem"><a href="#"
									onclick="fanye(${pagination.pageNumber+1<=pagination.totalPage?pagination.pageNumber+1:pagination.totalPage})"
									style="color: #0C0C0C">></a></li>
								<li class="paginItem"><a href="#"
									onclick="fanye(${pagination.totalPage})" style="color: #0C0C0C">>></a></li>
							</ul>
						</div>
						</c:if>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="loginbm">
		&copy; 版权所有 2016 <a ondragstart="return false" href="#">重庆大学软件学院</a>
	</div>
</body>
</html>