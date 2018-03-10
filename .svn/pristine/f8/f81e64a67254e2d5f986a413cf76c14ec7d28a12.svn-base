package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "class", pkName = "class_id")
public class Classes extends Model<Classes> {

	private static final long serialVersionUID = 1L;
	
	public Classes getClassByCid(String cid){
		StringBuffer sql = new StringBuffer();
		sql.append("select * from class where class_id=?");
		return findFirst(sql.toString(), cid);
	}

}
