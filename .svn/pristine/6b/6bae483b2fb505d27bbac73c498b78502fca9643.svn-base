package com.eyas.models;

import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

@TableBind(tableName = "role", pkName = "role_id")
public class Role extends Model<Role> {

	private static final long serialVersionUID = 1L;

	/**
	 * 获取当前用户所在角色的权限
	 * 
	 * @return
	 */
	public String getPermissionByUid(String rid) {
		// 取得角色对应的权限
		StringBuffer sql = new StringBuffer();
		sql.append("select * from permission where permiss_id in (");
		sql.append("select permiss_id from role_permission where role_id=?)");
		List<Role> rlist = find(sql.toString(), rid);
		if (rlist == null || rlist.size() == 0) {
			return null;
		}
		sql.setLength(0);
		for (int i = 0; i < rlist.size(); i++) {
			sql.append(rlist.get(i).getStr("permiss_value"));
		}
		return sql.toString();
	}
}
