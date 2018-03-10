$(function(){
	// 自动高度
	$(window.parent.document).find("#frameReport").load(function(){
		var main = $(window.parent.document).find("#frameReport");
		var thisheight = $(document).height()+30;
		main.height(thisheight);
	});
	var method = GetQueryString("method");
	// 查看原始HTML
	if(method==null){
		autoTags();
		dbTags();
		return;
	}else if(method==="search"){
		searchData(GetQueryString("taskId"));
	}
});
function searchData(taskId){
	$.ajax({
		url : "tags/searchReport",
		data : {"task_id": taskId},
		success : function(d){
			if(d.result==false){
				alert("没有找到数据！");
				return;
			}
			$("input").each(function(){
				var $this = $(this);
				var col = $(this).attr("cellcol");
				var row = $(this).attr("cellrow");
				for(var i=0;i<d.datas.length;i++){
					if(row==d.datas[i].t_rows_number){
						$this.val(d.datas[i]["t_"+col]);
					}
				}
			});
		}
	});
}
function autoTags(){
	var autoTags = new Array();
	// 自动标签[A]
	$("input[cellType='A']").each(function(){
		autoTags.push($(this).attr("id"));
	});
	$.ajax({
		url : "tags/autoTags?rnd="+Math.random(),
		data : {"tags":autoTags.join(",")},
		success : function(data){
			for(var o in autoTags){
				$("#"+autoTags[o]).val(data.tags[autoTags[o]]);
			}
		}
	});
	// 填写标签[F]，设置NUM只能填写数值
	$("input[cellType='F']").each(function(){
		if($(this).attr("id").indexOf("NUM")!=-1){
			// 如果是数字类型，则设定为只能输入数字
			$(this).keyup(function(){
		        var tmptxt=$(this).val();
		        $(this).val(tmptxt.replace(/[^0-9.]/g,''));
		    }).bind("paste",function(){
		        var tmptxt=$(this).val();
		        $(this).val(tmptxt.replace(/[^0-9.]/g,''));
		    }).css("ime-mode", "disabled");
		}
	});
}
function dbTags(){
	var taskId = GetQueryString("taskId");
	if(taskId==null){
		return;
	}
	var dbTags = new Array();
	// 数据库取值标签[D]
	$("input[cellType='D']").each(function(){
		dbTags.push($(this).attr("id"));
	});
	$.ajax({
		url : "tags/dbTags?rnd="+Math.random(),
		data : {"tags":dbTags.join(","), "task_id":taskId},
		success : function(data){
			for(var o in dbTags){
				document.getElementById(dbTags[o]).value=data.tags[dbTags[o]];
			}
		}
	});
}
function GetQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
}
String.prototype.replaceAll  = function(s1,s2){   
	return this.replace(new RegExp(s1,"gm"),s2);
};