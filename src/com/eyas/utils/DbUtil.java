package com.eyas.utils;
import java.util.List;

import com.jfinal.plugin.activerecord.Db;

public class DbUtil {
	/**
	 * 检查是否存在同名的数据
	 * 
	 * @param tbl
	 * @param filed
	 * @param value
	 * @return
	 */
	public static boolean checkSameName(String tbl, String field, String value) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from ").append(tbl);
		sql.append(" where ").append(field).append("=?");
		List<?> list = Db.find(sql.toString(), value);
		if (list == null || list.size() == 0)
			return false;
		return true;
	}

}
