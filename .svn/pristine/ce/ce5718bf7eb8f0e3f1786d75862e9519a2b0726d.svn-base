<%@ page import="java.util.List,com.jfinal.plugin.activerecord.Record,com.eyas.models.AttachFile" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
	<script type="text/javascript" src="${base}assets/uploadify/jquery.uploadify.min.js"></script>
	<link href="${base}assets/uploadify/uploadify.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
	var num=0;
	var uploadify;	
	$(function() {
		$("#file_upload").uploadify(
				{	
					queueID : 'some_file_queue',
					swf : '${base}assets/uploadify/uploadify.swf',
					uploader : '${base}news/upload',
					buttonImage : "${base}assets/uploadify/browse-btn.png",
					fileTypeExts : "*.*",
					onUploadSuccess : function(file, data, response) {
						if(num==0){
							document.getElementById("fj").style.display="";
						}
						var content='<tr><td><input type="text" class="form-control input-sm" id="doc_name_'+num+'" name="attach_name" ><input type="hidden" id="attach_file_'+num+'" name="attach_file"></td>';
						content+="<td><a href='#' id='df_"+num+"' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a></td></tr>";
						$("#fj").append(content);
						$("#doc_name_"+num).val(file.name);
						$("#attach_file_"+num).val(data);
						document.getElementById("df_"+num).href="${base}news/downLoad?attach_file="+data;
						var trix = data.substring(data.lastIndexOf(".") + 1)
								.toUpperCase();
						num++;
					}
				});
	});
	
	function removetr(obj){
		$.dialog.confirm("确定是否删除该附件？", function(){
			$(obj).parent().parent().remove(); 
		}, function(){
		    return;
		});
	}
	
	</script>
  </head>
  <body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">基础设置</a></li>
			<li><a href="#">新闻管理</a></li>
			<li><a href="#">修改新闻</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div class="formtitle">
			<span>发布</span>
		</div>
		<form action="${base}news/txEditNews" method="post" class="form-horizontal validate-form">
			<input type="hidden" name="flag" value="save"/>
			<input type="hidden" name="news_id" value="${oneNews.news_id}"/>
			<cqu:formcols cols="1">
				<col label="类型">
					<select name="news_type_id" class="form-control input-sm" >
						<c:forEach items="${typeList}" var="list">
							<option value="${list.news_type_id }" ${oneNews.news_type_id==list.news_type_id?"selected='selected'":"" }>${list.news_type_name}</option>
						</c:forEach>
					</select>
				</col>
				<col label="标题" required="required"  >
					<input type="text" class="form-control input-sm" name="title" datatype="*" value="${oneNews.title }"/>
				</col>
				<col label="内容" full="full">
					<textarea class="editor" name="content" cols="105" style="height:350px;">${oneNews.content }</textarea>
				</col>
				</col>
				<col label="附件">
				<div id="file_upload"></div>
				<table class="table table-bordered" id="fj" style="width: 770px;">
					<tr>
						<td width="600px;">名称</td>
						<td width="270px;">操作</td>
					</tr>
					<c:forEach items="${attachList }" var="data" varStatus="i" >
					<tr>
						<td>
							<input type="text" class="form-control input-sm" id="doc_name" name="attach_name" value="${data.file_name }" readonly>
							<input type="hidden" id="attach_file" name="attach_file" value="${data.file_path } ">
						</td>
						
						<td>
							<a href="${base}news/downLoad?attach_file=${data.file_path }" id='df' class='tablelink'>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href='#' class='tablelink confirm' onclick='removetr(this)'>删除</a>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div id="some_file_queue" /></div>
				</col>
				<col label="访客可见" full="full">
					<select name="view_for_guest" class="form-control input-sm" >
						<option value="1" ${oneNews.view_for_guest==1?"selected='selected'":"" }>访客可见</option>
						<option value="0" ${oneNews.view_for_guest==0?"selected='selected'":"" }>访客不可见</option>
					</select>
				</col>
				<col label="&nbsp;">
					<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-floppy-disk"></span>提交</button>
					<button type="reset" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span>重置</button>
				</col>
			</cqu:formcols>
		</form>
	</div>
</body>
</html>