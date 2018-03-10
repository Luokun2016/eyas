<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="cqu" uri="/WEB-INF/tld/cqu.tld" %>
<cqu:right>
<!DOCTYPE html>
<html>
   <head>
	<jsp:include page="../common/common.jsp"></jsp:include>
	<link rel="stylesheet" href="${base}assets/jtree/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${base}assets/jtree/js/jquery.ztree.core-3.5.js"></script>
  	<script type="text/javascript" src="${base}assets/jtree/js/jquery.ztree.core-3.5.js"></script>
	<script type="text/javascript" src="${base}assets/jtree/js/jquery.ztree.excheck-3.5.js"></script>
	<script type="text/javascript" src="${base}assets/jtree/js/jquery.ztree.exedit-3.5.js"></script>
    <style>
    	ul.ztree{width:100%;min-height:80%;border: 1px solid #DDD;background-color:white;overflow-y:auto;overflow-x:auto;margin-top:0px;}
    	ul.ztree a:hover {
		    background-color: #3eafe0;
		    color: white;
		}
    	#orgmsg{overflow: hidden;white-space: nowrap;text-overflow: ellipsis;display:block;cursor:pointer;
    		font-weight:bold;color:black;font-size:12px;margin-bottom:5px;
    	}
    </style>
    <script>
	   var setting = {
		   data : {
				simpleData : {
					enable : true
				}
			},
		    callback: {
		        onClick: zTreeOnClick,
		        onAsyncSuccess : aSuccess,
		    },
		    async: {
				enable: true,
				url:"${base}institution/ajax",
				otherParam:["flag", "c"]
			}
	    };
	    //当前机构父节点
		var pnode=null;
	    var siblUrl="";
	    function zTreeOnClick(event, treeId, treeNode) {
	        $("#pid").val(treeNode["id"]);
	        $("#orgid").val(treeNode["id"]);
	        $("#org_submit").submit();
	    };
		function aSuccess(event, treeId, treeNode, msg){
			//设置节点选中
	        var zTree = $.fn.zTree.getZTreeObj("tree");
	        var node = zTree.getNodeByParam("id",$("#pid").val());
	        if(node){
	        	
	        	//获取父节点
		        pnode=node.getParentNode();
		        //根据选中节点的状态，设置添加子机构和平级机构的参数
		        if(node["state"]==0){  //节点已停用
		        	$("#addSon").attr("onclick","$.dialog.tips('该机构已停用，不能添加部门')");
		        }else{
			        $("#addSon").attr("href","${base}dept/txAdd?org_id="+node["id"]);
		        }
		        
		        $("#orgname").text(node["name"]).attr("title",node["name"]);
		        zTree.selectNode(node);
		        zTree.updateNode(node);
	        }
		}
	    $(document).ready(function(){
	    	$.fn.zTree.init($("#tree"), setting);
	     
	    });
	</script>
  </head>
  <body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">基础管理</a></li>
			<li><a href="#">部门管理</a></li>
		</ul>
	</div>
	<div class="rightinfo">
	<div class="col-md-2 col-xs-2">
			<p style="display:none" id="treeJson">${root }</p>
			<p id="orgmsg"> 当前机构：
				<span id="orgname" title="${org_name!=null?org_name:'所有机构'}">${org_name!=null?org_name:"所有机构"}</span>
			
			</p>
			<ul id="tree" class="ztree">

			</ul>
			<form action="${base}dept" method="post" class="search-form form-inline" id="org_submit">
				<input id="pid" type="hidden" class="form-control input-sm" name="orgId"  value="${orgId }"/>
				<button type="submit" style="display:none" ></button>
			</form>
			
		</div>
		<div class="col-md-10 col-xs-10">
		<form action="${base}dept" method="post" class="search-form form-inline">
			<div class="row">
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">名称</span>
						<input type="text" name="depName" class="form-control input-sm" value="${depName}"/>
					</div>
				</div>
				<div class="col-md-3 margin5">
					<div class="input-group">
						<span class="input-group-addon input-sm">状态</span>
						<select name="depState" class="form-control input-sm"  >
							<option value="-1" ${depState==-1?"selected='selected'":"" }>全部</option>
							<option value="0" ${depState==0?"selected='selected'":"" }>停用</option>
							<option value="1" ${depState==1?"selected='selected'":"" }>启用</option>
						</select>
					</div>
				</div>
				<div class="col-md-2 margin5 ">
					<button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-search"></span>查询</button>
					<a href="#" id="addSon" pm="JCGL_BMGL_ADD" class="btn btn-default btn-sm" ><span class="glyphicon glyphicon-plus"></span>添加</a>
				</div>
			</div>
		</form>
		<div class="formtitle">
			<span>信息列表</span>
		</div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>部门名称</th>
					<th>隶属机构</th>
					<th>状态</th>
					<th>操作人</th>
					<th>操作时间</th>
					<th width="150">#</th>
				</tr>
			</thead>
			<tbody>
				<c:set value="0" var="index"/>
				<c:forEach items="${pagination.list}" var="data" varStatus="i">
				<c:set value="1" var="index"></c:set>
					<tr>
						<td>${data.dep_name}</td>
						<td>${data.org_name}</td>
						<td>${data.dep_state==0?"停用":"启用"}</td>
						<td>${data.user_name}</td>
						<td><fmt:formatDate value="${data.opt_date}" pattern="yyyy-MM-dd HH:mm"/></td>
						<td>
								<c:set var="stopmsg" value="确定执行停用操作?"/>
							    <c:set var="delmsg" value="确定执行删除该部门?"/>
							    <c:forEach items="${deplist }"  var="dep">
							    	<c:if test="${dep.dep_id==data.dep_id }">
							    		<c:set var="stopmsg" value="停用该部门，将影响签报审批！是否仍要停用该部门？"/>
							   		 	<c:set var="delmsg" value="删除该部门，将影响签报审批！是否仍要删除该部门？"/>
							    	</c:if>
							    </c:forEach>
							<c:if test="${data.dep_state==1}">
								<a pm="JCGL_BMGL_TQY" href="${base}dept/txEditStatus?org_id=${data.org_id}&dep_id=${data.dep_id}&dep_state=0" title="${stopmsg }" class="tablelink confirm" >停用</a>
							</c:if>
							<c:if test="${data.dep_state!=1}">
								<a pm="JCGL_BMGL_TQY" href="${base}dept/txEditStatus?org_id=${data.org_id}&dep_id=${data.dep_id}&dep_state=1" title="确定执行启用操作?" class="tablelink confirm" >启用</a>
							</c:if>
							<a pm="JCGL_BMGL_EDIT" href="${base}dept/txEdit?org_id=${data.org_id}&dep_id=${data.dep_id}" class="tablelink">修改</a>
							<a pm="JCGL_BMGL_DEL" href="${base}dept/txDel?org_id=${data.org_id}&dep_id=${data.dep_id}" class="tablelink confirm" title="${delmsg }" >删除</a>
							
						</td>
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
		</div>
	</div>
</body>
</html>
</cqu:right>