package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

/**
 * @author MVKK
 *
 */
@TableBind(tableName = "training_plan_main_table", pkName = "plan_id")
public class TrainingPlanMain extends Model<TrainingPlanMain> {

	private static final long serialVersionUID = 1L;
	
	/**
	 * @param 项目ID project_id
	 * @return 项目的进度安排信息
	 */
	public TrainingPlanMain getTrainingPlanMain(String project_id){
		return  findFirst(
				"select * from training_plan_main_table where project_id='"+project_id+"'");
		
	}
}
