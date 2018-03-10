var editors = new Array();

(function(config){
	config['extendDrag'] = true;
	config['minWidth'] = 500;
    config['fixed'] = true;
    config['background'] = "#FFF";
    config['opacity'] = .1;
    config['okVal'] = '确定';
    config['cancelVal'] = '取消';
})($.dialog.setting);
$(function(){
	var validform = $(".validate-form").Validform({
		showAllError : false,
		tiptype : 2
	});
	// 如果只设置一个或少量全局配置也可这样：
	$.dialog.setting.extendDrag = true;
	if(ERROR_MSG.length>0){
		//$.dialog({title: "提示信息",content: ERROR_MSG,min:false,max:false});
		$.dialog({
			lock: false,
		    title: '提示信息',
		    width: 320,  /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
		    content: ERROR_MSG,
		   // time: 1,
		    min:false,
		    max:false,
		    opacity: 0.1,
		    ok: function () { }
		});
	}
	$(".group").click(function(){
		var g = $(this).attr("group");
		$("."+g).prop("checked", $(this).prop("checked"));
	});
	$('.tablelist tbody tr:odd').addClass('odd');
	$(".confirm").click(function(){
		var _href = $(this).attr("href");
		var _title = typeof($(this).attr("title"))=="undefined"?"您确定要执行这个操作吗？":$(this).attr("title");
		$.dialog.confirm(_title, function(){
			location.href=_href;
		}, function(){
		    $.dialog.tips('取消操作!');
		});
		return false;
	});
	$(".btn-del").click(function(){
		var r = $(this).attr("rel");
		var s = "0";
		var isChecked = false;
		$("input[type='checkbox'][name='"+r+"']:checked").each(function(){
			s += ","+$(this).val();
			isChecked=true;
		});
		if(!isChecked){
			$.dialog.tips('请先选择数据!');
			return false;
		}
		var _title = typeof($(this).attr("title"))=="undefined"?"您确定要执行这个操作吗？":$(this).attr("title");
		$.dialog.confirm(_title, function(){
			if($(this).attr("href").indexOf("?")==-1){
				location.href=$(this).attr("href")+"?"+r+"="+s;
			}else{
				location.href=$(this).attr("href")+"&"+r+"="+s;
			}
		}, function(){
		    $.dialog.tips('取消操作!');
		});
		return false;
	});
	$(".editor").each(function(){
		var r = false;
		if($(this).attr("readonly")=="readonly"){
			r = true;
		}
		editor = KindEditor.create(this, {
			resizeType : 1,
			id : $(this).attr("id"),
			allowPreviewEmoticons : false,
			uploadJson : _BASE_+"news/imgUpload",  
			allowFileManager : false,
			allowImageUpload : true,
			readonlyMode : r,
			resizeType : 0,
			items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'image', 'attachment']
		});
		editors.push(editor);
	});
	$(".simple-editor").each(function(){
		var r = false;
		if($(this).attr("readonly")=="readonly"){
			r = true;
		}
		editor = KindEditor.create(this, {
			resizeType : 1,
			id : $(this).attr("id"),
			allowPreviewEmoticons : false,
			allowImageUpload : false,
			readonlyMode : r,
			resizeType : 0,
			items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'emoticons']
		});
		editors.push(editor);
	});
	$(".ime").each(function(){
		$(this).css({"ime-mode":"disabled"});
	});
	$("#tools-page").each(function(){
		$(this).css({"display":"none"});
		$("#tools-line").prepend($(this).html());
	});
	$(".selectall").bind("click",function(){
		var g = $(this).attr("group");
		var t = $(this).is(":checked");
		$("."+g).attr("checked", t);
	});
	$("th[sort]").each(function(){
		$(this).css({"cursor":"pointer","color":"#00AACD"});
		$(this).click(function(){
			if($("input[name='order']").length > 0){
				var sort=$(this).attr("sort");
				$("input[name='order']").each(function(){
					$(this).val(sort);
				});
			}else{
				$(".search-form").append("<input type='hidden' name='order' value='"+$(this).attr("sort")+"'/>");
			}
			$("input[name='ob_asc']").each(function(){
				var ob_asc=$(this).val();
				$(this).val(ob_asc=="a"?"d":"a");
			});
			$(".search-form")[0].submit();
		});
	});
});

//检测时间是否超过指定时间,dat
function compare(date_id,title,date){
	var beginDate = new Date($("#"+date_id).val().replace(/-/g,"/"));
	var endDate = new Date(date.replace(/-/g,"/"));
	if(endDate<beginDate){
		$.dialog({
			lock: false,
		    title: '提示信息',
		    width: 320,  /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
		    content: title,
		   // time: 1,
		    min:false,
		    max:false,
		    opacity: 0.1,
		    ok: function () { }
		});
		 $("#"+date_id).focus();
		return false;
	}
	return true;
}
//屏蔽回车
window.document.onkeydown=function(even){
	if(even.keyCode==13){
		event.keyCode=0;    
        event.returnValue=false;  
	}
}