package com.eyas.models;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "school_relationship", pkName = "re_id")
public class SchoolRelationship extends Model<SchoolRelationship> {

	private static final long serialVersionUID = 1L;
	
}
