var REPORT = {
	// 提交报表
	submit : function(reportId,reportFrmId,_url,_fn){
		REPORT.showMask(reportFrmId);
		// 检测数据
		var checkNum = REPORT.check(reportFrmId);
		if(checkNum>0){
			$.dialog({min: false, max: false, content: "您不能提交，有"+checkNum+"个数据未填写！"});
			REPORT.closeMask();
			return false;
		}
		// 构造JSON数据
		$.ajax({
			url : _url,
			method : "post",
			data : {"jsonData" : REPORT.getJsonData(reportFrmId), "reportId": reportId},
			success : _fn
		});
	},
	// 检查报表填写
	check : function(reportFrmId){
		$("#report_text span").text("检查报表数据...");
		var checkNum = 0;
		$(reportFrmId).contents().find("input").each(function(){
			if($(this).val().length==0){
				checkNum++;
				return;
			}
		});
		return checkNum;
	},
	getJsonData : function(reportFrmId){
		var jsonStr = "{";
		$(reportFrmId).contents().find("input").each(function(){
			jsonStr += "'"+$(this).attr("id")+"':'"+$(this).val()+"',";
		});
		return jsonStr.substring(0,jsonStr.length-1) + "}";
	},
	viewReportData : function(taskId){
		$.ajax({
			url : _BASE_ + "tags/searchReport?task_id="+taskId+"&flag=report",
			success : function(d){
				if(d.result==false){
					$.dialog({content: "没有找到数据",min:false,max:false});
					return;
				}else{
					$.dialog({
						content : "url:"+_BASE_+d.report+"?method=search&taskId="+taskId,
						min: false,max:false
					}).max();
				}
			}
		});
	},
	countReport : function(){
		
	},
	showMask : function(reportFrmId){
		$(reportFrmId).parent().prepend("<div id='report_mask'></div><div id='report_text'><img src='"+_BASE_+"assets/img/onLoad.gif' style='margin-top:-5px'/>&nbsp;<span>处理中,请稍后...</span></div>");
		$("#report_mask").css({"position":"absolute","border":"1px solid #F0F0F0","text-align":"center","background":"#F0F0F0",opacity: .4});
		$("#report_mask").height($(reportFrmId).height());
		$("#report_mask").width($(reportFrmId).width());
		$("#report_text").css({"position":"absolute","border":"1px solid #F0F0F0","text-align":"center","background":"#FFF","margin":"1px","padding":"10px"});
	},
	closeMask : function(){
		$("#report_text").remove();
		$("#report_mask").remove();
	}
};