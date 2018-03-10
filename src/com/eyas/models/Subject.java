package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "subject_category", pkName = "subject_cat_id")
public class Subject extends Model<Subject> {

	private static final long serialVersionUID = 1L;

	public boolean getSubjectByName(String subjectName) {
		String sql = "select * from subject_category where subject_name = ?";		
		Subject r=findFirst(sql.toString(), subjectName);
		if(r==null)
			return true;
		else 
			return false;
	}
	
	public boolean checkSubjectByName(String subjectName, String subjectId) {
		String sql = "select * from subject_category where subject_name = ? and subject_cat_id != ?";		
		Subject r=findFirst(sql.toString(), subjectName, subjectId);
		if(r==null)
			return true;
		else 
			return false;
	}
}
