package com.eyas.models;

import java.util.List;
import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

@TableBind(tableName = "users", pkName = "user_id")
public class Users extends Model<Users> {
	// 序列化该类
	private static final long serialVersionUID = 1L;
	
	/**
	 * 根据用户名和密码获取登录用户
	 * @param uid id
	 * @param passWord 密码
	 * @return 如果存在将返回具体对象，如果不存在，将返回null
	 */
	public Users getUserById(String uid, String passWord) {
		return findFirst(
				"select * from users where user_id=?  and pass_word=?",
				uid, passWord);
	}
	
	//登录
	public Users getLoginByUser(String userName, String passWord) {
		return findFirst(
				"select * from users where user_name=? and pass_word=?",
				userName, passWord);
	}

	//根据用户名获取用户
	public Users getUserByUserName(String userName) {
		return findFirst(
				"select * from users where user_name=?",
				userName);
	}

	//根据用户Id获取用户
	public Users getUserByUserId(String userId) {
		return findFirst(
				"select * from users where user_id=?",
				userId);
	}

	public StringBuffer[] getPermissionsById(String userid) {
		//获取权限的对应值
		StringBuffer[] permiss=new StringBuffer[2];
		StringBuffer sql = new StringBuffer();
		StringBuffer url = new StringBuffer();
		sql.append("select * from permission where permiss_id in (");
		sql.append("select permiss_id from role_permission where role_id in (");
		sql.append("select role_id from user_role where user_id=?))");
		List<Record> rlist = Db.find(sql.toString(), userid);
		sql.setLength(0);
		if(rlist.size()==0){
			permiss[0]=sql;
			permiss[1]=url;
			return permiss;
		}else{
			for (int i = 0; i < rlist.size()-1; i++) {
				sql.append(rlist.get(i).getStr("permiss_value")).append("%");
				url.append(rlist.get(i).getStr("url")).append("%");
			}
			sql.append(rlist.get(rlist.size()-1).getStr("permiss_value"));
			url.append(rlist.get(rlist.size()-1).getStr("url"));
			permiss[0]=sql;
			permiss[1]=url;
			return permiss;
		}
	}

	//获取当前用户最大角色
	public Long getBigRole(String userid){
		Long r=Db.queryLong("select MAX(ur.role_id) from users u,user_role ur where u.user_id=? and u.user_id=ur.user_id", userid);
		return  r;
	}
}
