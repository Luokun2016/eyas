package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "learning_record_type_table", pkName = "l_record_type_id")
public class RecordType extends Model<RecordType> {

	private static final long serialVersionUID = 1L;

	public boolean getRecordTypeByName(String recordTypeName) {
		String sql = "select * from learning_record_type_table where l_record_type = ? ";		
		RecordType r=findFirst(sql.toString(), recordTypeName);
		if(r==null)
			return true;
		else 
			return false;
	}
	
	public boolean checkRecordTypeByName(String recordTypeName, String recordTypeId) {
		String sql = "select * from learning_record_type_table where l_record_type = ? and l_record_type_id != ?";		
		RecordType r=findFirst(sql.toString(), recordTypeName, recordTypeId);
		if(r==null)
			return true;
		else 
			return false;
	}
}
