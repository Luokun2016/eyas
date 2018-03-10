<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="me" uri="/WEB-INF/tld/cqu.tld" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>欢迎登录雏鹰计划信息管理系统</title>
<link href="${base}assets/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script src="${base}assets/js/cloud.js" type="text/javascript"></script>
<script type="text/javascript" src="${base}assets/js/Validform_v5.3.2.js"></script>
<script type="text/javascript" src="${base}assets/lhgdialog/lhgdialog.min.js?skin=blue"></script>
<script type="text/javascript" src="${base}assets/js/common.js"></script>
<script type="text/javascript" src="${base}assets/js/cloud.js"></script>
<script language="javascript">
	if( window.top == window.self ){
	    
	}else{
		window.top.location.href = window.self;
	}
	var ERROR_MSG="${PAGE_ERROR}";
	$(function() {
		$('.loginbox').css({
			'position' : 'absolute',
			'left' : ($(window).width() - 692) / 2
		});
		$(window).resize(function() {
			$('.loginbox').css({
				'position' : 'absolute',
				'left' : ($(window).width() - 692) / 2
			});
		});
	});
	function getCompanyList(){
		if($("#company_id").val()!=""){
			$("form")[0].submit();
			return;
		}
		$.dialog.tips('登录中,请稍后...',600,'loading.gif');
		$(".loginSelect")[0].options.length=0;
		$.ajax({
			url : "${base}index/getCompanyByUser",
			method : "post",
			data : {"user_name": $("#user_name").val(), "rnd":Math.random()},
			success : function(d){
				if(d.clist.length==0){
					$.dialog.tips('登录失败！',1,'error.gif');
					return;
				}
				var clist = $(".loginSelect");
				for(var i=0;i<d.clist.length;i++){
					clist.append("<option value='"+d.clist[i].company_id+"'>"+d.clist[i].company_name+"</option>");
				}
				if(d.clist.length==1){
					$("form")[0].submit();
				}else if(d.clist.length>1){
					$.dialog.tips('请选择要登录的单位！',1);
				}else{
					$.dialog.tips('用户名或者密码错误！',1);
				}
			}
		});
	}
</script> 
</head>

<body style="background-color:#1c77ac; background-image:url(${base}assets/imglight.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>
	<div class="logintop">
		<span>雏鹰计划信息管理系统</span>
	</div>

	<div class="loginbody">
    	<div class="systemlogo" style="text-align:center;"><img src="${base}assets/img/loginlogo2.png" alt="" /></div> 
	    <div class="loginbox">
	    	<form action="${base}index/login" method="post">
				<ul>
					<li>
					<h1 style="!important;">系统正在维护中！预计2015年11月4日下午两点开放！</h1>
					</li>
				</ul>
	    	</form>
		</div>
    </div>
    <div class="loginbm">&copy; 版权所有 2016 <a ondragstart="return false"  href="#">重庆大学软件学院</a></div>
</body>
</html>