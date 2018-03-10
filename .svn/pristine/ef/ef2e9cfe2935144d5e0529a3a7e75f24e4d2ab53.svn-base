package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "learning_record_table", pkName = "l_record_id")
public class LearnRecord extends Model<LearnRecord> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public LearnRecord getLearnRecordById(String recordId){
		
		String sql ="select * from learning_record_table where l_record_id = ?";
		return findFirst(sql.toString(), recordId);
	}
	
}
