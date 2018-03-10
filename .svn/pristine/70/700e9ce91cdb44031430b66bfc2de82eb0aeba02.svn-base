package com.eyas.controllers;

import java.util.ArrayList;
import java.util.List;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Classes;
import com.eyas.models.Grade;
import com.eyas.models.Schools;
import com.eyas.models.Users;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class ClassController extends BaseController {

	@Override
	protected void setPath() {
		// TODO Auto-generated method stub
		setPath("/views/school/");
	}
	
	/**
	 * 班级管理--主界面
	 */
	public void classManage(){		
			String gradeId = getAttr("gradeId");
			StringBuffer from = new StringBuffer();
			List<String> params = new ArrayList<String>();
			from.append(" from class WHERE class.grade_id = '"+gradeId+"'");
			if (!ParaUtils.addLikeParam("class_name", params, this)) {
				from.append(" and class.class_name like ?");
			}
			List<Record> list = pages("select class.class_id, class.grade_id, class.class_name, class.remark",
					from.toString(), params.toArray());	
			Record grade = Db.findFirst(" select grade_id, grade_name from grade where grade_id = '"+gradeId+"'");
			setAttr("grade", grade);
			
			render(view("class_management.jsp"));	
		
	}
	
	/**
	 * 添加班级--显示界面
	 */
	public void addClassView(){
		String gradeId = getAttr("gradeId");
		Record data = Db.findFirst("select grade_name from grade where grade_id=?",gradeId);
		String gradeName = data.getStr("grade_name");

		setAttr("gradeId", gradeId);
		setAttr("gradeName", gradeName);
		render(view("add_class.jsp"));
	}
	
	/**
	 * 添加班级--操作
	 */
	public void txAddClass(){
		String gradeId = getAttr("gradeId");
		String className = getAttr("className");
		Classes class1 = new Classes();
		class1.set("class_name", className);
		class1.set("grade_id", gradeId);
		if(!save(class1).equals(-1)){
			ParaUtils.addMsg(this, "添加成功");
		}else{
			ParaUtils.addMsg(this, "添加失败");
		}
		classManage();
	}
	
	/**
	 * 修改班级--显示
	 */
	public void editClassView(){
		String classId = getAttr("classId");
		Classes class1 = new Classes();
		Classes list = class1.getClassByCid(classId);
		setAttr("class", list);
		render(view("edit_class.jsp"));
	}
	
	/**
	 * 修改班级--处理
	 */
	public void txEditClass(){
		String classId = getAttr("classId");
		String className = getAttr("className");
		String remark = getAttr("remark");
		int s = Db.update(" update class set class_name = ?, remark = ? where class_id = ?", className, remark, classId);
		if(s != -1){
			ParaUtils.addMsg(this, className+"修改成功");
		}else{
			ParaUtils.addMsg(this, className+"修改失败");
		}
		classManage();
	}
	
	/**
	 * 查看班级--显示
	 */
	public void showClassView(){
		String gradeId = getAttr("gradeId");
		String classId = getAttr("classId");
		Classes class1 = new Classes();
		Classes list = class1.getClassByCid(classId);
		setAttr("class", list);
		setAttr("gradeId", gradeId);
		render(view("show_class.jsp"));
	}
	
	/**
	 * 删除班级--操作
	 */
	public void txDeleteClass(){
		String classId = getAttr("classId");		
		Record s1 = Db.findFirst("select * from users where class_id = ?", classId);		
		if((s1 == null || s1.equals(""))){
			boolean s = Db.deleteById("class", "class_id", classId);
			if(s){
				ParaUtils.addMsg(this, "删除成功");
			}else{
				ParaUtils.addMsg(this, "删除失败");
			}
		}else{
			ParaUtils.addMsg(this, "不能删除正在使用的班级");
		}
		
		classManage();
	}
}
