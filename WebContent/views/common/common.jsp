<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="utf-8">
<title>雏鹰计划信息管理系统</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="${base}assets/css/bootstrap.css" media="screen"/>
<link href="${base}assets/css/style.css" rel="stylesheet" type="text/css" />
<link href="${base}assets/css/global.css" rel="stylesheet" type="text/css" />

<script src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script src="${base}assets/js/bootstrap.min.js"></script>
<script src="${base}assets/js/select-ui.min.js"></script>
<script type="text/javascript" src="${base}assets/my97/WdatePicker.js"></script>
<script type="text/javascript" src="${base}assets/js/Validform_v5.3.2.js"></script>
<script type="text/javascript" src="${base}assets/js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="${base}assets/lhgdialog/lhgdialog.min.js?skin=discuz"></script>
<script charset="utf-8" src="${base}assets/kindeditor/kindeditor-min.js"></script>
<script charset="utf-8" src="${base}assets/kindeditor/lang/zh_CN.js"></script>
<%-- <script src="${base}assets/js/common.js?abc"></script> --%>
<script src="${base}assets/js/common.js"></script>

<script>
var _BASE_ = "${base}";
var ERROR_MSG = "${PAGE_ERROR}";
$(function(){
	$(".select1").uedSelect({
		width : 345			  
	});
	$(".select2").uedSelect({
		width : 167  
	});
	$(".select3").uedSelect({
		width : 100
	});
	$(".date").bind("click",function(){WdatePicker({dateFmt:"yyyy-MM-dd"});});
	$(".datetime").bind("click",function(){WdatePicker({dateFmt:"yyyy-MM-dd HH:mm"});});
});
</script>
<style>
.required{color:red !important;display: inline;margin-right:3px;margin-left:3px;}
body{min-width: 980px;}
.ztree{overflow-x:auto;}
</style>