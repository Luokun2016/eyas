package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "training_plan_detail_table")
public class TrainingPlanDetail extends Model<TrainingPlanDetail> {

	private static final long serialVersionUID = 1L;
	public TrainingPlanDetail getTrainingPlanDetail(String plan_id, String user_id){
		return  findFirst(
				"select * from training_plan_detail_table where plan_id=? and user_id=?",plan_id,user_id );
		
	}

}
