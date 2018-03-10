package com.eyas.controllers;

import java.util.ArrayList;
import java.util.List;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Grade;
import com.eyas.models.Schools;
import com.eyas.models.Users;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class GradeController extends BaseController {

	@Override
	protected void setPath() {
		// TODO Auto-generated method stub
		setPath("/views/school/");
	}
	
	/**
	 * 年级管理--主界面
	 */
	public void gradeManage(){
		
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色
		 //0—中学生用户 1—中学教师 2—中学管理员 3—高校教师  4—高校管理员 5—创新学院用户 6—创新学院管理员
		if(role ==2 || role == 4){
			StringBuffer from = new StringBuffer();
			List<String> params = new ArrayList<String>();
			from.append(" from grade WHERE grade.school_id = (select school_id from users WHERE user_id = '"+userId+"')");
			if (!ParaUtils.addLikeParam("grade_name", params, this)) {
				from.append(" and grade.grade_name like ?");
			}
			List<Record> list = pages("select grade.grade_id, grade.school_id, grade.grade_name, grade.remark",
					from.toString(), params.toArray());
			
			Record school = Db.findFirst(" select school_id, school_name from schools where school_id = (select school_id from users WHERE user_id =? )", userId);
			setAttr("school", school);
			render(view("grade_management.jsp"));
	
		}
	}
	
	/**
	 * 添加年级--显示界面
	 */
	public void addGradeView(){
		String schoolId = getAttr("schoolId");
		Record data = Db.findFirst("select school_name from schools where school_id=?",schoolId);
		String schoolName = data.getStr("school_name");	
		
		setAttr("schoolId", schoolId);
		setAttr("schoolName", schoolName);
		render(view("add_grade.jsp"));
	}
	
	/**
	 * 添加年级--操作
	 */
	public void txAddGrade(){
		String schoolId = getAttr("schoolId");
		String gradeName = getAttr("gradeName");
		Grade grade = new Grade();
		grade.set("grade_name", gradeName);
		grade.set("school_id", schoolId);
		if(!save(grade).equals(-1)){
			ParaUtils.addMsg(this, "添加成功");
		}else{
			ParaUtils.addMsg(this, "添加失败");
		}
		gradeManage();
	}
	
	/**
	 * 修改年级--显示
	 */
	public void editGradeView(){
		String gradeId = getAttr("gradeId");
		Grade grade = new Grade();
		Grade list = grade.getGradeByGid(gradeId);
		setAttr("grade", list);
		render(view("edit_grade.jsp"));
	}
	
	/**
	 * 修改年级--处理
	 */
	public void txEditGrade(){
		String gradeId = getAttr("gradeId");
		String gradeName = getAttr("gradeName");
		String remark = getAttr("remark");
		int s = Db.update(" update grade set grade_name = ?, remark = ? where grade_id = ?", gradeName, remark, gradeId);
		if(s != -1){
			ParaUtils.addMsg(this, gradeName+"修改成功");
		}else{
			ParaUtils.addMsg(this, gradeName+"修改失败");
		}
		gradeManage();
	}
	
	/**
	 * 查看年级--显示
	 */
	public void showGradeView(){
		String gradeId = getAttr("gradeId");
		Grade grade = new Grade();
		Grade list = grade.getGradeByGid(gradeId);
		setAttr("grade", list);
		render(view("show_grade.jsp"));
	}
	
	/**
	 * 删除年级--操作
	 */
	public void txDeleteGrade(){
		String gradeId = getAttr("gradeId");		
		Record s1 = Db.findFirst("select * from users where grade_id = ?", gradeId);		
		if((s1 == null || s1.equals(""))){
			boolean s = Db.deleteById("grade", "grade_id", gradeId);
			if(s){
				ParaUtils.addMsg(this, "删除成功");
			}else{
				ParaUtils.addMsg(this, "删除失败");
			}
		}else{
			ParaUtils.addMsg(this, "不能删除正在使用的年级");
		}
		
		gradeManage();
	}
}
