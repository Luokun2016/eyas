package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

@TableBind(tableName = "learning_report_table", pkName = "l_report_id")
public class LearnReport extends Model<LearnReport> {
	public Record getLearnReportByPaType(String projectId,int type)
	{
		Record r=Db.findFirst("select * from learning_report_table where project_id=? and l_report_type=?",projectId,type);
		return r;
	}

	//大学教师通过，大学管理员通过，创新学院人员通过返回false
	public boolean getWhetherPass(String reportId)
	{
		Record r=Db.findFirst("select * from learning_report_table where l_report_id=?",reportId);
		int states=r.getInt("l_report_status");
		if(states==2||states==4||states==6)
			return false;
		else
			return true;
	}

}
