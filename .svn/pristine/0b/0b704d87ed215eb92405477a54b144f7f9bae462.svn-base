package com.eyas.controllers;

import java.util.ArrayList;
import java.util.List;
import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Role;
import com.eyas.models.RolePermission;
import com.eyas.models.Schools;
import com.eyas.models.UserRole;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class PermissionController extends BaseController {

	@Override
	protected void setPath() {
		setPath("/views/system/");
	}

	public void index() {
		String schoolId = getSessionAttr(CONST.SESSION_SCHOOL_ID);
		Schools school=new Schools();
		int schoolType=school.getSchoolTypeBySchId(schoolId);
		//查询相关具体角色信息
		StringBuffer sql = new StringBuffer();
		if(schoolType==2){
			sql.append("from role r");
		}else{
			sql.append("from role r where role_type="+schoolType);
		}
		pages("select r.* ", sql.toString());
		render(view("role_manage.jsp"));
	}

	/**
	 * 角色用户管理
	 */
	public void getUserPermission() {
		String roleId = getPara("role_id");
		String schId=getSessionAttr(CONST.SESSION_SCHOOL_ID);
		Schools s=new Schools();
		int schoolType=s.getSchoolTypeBySchId(schId);
		// 查找角色信息
		Role r = getModel(Role.class).findById(roleId);
		setAttr("role", r);
		if(schoolType==2)
		{
			List<Schools> sList=s.getAllSchool();
			setAttr("slist",sList);
		}else{
			Schools sch=s.getSchoolBySid(schId);
			setAttr("slist",sch);
		}
		//获取当前需要查询的学校信息
		if(getPara("schoolId")==null||getPara("schoolId").trim().length()==0||"-1".equals(getPara("schoolId"))){
			if(schoolType==2){
				List<Schools> sList=s.getAllSchool();
				StringBuffer allIds=new StringBuffer();
				allIds.append("-1");
				for(int i=0;i<sList.size();i++){
					allIds.append(",").append(sList.get(i).get("school_id"));
				}
				schId=allIds.toString();
			}
		}
		else
			schId=getPara("schoolId");
		// 取得当前角色下的现有启用用户
		StringBuffer sql = new StringBuffer();
		sql.append("select u.user_id,u.user_name,u.name,s.school_name,u.user_type");
		sql.append(" from users u left join schools s on");
		sql.append(" u.school_id=s.school_id");
		sql.append(" where s.school_id in ("+schId+")");
		sql.append(" and u.user_status=0 and u.check_status=1 and s.school_status=0 and u.user_id in(select user_id from user_role where role_id='"+roleId+"')");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("userName", params, this)) {
			sql.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("searchName", params, this)) {
			sql.append(" and u.name like ?");
		}
		if (!ParaUtils.addParam("userType", params, this)) {
			sql.append(" and u.user_type = ?");
		}
		sql.append(" order by s.school_id,u.user_name");
		List<Record> rlist = Db.find(sql.toString(),params.toArray());
		setAttr("curList", rlist);
		
		//将相应的用户id提取出来，便于后面排除，提升数据查询效率
		StringBuffer ids=new StringBuffer();
		ids.append("-1");
		for(int i=0;i<rlist.size();i++){
			ids.append(",").append(rlist.get(i).get("user_id"));
		}
		
		// 取得当前角色未加入角色的启用用户
		List<String> params1 = new ArrayList<String>();
		sql.setLength(0);
		sql.append("select u.user_id,u.user_name,u.name,s.school_name,u.user_type");
		sql.append(" from users u left join schools s on");
		sql.append(" u.school_id=s.school_id ");
		sql.append(" where s.school_status=0 ");
		sql.append(" and s.school_id in ("+schId+")and u.user_id not in(");
		sql.append(ids).append(")");
		if (!ParaUtils.addLikeParam("userName", params1, this)) {
			sql.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("searchName", params1, this)) {
			sql.append(" and u.name like ?");
		}
		if (!ParaUtils.addParam("userType", params1, this)) {
			sql.append(" and u.user_type = ?");
		}
		sql.append(" and u.user_status=0 and u.check_status=1 order by s.school_id,u.user_name");
		setAttr("nUser", Db.find(sql.toString(),params1.toArray()));
		render(view("user-permission.jsp"));
	}

	/**
	 * 向角色中添加或者移除用户
	 */
	public void txAddUser() {
		String flag = getPara("flag");
		String[] uid = getPara("user_id").split(",");
		String rid = getPara("role_id");
		if (flag != null && "add".equals(flag)) {
			for (int i = 0; i < uid.length; i++) {
				UserRole ur = new UserRole();
				ur.set("user_id", uid[i]);
				ur.set("role_id", rid);
				ur.save();
			}
			ParaUtils.addMsg(this, getText("common_op_success"));
		} else if (flag != null && "remove".equals(flag)) {
			StringBuffer sql = new StringBuffer();
			for (int i = 0; i < uid.length; i++) {
				sql.append("'").append(uid[i]).append("'");
				if ((i + 1) < uid.length) {
					sql.append(",");
				}
			}
			List<String> sqlList = new ArrayList<String>();
			sqlList.add("delete from user_role where user_id in ("
					+ sql.toString() + ") and role_id=\"" + rid + "\"");
			Db.batch(sqlList, sqlList.size());
			ParaUtils.addMsg(this, getText("common_op_success"));
		}
		getUserPermission();
	}

	/*
	 * 权限管理
	 */
	public void getPermission() {
		//查询角色
		String roleId = getPara("role_id");
		Role role=getModel(Role.class).findById(roleId);
		setAttr("role",role);
		render(view("set-permission.jsp"));
	}

	public void getPermiss() {
		//查询所有的权限信息
		List<Record> permissions=Db.find("select * from permission");
		String roleId = getPara("role_id");
		List<Record> curpermissions=Db.find("select * from permission where permiss_id in(select permiss_id from role_permission where role_id=?)",roleId);
		setAttr("allpermiss",permissions);
		setAttr("curpermiss",curpermissions);
		renderJson();
	}

	public void txadd() {
		//修改角色的权限
		String roleId = getPara("role_id");
		String permissArray=getAttr("permiss_array");
		String[] permiss=permissArray.split(",");
		Db.update("delete from role_permission where role_id=?",roleId);
		if(permissArray!=null&&!permissArray.equals("")){
			for(int i=0;i<permiss.length;i++){
				Db.update("insert into role_permission value(?,?)",roleId,permiss[i]);
			}
		}
		ParaUtils.addMsg(this, "保存成功");
		getPermission();
	}

}