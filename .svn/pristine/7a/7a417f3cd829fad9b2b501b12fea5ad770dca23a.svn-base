package com.eyas.models;

import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

/**
 * 
 * @author Administrator
 * 
 */
@TableBind(tableName = "user_role")
public class UserRole extends Model<UserRole> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 查找用户角色
	 * 
	 * @param userId
	 * @param roleId
	 * @return
	 */
	public UserRole searchUserRole(String userId, String roleId) {
		String sql = "select * from user_role where user_id=? and role_id=?";
		return findFirst(sql, userId, roleId);
	}

	/**
	 * 查找用户角色
	 * 
	 * @return
	 */
	public List<UserRole> searchRoleByUser(String uid) {
		String sql = "select * from user_role where user_id=?";
		return find(sql, uid);
	}

}
