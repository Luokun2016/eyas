<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/common.jsp"></jsp:include>
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
			<li><a href="#">角色用户</a></li>
		</ul>
	</div>
	<div class="formbody">
		<form action="${base}permission/getUserPermission" method="post"
			class="search-form form-inline">
			<input type="hidden" value="${role.role_id}" name="role_id" />
			<div class="row">
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">角色名称</span> <input
							type="text" class="form-control input-sm" readonly="readonly"
							value="${role.role_name}" />
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学校</span> <select
							id="schoolId" name="schoolId" class="form-control input-sm">
							<option value="-1"
								${schoolId==-1||schoolId==null?"selected='selected'":"" }>全部</option>
							<c:forEach items="${slist}" var="ins">
								<option value="${ins.school_id }"
									${schoolId==ins.school_id?"selected='selected'":"" }>${ins.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">用户名</span> <input
							type="text" class="form-control input-sm" id="userName" name="userName" value="${userName}"/>
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">姓名</span> <input
							type="text" class="form-control input-sm" id="searchName" name="searchName" value="${searchName}"/>
					</div>
				</div>
				<div class="col-md-2 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">注册类型</span> <select
							id="userType" name="userType" class="form-control input-sm">
							<option value="-1" ${userType==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${userType==0?"selected='selected'":"" }>中学生</option>
							<option value="1" ${userType==1?"selected='selected'":"" }>中学教师</option>
							<option value="2" ${userType==2?"selected='selected'":"" }>中学管理员</option>
							<option value="3" ${userType==3?"selected='selected'":"" }>高校教师</option>
							<option value="4" ${userType==4?"selected='selected'":"" }>高校管理员</option>
							<option value="6" ${userType==6?"selected='selected'":"" }>系统管理员</option>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>角色用户管理</span>
		</div>
		<div class="row">
			<div class="col-md-5 col-xs-5">
				<label>系统用户</label> <select multiple="multiple" class="form-control"
					style="height: 300px;" id="nselu">
					<c:forEach var="data" items="${nUser}">
						<c:if test="${data.user_type==0}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：中学生 ]</option>
						</c:if>
						<c:if test="${data.user_type==1}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：中学教师 ]</option>
						</c:if>
						<c:if test="${data.user_type==2}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：中学管理员 ]</option>
						</c:if>
						<c:if test="${data.user_type==3}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：高校教师 ]</option>
						</c:if>
						<c:if test="${data.user_type==4}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：高校管理员 ]</option>
						</c:if>
						<c:if test="${data.user_type==5}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：创新学院用户 ]</option>
						</c:if>
						<c:if test="${data.user_type==6}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：创新学院管理员 ]</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div class="col-md-1 col-xs-1">
				<br />
				<br />
				<br />
				<br />
				<br />
				<br />
				<div class="btn-group-vertical">
					<button class="btn btn-default" onclick="join()">
						<span class="glyphicon glyphicon-arrow-right"></span> 加入
					</button>
					<button class="btn btn-default" onclick="mremove()">
						<span class="glyphicon glyphicon-arrow-left"></span> 移除
					</button>
				</div>
			</div>
			<div class="col-md-5 col-xs-5">
				<label>角色用户</label> <select multiple="multiple" class="form-control"
					style="height: 300px;" id="cselu">
					<c:forEach var="data" items="${curList}">
						<c:if test="${data.user_type==0}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：中学生 ]</option>
						</c:if>
						<c:if test="${data.user_type==1}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：中学教师 ]</option>
						</c:if>
						<c:if test="${data.user_type==2}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：中学管理员 ]</option>
						</c:if>
						<c:if test="${data.user_type==3}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：高校教师 ]</option>
						</c:if>
						<c:if test="${data.user_type==4}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：高校管理员 ]</option>
						</c:if>
						<c:if test="${data.user_type==5}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：创新学院用户 ]</option>
						</c:if>
						<c:if test="${data.user_type==6}">
						<option value="${data.user_id}">${data.user_name}&nbsp;&nbsp;(${data.name})&nbsp;&nbsp;[
							${data.school_name} ]&nbsp;&nbsp;[
							注册类型：创新学院管理员 ]</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>

	<form action="${base}permission/txAddUser" class="hide" id="add">
		<input type="text" name="flag" id="flag" /> <input type="text"
			value="${role.role_id}" name="role_id" /> <input type="text"
			id="user_id" name="user_id" />
	</form>
	<script type="text/javascript">
		function join() {
			var j = $("#nselu").val();
			if (j == null) {
				$.dialog({
					title : "温馨提示",
					content : "请点击选择一个用户后加入",
					min : false,
					max : false
				});
				return;
			}
			$("#flag").val("add");
			$("#user_id").val($("#nselu").val());
			$("#add")[0].submit();
		}
		function mremove() {
			var j = $("#cselu").val();
			if (j == null) {
				$.dialog({
					title : "温馨提示",
					content : "请点击选择一个用户后加入",
					min : false,
					max : false
				});
				return;
			}
			$("#flag").val("remove");
			$("#user_id").val($("#cselu").val());
			$("#add")[0].submit();
		}
	</script>
</body>
</html>
