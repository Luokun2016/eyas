<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
<link rel="stylesheet"
	href="${base}assets/jtree/css/zTreeStyle/zTreeStyle.css"
	type="text/css">
<script type="text/javascript"
	src="${base}assets/jtree/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="${base}assets/jtree/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript"
	src="${base}assets/jtree/js/jquery.ztree.exedit-3.5.js"></script>
<SCRIPT type="text/javascript">
	var zTreeObj;
	var setting = {
		check : {
			enable : true
		},
		data : {
			simpleData : {
				enable : true
			}
		}
	};

	$(document).ready(
			function() {
				var role_id = $("#role_id").val();
				$.ajax({
					url : "${base}permission/getPermiss",
					type : "post",
					data : {
						role_id : role_id
					},
					dataType : "json",
					success : function(data) {
						var childNodes = data.allpermiss;
						var curchildNodes = data.curpermiss;
						var l = childNodes.length;
						var array = new Array();
						for (var i = 0; i < l; i++) {
							var bool = in_array(childNodes[i].permiss_id,
									curchildNodes);
							array[i] = {
								id : childNodes[i].permiss_id,
								name : childNodes[i].permiss_name,
								pId : childNodes[i].parent_id,
								checked : bool
							};
						}
						zNodes = array;
						zTreeObj = $.fn.zTree.init($("#permissionTree"),
								setting, zNodes);
						zTreeObj.expandAll(true); 
					}
				});
			});

	function in_array(search, array) {
		for ( var i in array) {
			if (array[i].permiss_id == search) {
				return true;
			}
		}
		return false;
	}

	function submitCheckedNodes(treeNode) {
		var nodes = new Array();
		//取得选中的结点  
		nodes = zTreeObj.getCheckedNodes(true);
		var str = "";
		for (i = 0; i < nodes.length; i++) {
			if (str != "") {
				str += ",";
			}
			str += nodes[i].id;
		}
		$("#permiss_array").val(str);
	}
</SCRIPT>
</head>
<body>
	<div class="place">
		<div class="pull-right backbtn">
			<a href="${base}permission/index">返回上页</a>
		</div>
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">系统管理</a></li>
			<li><a href="#">角色管理</a></li>
			<li><a href="#">角色权限</a></li>
		</ul>
	</div>
	<div class="formbody">
		<form action="${base}permission/txadd" method="post"
			class="search-form form-inline">
			<input type="hidden" id="role_id" name="role_id"
				value="${role.role_id}"> <input type="hidden"
				id="permiss_array" name="permiss_array">
			<ul class="seachform">
				<li><label>角色</label> <input type="text"
					value="${role.role_name}" class="scinput" readonly="readonly" /></li>
				<li>
					<button class="btn btn-primary btn-sm"
						onclick="submitCheckedNodes()">
						<span class="glyphicon glyphicon-ok"></span> 保存设置
					</button>
				</li>
			</ul>
		</form>
		<div class="formtitle">
			<span>权限设置</span>
		</div>
		<div class="row">
			<div class="col-md-6 col-xs-6">
				<div class="zTreeFm">
					<ul id="permissionTree" class="ztree"></ul>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
