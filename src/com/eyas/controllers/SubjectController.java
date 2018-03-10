package com.eyas.controllers;


import java.util.ArrayList;
import java.util.List;

import org.jfree.util.PublicCloneable;
import org.junit.experimental.theories.FromDataPoints;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Subject;
import com.eyas.models.Users;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sun.org.apache.bcel.internal.generic.Select;

/**
 * @author MVKK
 *
 */
public class SubjectController extends BaseController {	

	@Override
	protected void setPath() {
		// TODO Auto-generated method stub
		setPath("/views/subject/");
	}
	
	
	
	/**
	 * 学科管理--主界面
	 */
	public void subjectManage(){
		
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色
		 //0—中学生用户 1—中学教师 2—中学管理员 3—高校教师  4—高校管理员 5—创新学院用户 6—创新学院管理员
		StringBuffer from = new StringBuffer();
		List<String> params = new ArrayList<String>();
		from.append(" from subject_category subject where 1=1");
		if (!ParaUtils.addLikeParam("subjectName", params, this)) {
			from.append(" and subject.subject_name like ?");
		}
		if (!ParaUtils.addLikeParam("Descript", params, this)) {
			from.append(" and subject.descript like ?");
		}
		List<Record> list = pages(
				"select subject.subject_cat_id, subject.subject_name, subject.descript",
				from.toString(), params.toArray());
		render(view("subject_management.jsp"));
	}
	
	/**
	 * 添加学科--显示
	 */
	public void addSubjectView(){
		render(view("add_subject.jsp"));
	}
	
	/**
	 * 添加学科--处理
	 */
	public void txAddSubject(){
		String subjectName = getAttr("subject_name");
		String descript = getAttr("descript");
		Subject subject = new Subject();
		boolean isOk=subject.getSubjectByName(subjectName);
		if(isOk==true){
		subject.set("subject_name", subjectName);
		subject.set("descript", descript);
		if(!save(subject).equals(-1)){
			ParaUtils.addMsg(this, "添加成功");
		}else{
			ParaUtils.addMsg(this, "添加失败");
		}
		}else
			ParaUtils.addMsg(this, "添加失败,类别名称不能重复");		
		subjectManage();
	}
	
	/**
	 * 修改学科--显示
	 */
	public void editSubjectView(){
		String subjectId = getAttr("subjectId");
		Record subject=Db.findFirst("select * from subject_category where subject_cat_Id=?",subjectId);
		setAttr("subject", subject);
		render(view("edit_subject.jsp"));
	}
	
	/**
	 * 修改学科--提交
	 */
	public void txEditSubject(){
		String subjectId = getAttr("subject_cat_id");
		String subjectName = getAttr("subject_name");
		String Descript = getAttr("descript");
		Subject subject = new Subject();
		boolean isOk=subject.checkSubjectByName(subjectName,subjectId);
		if(isOk==true){
			Db.update("update subject_category set subject_name = ? ,descript = ? where subject_cat_id = ? ", 
					subjectName, Descript, subjectId );
			ParaUtils.addMsg(this, "修改成功");
		}else{
			ParaUtils.addMsg(this, "修改失败，类别名称不能重复");
		}
		subjectManage();			
	}
	
	/**
	 * 查看学科--显示
	 */
	public void showSubjectView(){
		String subjectId = getAttr("subjectId");
		Record subject=Db.findFirst("select * from subject_category where subject_cat_Id=?",subjectId);
		setAttr("subject", subject);
		render(view("show_subject.jsp"));
	}
	
	/**
	 * 删除学科--操作
	 */
	public void txDeleteSubject(){
		String subjectId = getAttr("subjectId");
        try {
			Db.update("delete from subject_category where subject_cat_id=?", subjectId);
			ParaUtils.addMsg(this, "删除成功");
		} catch (Exception e) {
			// TODO: handle exception
			ParaUtils.addMsg(this, "删除失败，存在关联");
		}
		subjectManage();
	}
}
