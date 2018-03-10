<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
	<script type="text/javascript">
	function back(){
		window.location.href="${base}index/body";
	};
	function check(){
		//检测出生日期是否错误
		if($("#birthday").val()!=""&&!compare("birthday","出生日期错误！","${nowDete}")){
			return false;
		}
		//检测入职日期是否错误
		if($("#entry_date").val()!=""&&!compare("entry_date","入职日期错误！","${nowDete}")){
			return false;
		}
		return true;
	}
	</script>
  </head>
  <body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">个人信息</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>修改个人信息</span>
		</div>
		<form action="${base}index/txEditPerson" method="post" class="form-horizontal validate-form" onsubmit="return check();">
			<input type="hidden" name="flag" value="update"/>
			<input type="hidden" name="user_id" value="${user.user_id }" id="uid"/>
			<cqu:formcols cols="1">
				<col label="所属机构"  >
					<input type="text" readonly="readonly" class="form-control input-sm" name="pname" value="${user.org_name }"/>
				</col>
				<col label="用户名" >
					<input type="text" class="form-control input-sm checkItem" name="user_pin" readonly="readonly" value="${user.user_pin }"/>
				</col>
				<col label="姓名" required="required"  >
					<input type="text" class="form-control input-sm" name="user_name" datatype="*" value="${user.user_name }"/>
				</col>
				<col label="别名" >
					<input type="text" class="form-control input-sm checkItem" name="user_alias" value="${user.user_alias }"/>
				</col>
				<col label="性别" required="required"  >
					<select name="gender" class="form-control input-sm"  >
						<option value="0" ${user.gender==0?"selected='selected'":"" }>男</option>
						<option value="1" ${user.gender==1?"selected='selected'":"" }>女</option>
					</select>
				</col>
				<col label="部门"  >
					<input type="text" readonly="readonly" class="form-control input-sm" value="${user.dep_name }"/>
				</col>
				<col label="岗位"  >
					<input type="text" readonly="readonly" class="form-control input-sm" value="${user.post_name }"/>
				</col>
				<col label="联系电话" required="required"  >
					<input type="text" class="form-control input-sm" name="tel" datatype="m" value="${user.tel }"/>
				</col>
				<col label="出生日期" >
					<input type="text" class="form-control input-sm Wdate date" name="birthday" id="birthday" onchange="check();"  value="${user.birthday }"  />
				</col>
			
				<col label="身份证号" >
					<input type="text" class="form-control input-sm needVaild" name="card_no"  value="${user.card_no }" datatype="/(^\d{17}(\d|x)$)|(^\s{0}$)/i" />
				</col>
				<col label="住址" >
					<input type="text" class="form-control input-sm" name="addr"  value="${user.addr }"/>
				</col>
				<col label="电子邮箱"   >
					<input type="email" class="form-control input-sm needVaild" name="email"  value="${user.email }" datatype="/(^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$)|(^\s{0}$)/g"/>
				</col>
				<col label="QQ"   >
					<input type="text" class="form-control input-sm needVaild" name="qq"  value="${user.qq }" datatype="/(^\d{6,13}$)|(^\s{0}$)/" />
				</col>
				<col label="入职日期" >
					<input type="text" class="form-control input-sm Wdate date" name="entry_date" onchange="check();" id="entry_date" value="${user.entry_date }"/>
				</col>
				<col label="个人介绍" full="full">
					<textarea class="simple-editor" name="user_desc" cols="105">${user.user_desc }</textarea>
				</col>
				<col label="&nbsp;">
					<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span>保存</button>
					<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
					<button type="button" class="btn btn-default" onclick="back();">返回</button>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>