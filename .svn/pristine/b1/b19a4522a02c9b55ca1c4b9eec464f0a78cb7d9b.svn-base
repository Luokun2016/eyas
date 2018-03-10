<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style.css" rel="stylesheet" type="text/css" />
<script src="${base}assets/jq/jquery-1.10.2.min.js"></script>

<script language="javascript">
	$(function() {
		$('.error').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 490) / 2
		});
		$(window).resize(function() {
			$('.error').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 490) / 2
			});
		});
	});
</script>
</head>
<body style="background: #edf6fa;">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">500错误提示</a></li>
		</ul>
	</div>
	<div class="error">
		<h2>非常遗憾，系统发生异常，请联系管理员来解决！</h2>
		<p>
			${exception}
		</p>
		<div class="reindex">
			<a href="${base}index/index" target="_parent">返回首页</a>
		</div>
	</div>
</body>
</html>