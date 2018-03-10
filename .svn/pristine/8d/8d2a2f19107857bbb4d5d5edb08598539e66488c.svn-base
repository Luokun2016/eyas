package com.eyas.controllers;

import java.util.ArrayList;
import java.util.List;
import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Users;
import com.eyas.utils.MD5Util;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class UserController extends BaseController  {

	@Override
	protected void setPath(){
		setPath("/views/user/");
	}

	/**
	 * 初始页面
	 */
	public void index(){
		String school_id=getSessionAttr(CONST.SESSION_SCHOOL_ID);
		Long bigRole=getSessionAttr(CONST.SESSION_BIGROLE);
		setAttr("bigRole", bigRole);
		StringBuffer from = new StringBuffer();
		from.append("from users u  LEFT JOIN schools sc on sc.school_id = u.school_id where 1=1 ");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("userName", params, this)) {
			from.append(" and u.user_name like ? ");
		}
		if (!ParaUtils.addLikeParam("searchName", params, this)) {
			from.append(" and u.name like ? ");
		}
		if (!ParaUtils.addParam("school_type", params, this)) {
			from.append(" and sc.school_type = ?");
		}
		if (!ParaUtils.addParam("searchSchool_id", params, this)) {
			from.append(" and sc.school_id = ?");
		}
		if (!ParaUtils.addParam("user_status", params, this)) {
			from.append(" and u.user_status = ?");
		}
		if (!ParaUtils.addParam("check_status", params, this)) {
			from.append(" and u.check_status = ?");
		}
		if(bigRole !=6 ){
			from.append(" and u.school_id = ? ");
			params.add(school_id);
		}
		from.append(" order by u.name desc,u.user_name desc ");
		List<Record> list=pages("select u.user_id,u.name,u.user_name,school_name,u.school_id,u.user_type,u.user_status,u.check_status ", from.toString(), params.toArray());

		String school_type = getAttr("school_type");
		if (bigRole == 6) {
			if(school_type==null||school_type.equals("")||school_type.equals("-1")){
				List<Record> schoolList = Db.find("select school_name,school_id from schools");
				setAttr("schoolList", schoolList);
			}else{
				List<Record> schoolList = Db.find("select school_name,school_id from schools where school_type = ?",
						school_type);
				setAttr("schoolList", schoolList);
			}
		} else {
			List<Record> schoolList = Db.find("select school_name,school_id from schools where school_id = ?",
					school_id);
			setAttr("schoolList", schoolList);
		}

		if(bigRole ==2){
			List<Record> userTypeList = Db.find(" select role_id,role_name from role where role_type = 1 ");
			setAttr("userTypeList", userTypeList);
		}else if(bigRole == 4){
			List<Record> userTypeList = Db.find(" select role_id,role_name from role where role_type = 0 ");
			setAttr("userTypeList", userTypeList);
		}else if(bigRole == 6){
			List<Record> userTypeList = Db.find(" select role_id,role_name from role");
			setAttr("userTypeList", userTypeList);
		}
		render(view("user_management.jsp"));
	}


	/**
	 * 查找动态加载学校
	 */
	public void getSchool() {
		String school_id = getSessionAttr(CONST.SESSION_SCHOOL_ID);
		Long bigRole = getSessionAttr(CONST.SESSION_BIGROLE);
		String school_type = getAttr("school_type");
		if (bigRole == 6) {
			if(school_type==null||school_type.equals("")||school_type.equals("-1")){
				List<Record> schoolList = Db.find("select school_name,school_id from schools");
				setAttr("schoolList", schoolList);
			}else{
				List<Record> schoolList = Db.find("select school_name,school_id from schools where school_type = ?",
						school_type);
				setAttr("schoolList", schoolList);
			}
		} else {
			List<Record> schoolList = Db.find("select school_name,school_id from schools where school_id = ?",
					school_id);
			setAttr("schoolList", schoolList);
		}
		renderJson();
	}

	/**
	 * 添加新用户初始化页面
	 */
	public void addInitialize() {
		//获取用户权限
		Long role=getSessionAttr(CONST.SESSION_BIGROLE);
		//管理员关联学校
		String school_id=getSessionAttr(CONST.SESSION_SCHOOL_ID);
		//添加的用户类别
		String userAddType = getAttr("userAddType");

		StringBuffer from = new StringBuffer();
		from.append("select sc.school_name, sc.school_id from schools sc  where 1=1 ");
		List<String> params = new ArrayList<String>();
		if(role!=6){
			params.add(school_id);
			from.append(" and sc.school_id = ? ");
		}else if(userAddType.equals("0") || userAddType.equals("1")||userAddType.equals("2")){
			from.append(" and sc.school_type = 1 ");
		}else if(userAddType.equals("3") || userAddType.equals("4")){
			from.append(" and sc.school_type = 0 ");
		}else if(userAddType.equals("6") ){
			from.append(" and sc.school_type = 2 ");
		}
		List<Record> list=Db.find(from.toString(), params.toArray());
		setAttr("schoolList", list);
		setAttr("userAddType", userAddType);
		if(userAddType.equals("0"))
			render(view("add_junior_student.jsp"));
		else if(userAddType.equals("1"))
			render(view("add_junior_teacher.jsp"));
		else if(userAddType.equals("2"))
			render(view("add_admin.jsp"));
		else if(userAddType.equals("3"))
			render(view("add_college_teacher.jsp"));
		else if(userAddType.equals("4"))
			render(view("add_admin.jsp"));
		else if(userAddType.equals("6"))
			render(view("add_admin.jsp"));
	}

	/**
	 * 添加新用户到数据库
	 */
	public void txAdd() {
		String passWord = getPara("password");
		String userName=getPara("user_name");
		Record r=Db.findFirst("select * from users where user_name=?",userName);
		if(r==null){
			Users u=new Users();
			//审核状态为通过
			u.set("check_status", 1);
			u.set("user_status", 0);
			u.set("pass_word", MD5Util.convertMD5(passWord));
			save(u);
			ParaUtils.addMsg(this, "添加成功");	
		}else{
			ParaUtils.addMsg(this, "添加失败，用户名重复");	
		}
		index();
	}


	/**
	 * 修改用户--显示
	 */
	public void userEdit(){
		String user_id = getAttr("user_id");
		String school_id = getAttr("school_id");
		Long bigRole = getSessionAttr(CONST.SESSION_BIGROLE);
		Users userInfo = getModel(Users.class).getUserByUserId(user_id);
		int userType=userInfo.getInt("user_type");
		if(bigRole == 6){
			List<Record> schoolInfo = Db.find("select schools.school_name,schools.school_id from schools");
			setAttr("schoolInfo", schoolInfo);
		}else{
			List<Record> schoolInfo = Db.find("select schools.school_name,schools.school_id from schools left join users on users.school_id=schools.school_id where users.user_id = ?", user_id);
			setAttr("schoolInfo", schoolInfo);
		}
		setAttr("school_id", school_id);
		List<Record> gradeList = Db.find("select grade_id,grade_name from grade where school_id=?",userInfo.get("school_id"));
		List<Record> classList = Db.find("select class_id,class_name from class where grade_id=?",userInfo.get("grade_id"));
		setAttr("userInfo", userInfo);
		setAttr("user_role", bigRole);
		setAttr("gradeList", gradeList);
		setAttr("classList", classList);
		if(userType==0)
			render(view("edit_junior_student.jsp"));
		else if(userType==1)
			render(view("edit_junior_teacher.jsp"));
		else if(userType==2)
			render(view("edit_admin.jsp"));
		else if(userType==3)
			render(view("edit_college_teacher.jsp"));
		else
			render(view("edit_admin.jsp"));
	}

	/**
	 * 修改用户
	 */
	public void txUpdateUser(){
		Db.update("update users set name=?,sex=?,age=?,grade_id=?,class_id=?,"
				+ "degree=?,academic_pos=?,position=?,certification=?,mobile=?,"
				+ "qq=?,wechat=?,major=?,teach_course=?,research_field=?,introduction=?,"
				+ "school_id=?,depart=?,email=? where user_name=?",getAttr("name"),getAttr("sex"),getAttr("age"),getAttr("grade_id"),
				getAttr("class_id"),getAttr("degree"),getAttr("academic_pos"),getAttr("position"),getAttr("certification"),getAttr("mobile"),
				getAttr("qq"),getAttr("wechat"),getAttr("major"),getAttr("teach_course"),getAttr("research_field"),getAttr("introduction"),
				getAttr("school_id"),getAttr("depart"),getAttr("email"),getAttr("user_name"));
		ParaUtils.addMsg(this, "修改成功");
		index();
	}

	/**
	 * 用户信息--显示
	 */
	public void userView(){
		String user_id = getAttr("user_id");
		Users user = getModel(Users.class).getUserByUserId(user_id);
		int userType=user.getInt("user_type");
		Record userInfo = Db.findFirst("select *,u.remark as uremark from users u left join schools sch on u.school_id=sch.school_id left join grade g on u.grade_id=g.grade_id"
				+ " left join class c on u.class_id=c.class_id where u.user_id = ?", user_id);
		setAttr("userInfo", userInfo);
		if(userType==0)
			render(view("view_junior_student.jsp"));
		else if(userType==1)
			render(view("view_junior_teacher.jsp"));
		else if(userType==2)
			render(view("view_admin.jsp"));
		else if(userType==3)
			render(view("view_college_teacher.jsp"));
		else
			render(view("view_admin.jsp"));
	}

	/**
	 * 用户禁用
	 */
	public void userForbidden(){
		String user_id = getAttr("user_id");
		int s =Db.update("update users set users.user_status =1 where users.user_id= ?" ,user_id);
		if(s != -1){
			ParaUtils.addMsg(this, "用户禁用成功");
		}else{
			ParaUtils.addMsg(this, "用户禁用失败");
		}
		index();
	}

	/**
	 * 用户启用
	 */
	public void userUnForbidden(){
		String user_id = getAttr("user_id");
		int s =Db.update("update users set users.user_status =0 where users.user_id= ?" ,user_id);
		if(s != -1){
			ParaUtils.addMsg(this, "用户启用成功");
		}else{
			ParaUtils.addMsg(this, "用户启用失败");
		}
		index();
	}

	/**
	 * 用户删除
	 */
	public void userDelete(){
		String user_id = getAttr("user_id");
		try {
			Db.update("delete from users where user_id=?", user_id);
			ParaUtils.addMsg(this, "删除成功");
		} catch (Exception e) {
			//存在级联，删除失败
			int s =Db.update("update users set users.user_status =2 where users.user_id= ?" ,user_id);
			if(s != -1){
				ParaUtils.addMsg(this, "删除成功");
			}else{
				ParaUtils.addMsg(this, "删除失败");
			}
		} 
		index();
	}



	/**
	 * 用户审核--显示
	 */
	public void userCheck(){
		String user_id = getAttr("user_id");
		Users user = getModel(Users.class).getUserByUserId(user_id);
		int userType=user.getInt("user_type");
		Record userInfo = Db.findFirst("select *,u.remark as uremark from users u left join schools sch on u.school_id=sch.school_id left join grade g on u.grade_id=g.grade_id"
				+ " left join class c on u.class_id=c.class_id where u.user_id = ?", user_id);
		setAttr("userInfo", userInfo);
		if(userType==0)
			render(view("check_junior_student.jsp"));
		else if(userType==1)
			render(view("check_junior_teacher.jsp"));
		else if(userType==2)
			render(view("check_admin.jsp"));
		else if(userType==3)
			render(view("check_college_teacher.jsp"));
		else
			render(view("check_admin.jsp"));
	}

	/**
	 * 用户审核--提交
	 */
	public void userCheckSubmit(){
		String user_name = getAttr("user_name");
		int check_status = Integer.parseInt(getAttr("checkStatus").toString());
		int s=-1;
		if(check_status==1){
			s =Db.update("update users set check_status = ?,user_status=0,remark=? where user_name= ? " ,check_status,getAttr("remark"),user_name);
		}else
			s =Db.update("update users set check_status = ?,user_status=1,remark=? where user_name= ? " ,check_status,getAttr("remark"),user_name);
		if(s != -1){
			ParaUtils.addMsg(this, "审核提交成功");
		}else{
			ParaUtils.addMsg(this, "审核提交失败");
		}
		index();
	}
	
	/**
	 * 修改检测身份证号是否重复
	 */
	public void editCheckCertificate(){
		String userName = getAttr("userName");
		String certificate = getAttr("certificate");
		Record user = Db.findFirst("select certification from users where certification=? and user_name != ?",certificate, userName);
		String flag ="false";
		if(user == null){
			flag = "true";
		}
		setAttr("flag", flag);
		renderJson();
	}
	
	/**
	 * 修改检测电话号码是否重复
	 */
	public void editCheckPhone(){
		String userName = getAttr("userName");
		String mobile = getAttr("mobile");
		Record user = Db.findFirst("select mobile from users where mobile=? and user_name != ?",mobile, userName);
		String flag ="false";
		if(user == null){
			flag = "true";
		}
		setAttr("flag", flag);
		renderJson();
	}
	
	/**
	 * 修改检测邮箱是否重复
	 */
	public void editCheckEmail(){
		String userName = getAttr("userName");
		String email = getAttr("email");
		Record user = Db.findFirst("select email from users where email=? and user_name != ?",email, userName);
		String flag ="false";
		if(user == null){
			flag = "true";
		}
		setAttr("flag", flag);
		renderJson();
	}



}
