package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "grade", pkName = "grade_id")
public class Grade extends Model<Grade> {

	private static final long serialVersionUID = 1L;
	
	public Grade getGradeByGid(String gid){
		StringBuffer sql = new StringBuffer();
		sql.append("select * from grade where grade_id=?");
		return findFirst(sql.toString(), gid);
	}

}
