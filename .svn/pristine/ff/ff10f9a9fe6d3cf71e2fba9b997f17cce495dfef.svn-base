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

		function check() {
			//检查所有密码是否为空
		var oldcode = document.forms[0].oldcode;
		var newcode = document.forms[0].newcode;
		var copycode = document.forms[0].copycode;
			if (oldcode.value.length == 0) {
				$.dialog({
					lock : false,
					title : '提示信息',
					width : 220, /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
					content : "请填写您的原密码！",
					min : false,
					max : false,
					opacity : 0.1,
					ok : function() {
					}
				});
				oldcode.focus();
				return false;
			}
			if (newcode.value.length == 0) {
				$.dialog({
					lock : false,
					title : '提示信息',
					width : 220, /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
					content : "请填写您的新密码！",
					min : false,
					max : false,
					opacity : 0.1,
					ok : function() {
					}
				});
				newcode.focus();
				return false;
			}
			if (copycode.value.length == 0) {
				$.dialog({
					lock : false,
					title : '提示信息',
					width : 220, /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
					content : "请填写您的确认密码！",
					min : false,
					max : false,
					opacity : 0.1,
					ok : function() {
					}
				});
				copycode.focus();
				return false;
			}
			if(newcode.value.length < 6 || newcode.value.length > 20){
				$.dialog({
					lock: false,
				    title: '提示信息',
				    width: 220,  /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
				    content: "密码长度应为6-20位！",
				    min:false,
				    max:false,
				    opacity: 0.1,
				    ok: function () { }
				});
				newcode.value="";
				copycode.value="";
				newcode.focus();
				return false;
			}
			if(newcode.value.indexOf(" ")>=0){
				$.dialog({
					lock: false,
				    title: '提示信息',
				    width: 220,  /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
				    content: "密码不可包含空格！",
				    min:false,
				    max:false,
				    opacity: 0.1,
				    ok: function () { }
				});
				newcode.value="";
				copycode.value="";
				newcode.focus();
				return false;
			}
			if(newcode.value != copycode.value){
				$.dialog({
					lock: false,
				    title: '提示信息',
				    width: 220,  /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
				    content: "两次输入的密码不一致，请重新输入！",
				    min:false,
				    max:false,
				    opacity: 0.1,
				    ok: function () { }
				});
				newcode.value="";
				copycode.value="";
				newcode.focus();
				return false;
			}
			return true;
		};
	</script>
  </head>
  <body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">修改密码</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>修改密码</span>
		</div>
		<form onsubmit="return check();" action="${base}index/txEditPwd" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="flag" value="update"/>
			<input type="hidden" name="user_id" value="${user_id }" id="uid"/>
			<cqu:formcols cols="1">
				<col label="原密码" required="required"  >
					<input type="password" class="form-control input-sm" name="oldcode"/>
				</col>
				<col label="新密码"  required="required">
					<input type="password" class="form-control input-sm" name="newcode" title="长度为6-20个字符"/>
				</col>
				<col label="确认密码" required="required"  >
					<input type="password" class="form-control input-sm" name="copycode"/>
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