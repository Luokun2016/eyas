package com.eyas.models;

import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;
import com.sun.org.apache.bcel.internal.generic.Select;

@TableBind(tableName = "schools", pkName = "school_id")
public class Schools extends Model<Schools> {

	private static final long serialVersionUID = 1L;

	/**
	 * 根据学校ID返回学校的类别 0-高校，1-中学，2-创新学院
	 * 
	 * @return
	 */
	public int getSchoolTypeBySchId(String schid) {
		// 取得角色对应的权限
		StringBuffer sql = new StringBuffer();
		sql.append("select * from schools s where school_id=?");
		Schools school = findFirst(sql.toString(), schid);
		return school.getInt("school_type");
	}
	
	//获取所有学校
	public List<Schools> getAllSchool(){
		StringBuffer sql = new StringBuffer();
		sql.append("select * from schools");
		return find(sql.toString());
	}
	
	public Schools getSchoolBySid(String sid){
		StringBuffer sql = new StringBuffer();
		sql.append("select * from schools s where school_id=?");
		return findFirst(sql.toString(), sid);
	}
	
	public List<Schools> getSchoolBySchType(String schoolType){
		String sql = "select * from schools where school_type = ?";		
		return find(sql, schoolType);
		
	}
}
