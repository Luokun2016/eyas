<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld"%>
<cqu:right>
	<!DOCTYPE html>
	<html>
<head>
<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet"
	type="text/css" />
<script language="JavaScript"
	src="${base}assets/jq/jquery-1.10.2.min.js"></script>
<script src="${base}assets/js/md5.js" type="text/javascript"></script>
<jsp:include page="../common/common.jsp"></jsp:include>
<link href="http://libs.baidu.com/bootstrap/3.0.3/css/bootstrap.min.css"
	rel="stylesheet">
<script src="http://libs.baidu.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>

<script type="text/javascript">
	function getSchoolList() {
		var school_type = $("#school_type").val();					
			$.ajax({
					type : "POST",
					url : "${base}user/getSchool",
					data : {
						"school_type" : school_type
					},					
					success : function(data) {
						if ("" == data) {
							alert("不存在对应类型下的学校");
							$("#searchSchool_id").empty();
							$("#searchSchool_id").append(
									"<option value='"+-1+"'>所有</option>");
						} else {
							$("#searchSchool_id").empty();
							$("#searchSchool_id").append(
									"<option value='"+-1+"'>所有</option>");
							var schoolList = data.schoolList;
							//对获取到的数据进行迭代  
							for (var i = 0; i < schoolList.length; i++) {
								var id = schoolList[i].school_id;
								var name = schoolList[i].school_name;
								$("#searchSchool_id").append(
										"<option value='" + id + "'>" + name
												+ "</option>");
							}
						}
					},
					error : function(jqXHR) {
						alert("发生错误：" + jqXHR.status);
					}
				});
	}
	
	function isSubmit() {
		var value = $("#userAddType").val();
		if (value == -1) {
			$.dialog.tips("请选择用户类别");
			return false;
		} else {
			return true;
		}
	}
</script>

</head>
<body>
	<form action="${base}user/addInitialize" method="post"
		onsubmit="return isSubmit()">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
						<h4 class="modal-title" id="myModalLabel">请选择用户类别</h4>
					</div>
					<div class="modal-body">
						<div class="col-md-6">
							<div class="input-group">
								<span class="input-group-addon input-sm">用户类别</span> <select
									name="userAddType" id="userAddType"
									class="form-control input-sm">
									<option value="-1">请选择</option>
									<c:forEach items="${userTypeList}" var="bat">
										<option value="${bat.role_id}">${bat.role_name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div class="modal-footer" style="margin-top: 28px;">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭
						</button>
						<button type="submit" class="btn btn-primary">确定</button>
					</div>
				</div>
			</div>
		</div>
	</form>



	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">用户管理</a></li>
		</ul>
	</div>

	<form action="${base}user/index" method="post"
		class="search-form form-inline">
		<div class="rightinfo">
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">用户名</span> <input
							type="text" name="userName" class="form-control input-sm"
							value="${userName}" />
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">姓名</span> <input
							type="text" name="searchName" class="form-control input-sm"
							value="${searchName}" />
					</div>
				</div>

				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">单位类别</span> <select
							id="school_type" name="school_type" class="form-control input-sm"
							onchange="getSchoolList()">
							<option value="-1" ${school_type==-1?"selected='selected'":"" }>全部</option>
							<c:if test="${bigRole==6}">
								<option value="0" ${school_type==0?"selected='selected'":"" }>高校</option>
								<option value="1" ${school_type==1?"selected='selected'":"" }>中学</option>
								<option value="2" ${school_type==2?"selected='selected'":"" }>创新学院</option>
							</c:if>
							<c:if test="${bigRole==2}">
								<option value="1" ${school_type==1?"selected='selected'":"" }>中学</option>
							</c:if>
							<c:if test="${bigRole==4}">
								<option value="0" ${school_type==0?"selected='selected'":"" }>高校</option>
							</c:if>
						</select>
					</div>
				</div>

				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">学校名称</span> <select
							id="searchSchool_id" name="searchSchool_id"
							class="form-control input-sm">
							<option value="-1"
								${searchSchool_id==-1?"selected='selected'":"" }>所有</option>
							<c:forEach items="${schoolList}" var="bat">
								<option value="${bat.school_id}"
									${searchSchool_id==bat.school_id?"selected='selected'":"" }>${bat.school_name}</option>
							</c:forEach>
						</select>
					</div>
				</div>


				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">用户状态</span> <select
							name="user_status" class="form-control input-sm">
							<option value="-1" ${user_status==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${user_status==0?"selected='selected'":"" }>正常</option>
							<option value="1" ${user_status==1?"selected='selected'":"" }>禁用</option>
							<option value="2" ${user_status==2?"selected='selected'":"" }>删除</option>
						</select>
					</div>
				</div>

				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">审核状态</span> <select
							name="check_status" class="form-control input-sm">
							<option value="-1" ${check_status==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${check_status==0?"selected='selected'":"" }>未审核</option>
							<option value="1" ${check_status==1?"selected='selected'":"" }>审核通过</option>
							<option value="2" ${check_status==2?"selected='selected'":"" }>审核未通过</option>
						</select>
					</div>
				</div>


				<div class="col-md-4 margin5 ">
					<button type="submit" class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-search "></span>查询
					</button>
					&nbsp;&nbsp;&nbsp;&nbsp; <a pm="JCGL_YHGL_ADDINIT" href="#" class="btn btn-default btn-sm"
						data-toggle="modal" data-target="#myModal"><span></span>添加用户</a>
				</div>
			</div>
		</div>
	</form>

	<div class="formtitle">
		<span>用户列表</span>
	</div>
	<table class="tablelist">
		<thead>
			<tr>
				<th>用户名</th>
				<th>姓名</th>
				<th>所在学校</th>
				<th>注册类型</th>
				<th>用户状态</th>
				<th>审核状态</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:set value="0" var="index" />
			<c:forEach items="${pagination.list}" var="data" varStatus="i">
				<c:set value="1" var="index"></c:set>
				<tr>
					<td>${data.user_name}</td>
					<td>${data.name}</td>
					<td>${data.school_name}</td>

					<c:if test="${data.user_type==0}">
						<td>中学学生</td>
					</c:if>
					<c:if test="${data.user_type==1}">
						<td>中学教师</td>
					</c:if>
					<c:if test="${data.user_type==2}">
						<td>中学管理员</td>
					</c:if>
					<c:if test="${data.user_type==3}">
						<td>高校教师</td>
					</c:if>
					<c:if test="${data.user_type==4}">
						<td>高校管理员</td>
					</c:if>
					<c:if test="${data.user_type==5}">
						<td>创新学院用户</td>
					</c:if>
					<c:if test="${data.user_type==6}">
						<td>创新学院管理员</td>
					</c:if>

					<c:if test="${data.user_status==0}">
						<td>正常</td>
					</c:if>
					<c:if test="${data.user_status==1}">
						<td>禁用</td>
					</c:if>
					<c:if test="${data.user_status==2}">
						<td>删除</td>
					</c:if>

					<c:if test="${data.check_status==0}">
						<td>未审核</td>
					</c:if>
					<c:if test="${data.check_status==1}">
						<td>审核通过</td>
					</c:if>
					<c:if test="${data.check_status==2}">
						<td>审核未通过</td>
					</c:if>

					<td width="150"><a pm="JCGL_YHGL_EDITINIT" 
						href="${base}user/userEdit?user_id=${data.user_id}&school_id=${data.school_id}"
						class="tablelink">修改</a> <a pm="JCGL_YHGL_VIEW" 
						href="${base}user/userView?user_id=${data.user_id}"
						class="tablelink">查看</a> <c:if test="${data.user_status==0}">
							<a pm="JCGL_YHGL_DISABLE" href="${base}user/userForbidden?user_id=${data.user_id}"
								class="tablelink confirm">禁用</a>
						</c:if> <c:if test="${data.user_status==1}">
							<a pm="JCGL_YHGL_ENABLE" href="${base}user/userUnForbidden?user_id=${data.user_id}"
								class="tablelink confirm">启用</a>
						</c:if> <a pm="JCGL_YHGL_DEL" 
						href="${base}user/userDelete?user_id=${data.user_id}"
						class="tablelink">删除</a> <c:if test="${data.check_status==0||data.check_status==2}"><a pm="JCGL_YHGL_CHECKINIT" href="${base}user/userCheck?user_id=${data.user_id}"
						class="tablelink">审核</a></c:if></td>
				</tr>
			</c:forEach>
			<c:if test="${index==0}">
				<tr>
					<td colspan="100">没有找到数据！</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<jsp:include page="../common/paginate.jsp"></jsp:include>
</body>
	</html>
</cqu:right>