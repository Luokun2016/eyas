package com.eyas.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Batch;
import com.eyas.models.News;
import com.eyas.models.PRecommend;
import com.eyas.models.SRecommend;
import com.eyas.models.TRecommend;
import com.eyas.models.Users;
import com.eyas.utils.ID;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

public class RecommendController extends BaseController {

	@Override
	protected void setPath() {
		setPath("/views/recommend/");
	}

	public void projectManage() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users r=getModel(Users.class).getUserByUserId(userId);
		Long role=getModel(Users.class).getBigRole(userId);
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pr.batch_id from project_recommend_table pr left join project_apply pa on pr.project_id=pa.project_id where pa.school_id ='"+r.get("school_id")+"') or b.batch_status=1 order by b.batch_status desc,b.batch_id desc");
		List projectList=Db.find("select project_id,project_name from project_apply where project_id in (select pr.project_id from project_recommend_table pr left join project_apply pa on pr.project_id=pa.project_id where pa.school_id ='"+r.get("school_id")+"')");
		StringBuffer from = new StringBuffer();
		from.append(
				"from project_recommend_table pr left join batch b on pr.batch_id=b.batch_id left join project_apply p on pr.project_id=p.project_id where 1=1 ");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pr.batch_id = ? ");
		}
		if (!ParaUtils.addParam("projectId", params, this)) {
			from.append(" and lr.project_id = ?");
		}
		//默认加载当前状态的申报项目,如果当前没有批次，则加载所有申报的项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			Batch batch=getModel(Batch.class).getCurBatch();
			if(batch!=null){
				from.append(" and pr.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		if(role==4){
			from.append(" and p.school_id ='"+r.get("school_id")+"' order by pr.rec_date desc");
		}else{
			from.append(" order by pr.rec_date desc");
		}

		List<Record> list = pages(
				"select pr.batch_id, b.batch_name, pr.project_id, p.project_name, pr.status, pr.audit_date ",
				from.toString(), params.toArray());
		setAttr("batchList", batchList);
		setAttr("projectList", projectList);
		setAttr("role", role);
		render(view("projectManage.jsp"));
	}

	/**
	 * 查询出待选项目信息，跳转至添加页面
	 */
	public void addP() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users r=getModel(Users.class).getUserByUserId(userId);
		Batch batch=getModel(Batch.class).getCurBatch();
		StringBuffer from = new StringBuffer();
		from.append("select batch_id, project_id, project_name, user_id ");
		from.append("from project_apply where 1=1 and submit_status=9 and batch_id='"+batch.get("batch_id")+"' and school_id ='"+r.get("school_id")+"'");
		List<Record> list = Db.find(from.toString());
		setAttr("listP", list);
		setAttr("batchId",batch.get("batch_id"));
		render(view("addProRe.jsp"));
	}

	public void getTeachers() {
		String project_id = getAttr("project_id");
		// 项目表中的导师
		Record tutorRecord = Db.findFirst(
				"select u.user_id, u.name, u.mobile, u.teach_course from project_apply pa left join users u on pa.user_id=u.user_id where pa.project_id = ?",
				project_id);
		// 组队表中的中师 where t.team_status=4
		Record teacherRecord = Db.findFirst(
				"select u.user_id, u.name, u.mobile, u.teach_course from team_table tt left join users u on tt.user_id=u.user_id where tt.project_id = ?",
				project_id);
		List<Record> teacherlist = new ArrayList<Record>();
		teacherlist.add(tutorRecord);
		teacherlist.add(teacherRecord);
		setAttr("teacherList", teacherlist);
		renderJson();
	}

	/**
	 * 新增操作，tx事务
	 */
	public void txAddProject() {
		Record r=Db.findFirst("select * from project_recommend_table where project_id=?",getPara("project_id"));
		if(r==null){
			PRecommend p = new PRecommend();
			p.set("batch_id", getPara("batch_id"));
			p.set("project_id", getPara("project_id"));
			p.set("assign", getPara("assign"));
			p.set("achievement", getPara("achievement"));
			p.set("description", getPara("description"));
			p.set("rec_date", new Date());
			p.set("status", 0);
			p.save();
			msgOperateSuccess();
		}else{
			ParaUtils.addMsg(this, "项目推优失败");
		}
		projectManage();

	}

	public void editP() {
		String project_id = getPara("project_id");
		Record r=Db.findFirst("select * from project_recommend_table where project_id=?",getPara("project_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			projectManage();
		}else{
			setAttr("project",
					Db.findFirst(
							"select pr.batch_id, pr.project_id, pa.project_name, pr.assign, pr.achievement, pr.description, pr.rec_date, pr.status from project_recommend_table pr left join project_apply pa on pr.project_id=pa.project_id where pr.project_id = ?",
							project_id));
			render(view("editProRe.jsp"));
		}
	}

	public void txEditProject() {
		Record r=Db.findFirst("select * from project_recommend_table where project_id=?",getPara("project_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			projectManage();
		}else{
			Db.update(
					"update project_recommend_table set assign=?, achievement=?, description=?, rec_date=?,status=0 where project_id=? and batch_id=?",
					getPara("assign"), getPara("achievement"), getPara("description"), new Date(), getPara("project_id"),
					getPara("batch_id"));
			msgOperateSuccess();
			projectManage();
		}

	}

	public void txDelProject() {
		Record r=Db.findFirst("select * from project_recommend_table where project_id=?",getPara("project_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能删除修改！");
			projectManage();
		}else{
			try {
				Db.update("delete from project_recommend_table where project_id=? and batch_id=? ", getPara("project_id"),
						getPara("batch_id"));
				ParaUtils.addMsg(this, "删除成功");
			} catch (Exception e) {
				ParaUtils.addMsg(this, "删除操作失败！");
			}
			projectManage();
		}
	}

	public void viewP() {
		String project_id = getPara("project_id");
		setAttr("project",
				Db.findFirst(
						"select pr.batch_id, pr.project_id, pa.project_name, pr.assign, pr.achievement, pr.description, pr.rec_date, pr.status,pr.audit_date,pr.remark from project_recommend_table pr left join project_apply pa on pr.project_id=pa.project_id where pr.project_id = ?",
						project_id));
		render(view("viewProRe.jsp"));
	}

	// --------------------------------
	/**
	 * 学生管理界面
	 */
	public void studentManage() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users r=getModel(Users.class).getUserByUserId(userId);
		Long role=getModel(Users.class).getBigRole(userId);
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select sr.batch_id from students_recommend_table sr left join project_apply pa on sr.project_id=pa.project_id where pa.school_id ='"+r.get("school_id")+"') or b.batch_status=1 order by b.batch_status desc,b.batch_id desc");
		StringBuffer from = new StringBuffer();
		from.append("from students_recommend_table sr ");
		from.append("left join batch b on sr.batch_id=b.batch_id  ");
		from.append("left join project_apply pa on sr.project_id=pa.project_id ");
		from.append(
				"left join (select u.user_id,u.name,s.school_name,g.grade_name,c.class_name from users u left join schools s on u.school_id=s.school_id "
						+ "left join grade g on u.grade_id=g.grade_id left join class c on u.class_id=c.class_id) us on sr.student_id=us.user_id where 1=1 ");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and sr.batch_id = ? ");
		}
		if (!ParaUtils.addLikeParam("keyWord", params, this)) {
			from.append(" and us.name like ? ");
		}
		//默认加载当前状态的申报项目,如果当前没有批次，则加载所有申报的项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			Batch batch=getModel(Batch.class).getCurBatch();
			if(batch!=null){
				from.append(" and sr.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		if(role==4){
			from.append(" and pa.school_id ='"+r.get("school_id")+"' order by sr.rec_date desc");
		}else{
			from.append(" order by sr.rec_date desc");
		}
		List<Record> list = pages(
				"select sr.batch_id,b.batch_name,sr.project_id,pa.project_name,sr.student_id,us.name,us.school_name,us.grade_name,us.class_name,sr.status ",
				from.toString(), params.toArray());
		setAttr("batchList", batchList);
		setAttr("role", role);
		render(view("studentManage.jsp"));
	}

	public void addS() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users r=getModel(Users.class).getUserByUserId(userId);
		Batch batch=getModel(Batch.class).getCurBatch();
		StringBuffer from = new StringBuffer();
		from.append("select batch_id, project_id, project_name, user_id ");
		from.append("from project_apply where 1=1 and submit_status=9 and batch_id='"+batch.get("batch_id")+"' and school_id ='"+r.get("school_id")+"'");
		List<Record> list = Db.find(from.toString());
		setAttr("listP", list);
		setAttr("batchId",batch.get("batch_id"));
		render(view("addStuRe.jsp"));
	}

	public void getStuTeachers() {
		String project_id = getAttr("project_id");
		// 项目表中的导师
		Record tutorRecord = Db.findFirst(
				"select u.user_id, u.name, u.mobile, u.teach_course from project_apply pa left join users u on pa.user_id=u.user_id where pa.project_id = ?",
				project_id);
		// 组队表中的中师 where t.team_status=4
		Record teacherRecord = Db.findFirst(
				"select u.user_id, u.name, u.mobile, u.teach_course from team_table tt left join users u on tt.user_id=u.user_id where tt.project_id = ?",
				project_id);
		List<Record> teacherlist = new ArrayList<Record>();
		teacherlist.add(tutorRecord);
		teacherlist.add(teacherRecord);
		setAttr("teacherList", teacherlist);
		renderJson();
	}

	/**
	 * 
	 * 返回一个listS学生列表供第二个下拉框选择
	 */
	public void getListS() {
		List<Record> listStudents = Db.find(
				"select t.user_id, u.name, t.batch_id from (select td.user_id, tt.batch_id from team_table tt left join team_detail_table td on tt.team_id=td.team_id where project_id = ? and tt.team_status=4 ) t left join users u on t.user_id=u.user_id ",
				getAttr("project_id"));
		setAttr("listStudents", listStudents);
		renderJson();
	}

	/**
	 * 
	 * 选择学生后根据user_id，ajax添加信息
	 */
	public void getStudents() {
		StringBuffer from = new StringBuffer();
		from.append(
				"select u.name, s.school_name, g.grade_name, c.class_name from users u left join schools s on u.school_id=s.school_id ");
		from.append("left join grade g on u.grade_id=g.grade_id left join class c on u.class_id=c.class_id where u.user_id="+getAttr("student_id"));
		Record stuMessage = Db.findFirst(from.toString());
		setAttr("stuMessage", stuMessage);
		renderJson();
	}

	public void txAddStudent() {
		Record r=Db.findFirst("select * from students_recommend_table where batch_id=? and student_id=?",getPara("batch_id"),getPara("student_id"));
		if(r!=null){
			ParaUtils.addMsg(this, "该学生已被推优，不能重复推优！");
			studentManage();
		}else{
			SRecommend s = new SRecommend();
			s.set("batch_id", getPara("batch_id"));
			s.set("project_id", getPara("project_id"));
			s.set("student_id", getPara("student_id"));
			s.set("achievement", getPara("achievement"));
			s.set("description", getPara("description"));
			s.set("rec_date", new Date());
			s.set("status", 0);
			s.save();
			msgOperateSuccess();
			studentManage();
		}
	}

	/**
	 * 跳转方法
	 */
	public void editS() {
		Record r=Db.findFirst("select * from students_recommend_table where batch_id=? and student_id=?",getPara("batch_id"),getPara("student_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			studentManage();
		}else{
			setAttr("studentM",
					Db.findFirst(
							"select sr.batch_id, sr.student_id, u.name, sr.achievement, sr.description from students_recommend_table sr left join users u on sr.student_id=u.user_id where student_id = ? and batch_id= ? ",
							getAttr("student_id"), getAttr("batch_id")));
			setAttr("projectM", Db.findFirst("select project_id, project_name from project_apply where project_id = ? ",
					getAttr("project_id")));
			render(view("editStuRe.jsp"));
		}
	}

	public void txEditStudent() {

		int i = Db.update(
				"update students_recommend_table set achievement=?, description=?, rec_date=?,status=0 where student_id=? and batch_id = ?",
				getPara("achievement"), getPara("description"), new Date(), getPara("student_id"), getPara("batch_id"));
		msgOperateSuccess();
		studentManage();

	}

	public void txDelStudent() {
		Record r=Db.findFirst("select * from students_recommend_table where batch_id=? and student_id=?",getPara("batch_id"),getPara("student_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			studentManage();
		}else{
			try {
				Db.update("delete from students_recommend_table where student_id=? and batch_id = ? ",
						getPara("student_id"), getPara("batch_id"));
				ParaUtils.addMsg(this, "删除成功");
			} catch (Exception e) {
				ParaUtils.addMsg(this, "删除操作失败！");
			}
			studentManage();
		}
	}
	
	public void viewS() {
			setAttr("studentM",
					Db.findFirst(
							"select sr.batch_id, sr.student_id, u.name, sr.achievement, sr.description,sr.status,sr.audit_date,sr.remark  from students_recommend_table sr left join users u on sr.student_id=u.user_id where student_id = ? and batch_id= ? ",
							getAttr("student_id"), getAttr("batch_id")));
			setAttr("projectM", Db.findFirst("select project_id, project_name from project_apply where project_id = ? ",
					getAttr("project_id")));
			render(view("viewStuRe.jsp"));
	}

	// --------------------------------
	public void teacherManage() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users r=getModel(Users.class).getUserByUserId(userId);
		Long role=getModel(Users.class).getBigRole(userId);
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select tr.batch_id from teachers_recommend_table tr left join project_apply pa on tr.project_id=pa.project_id where pa.school_id ='"+r.get("school_id")+"') or b.batch_status=1 order by b.batch_status desc,b.batch_id desc");
		StringBuffer from = new StringBuffer();
		from.append(
				"from teachers_recommend_table tr left join users u on tr.teacher_id=u.user_id left join schools s on u.school_id=s.school_id ");
		from.append("left join batch b on tr.batch_id=b.batch_id ");
		from.append("left join project_apply pa on tr.project_id=pa.project_id where 1=1 ");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and tr.batch_id = ? ");
		}
		if (!ParaUtils.addLikeParam("keyWord", params, this)) {
			from.append(" and u.name like ? ");
		}
		//默认加载当前状态的申报项目,如果当前没有批次，则加载所有申报的项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			Batch batch=getModel(Batch.class).getCurBatch();
			if(batch!=null){
				from.append(" and tr.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		if(role==4){
			from.append(" and pa.school_id ='"+r.get("school_id")+"' order by tr.rec_date desc");
		}else{
			from.append(" order by tr.rec_date desc");
		}
		List<Record> list = pages(
				"select tr.batch_id, b.batch_name, tr.teacher_id, u.name, s.school_name, tr.t_type, tr.project_id, pa.project_name,tr.audit_date,tr.status ",
				from.toString(), params.toArray());
		setAttr("batchList", batchList);
		setAttr("role", role);
		render(view("teacherManage.jsp"));
	}

	public void addT() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users r=getModel(Users.class).getUserByUserId(userId);
		Batch batch=getModel(Batch.class).getCurBatch();
		StringBuffer from = new StringBuffer();
		from.append("select batch_id, project_id, project_name, user_id ");
		from.append("from project_apply where 1=1 and submit_status=9 and batch_id='"+batch.get("batch_id")+"' and school_id ='"+r.get("school_id")+"'");
		List<Record> list = Db.find(from.toString());
		setAttr("listP", list);
		setAttr("batchId",batch.get("batch_id"));
		render(view("addTeaRe.jsp"));
	}

	public void getTchTeachers() {
		String project_id = getAttr("project_id");
		String type = getAttr("t_type");
		List<Record> teacherlist = new ArrayList<Record>();
		if(type.equals("2")){
			// 项目表中的导师
			Record tutorRecord = Db.findFirst(
					"select u.user_id, u.name, u.mobile, u.teach_course from project_apply pa left join users u on pa.user_id=u.user_id where pa.project_id = ?",
					project_id);
			teacherlist.add(tutorRecord);
		}else{
			// 组队表中的中师 where t.team_status=4
			Record teacherRecord = Db.findFirst(
					"select u.user_id, u.name, u.mobile, u.teach_course from team_table tt left join users u on tt.user_id=u.user_id where tt.project_id = ?",
					project_id);
			teacherlist.add(teacherRecord);
		}
		setAttr("teacherList", teacherlist);
		renderJson();
	}

	// 根据教师id，得到教师基本信息
	public void getTeaInfo() {
		Record teacherM = Db.findFirst(
				"select s.school_name, u.major, u.degree, u.teach_course, u.academic_pos from users u left join schools s on u.school_id=s.school_id where u.user_id = ?",
				getAttr("teacher_id"));
		setAttr("teacherM", teacherM);
		renderJson();
	}

	public void txAddTeacher() {
		Record r=Db.findFirst("select * from teachers_recommend_table where batch_id=? and teacher_id=? and t_type=?",getPara("batch_id"),getPara("teacher_id"),getPara("t_type"));
		if(r!=null){
			ParaUtils.addMsg(this, "该老师已被推优，不能重复推优！");
			teacherManage();
		}else{
			TRecommend t = new TRecommend();
			t.set("batch_id", getPara("batch_id"));
			t.set("t_type", getPara("t_type"));
			t.set("teacher_id", getPara("teacher_id"));
			t.set("project_id", getPara("project_id"));
			t.set("supervise_des", getPara("supervise_des"));
			t.set("rec_date", new Date());
			t.set("status", 0);
			t.save();
			msgOperateSuccess();
			teacherManage();
		}
	}

	// 未完成
	public void editT() {
		Record r=Db.findFirst("select * from teachers_recommend_table where batch_id=? and teacher_id=? and project_id=?",getPara("batch_id"),getPara("teacher_id"),getPara("project_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			teacherManage();
		}else{		
			StringBuffer from = new StringBuffer();
			from.append("select tr.batch_id, tr.teacher_id, u.name, tr.supervise_des, tr.t_type ");
			from.append(
					"from teachers_recommend_table tr left join users u on tr.teacher_id=u.user_id where tr.teacher_id = ? and tr.batch_id= ?,tr.teacher_id=? ");
			Record teacherM = Db.findFirst(from.toString(), getAttr("teacher_id"), getAttr("batch_id"),getAttr("teacher_id"));
			Record projectM = Db.findFirst("select project_id, project_name from project_apply where project_id = ? ",
					getAttr("project_id"));
			setAttr("teacherM", teacherM);
			setAttr("projectM", projectM);
			render(view("editTeaRe.jsp"));
		}
	}

	public void txEditTeacher() {
		Record r=Db.findFirst("select * from teachers_recommend_table where batch_id=? and teacher_id=? and project_id=?",getPara("batch_id"),getPara("teacher_id"),getPara("project_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			teacherManage();
		}else{	
			Db.update(
					"update teachers_recommend_table set supervise_des=?, rec_date=?,status=0 where teacher_id=? and batch_id = ? and project_id=?",
					getPara("supervise_des"), new Date(), getPara("teacher_id"), getPara("batch_id"),getPara("project_id"));
			msgOperateSuccess();
			teacherManage();
		}

	}

	public void txDelTeacher() {
		Record r=Db.findFirst("select * from teachers_recommend_table where batch_id=? and teacher_id=? and project_id=?",getPara("batch_id"),getPara("teacher_id"),getPara("project_id"));
		int status=r.getInt("status");
		if(status==2){
			ParaUtils.addMsg(this, "创新学院审核通过，不能进行修改！");
			teacherManage();
		}else{	
			try {
				Db.update("delete from teachers_recommend_table where teacher_id=? and batch_id = ? and project_id=?", getPara("teacher_id"),
						getPara("batch_id"),getPara("project_id"));
				ParaUtils.addMsg(this, "删除成功");
			} catch (Exception e) {
				ParaUtils.addMsg(this, "删除操作失败！");
			}
			teacherManage();
		}
	}

	public void viewT() {

			StringBuffer from = new StringBuffer();
			from.append("select tr.batch_id, tr.teacher_id, u.name, tr.supervise_des, tr.t_type,tr.audit_date,tr.remark ");
			from.append(
					"from teachers_recommend_table tr left join users u on tr.teacher_id=u.user_id where tr.teacher_id = ? and tr.batch_id= ?,tr.teacher_id=? ");
			Record teacherM = Db.findFirst(from.toString(), getAttr("teacher_id"), getAttr("batch_id"),getAttr("teacher_id"));
			Record projectM = Db.findFirst("select project_id, project_name from project_apply where project_id = ? ",
					getAttr("project_id"));
			setAttr("teacherM", teacherM);
			setAttr("projectM", projectM);
			render(view("viewTeaRe.jsp"));
	}
	
	public void exaP() {
		String project_id = getPara("project_id");
		setAttr("project",
				Db.findFirst(
						"select pr.batch_id, pr.project_id, pa.project_name, pr.assign, pr.achievement, pr.description, pr.rec_date, pr.status, pr.remark from project_recommend_table pr left join project_apply pa on pr.project_id=pa.project_id where pr.project_id = ?",
						project_id));
		render(view("exaProRe.jsp"));
	}

	public void txExaProject() {
		String status=getAttr("status");
		if(status.equals("pass")){
			int i = Db.update(
					"update project_recommend_table set status=2, audit_date=?, remark=? where project_id=? and batch_id = ?",
					new Date(), getPara("remark"), getPara("project_id"), getPara("batch_id"));
		}else{
			int i = Db.update(
					"update project_recommend_table set status=1, audit_date=?, remark=? where project_id=? and batch_id = ?",
					new Date(), getPara("remark"), getPara("project_id"), getPara("batch_id"));
		}
		ParaUtils.addMsg(this, "审核成功！");
		projectManage();

	}

	public void exaS() {
		setAttr("studentM",
				Db.findFirst(
						"select sr.batch_id, sr.student_id, u.name, sr.achievement, sr.description, sr.status, sr.remark from students_recommend_table sr left join users u on sr.student_id=u.user_id where student_id = ? and batch_id= ? ",
						getAttr("student_id"), getAttr("batch_id")));
		setAttr("projectM", Db.findFirst("select project_id, project_name from project_apply where project_id = ? ",
				getAttr("project_id")));
		render(view("exaStuRe.jsp"));
	}

	public void txExaStudent() {
		String status=getAttr("status");
		if(status.equals("pass")){
			int i = Db.update(
					"update students_recommend_table set status=2, audit_date=?, remark=? where student_id=? and batch_id = ?",
					new Date(), getPara("remark"), getPara("student_id"), getPara("batch_id"));
		}else{
			int i = Db.update(
					"update students_recommend_table set status=1, audit_date=?, remark=? where student_id=? and batch_id = ?",
					new Date(), getPara("remark"), getPara("student_id"), getPara("batch_id"));
		}
		ParaUtils.addMsg(this, "审核成功！");
		studentManage();

	}

	public void exaT() {
		StringBuffer from = new StringBuffer();
		from.append("select tr.batch_id, tr.teacher_id, u.name, tr.supervise_des, tr.t_type, tr.status, tr.remark ");
		from.append(
				"from teachers_recommend_table tr left join users u on tr.teacher_id=u.user_id where tr.teacher_id = ? and tr.batch_id= ? and tr.teacher_id=? ");
		setAttr("teacherM", Db.findFirst(from.toString(), getAttr("teacher_id"), getAttr("batch_id"),getAttr("teacher_id")));
		setAttr("projectM", Db.findFirst("select project_id, project_name from project_apply where project_id = ? ",
				getAttr("project_id")));
		render(view("exaTeaRe.jsp"));
	}

	public void txExaTeacher() {

		String status=getAttr("status");
		if(status.equals("pass")){
			int i = Db.update(
					"update teachers_recommend_table set status=2, audit_date=?, remark=? where teacher_id=? and batch_id = ? and project_id=?",
					new Date(), getPara("remark"), getPara("teacher_id"), getPara("batch_id"),getPara("project_id"));
		}else{
			int i = Db.update(
					"update teachers_recommend_table set status=1, audit_date=?, remark=? where teacher_id=? and batch_id = ? and project_id=?",
					new Date(), getPara("remark"), getPara("teacher_id"), getPara("batch_id"),getPara("project_id"));
		}
		ParaUtils.addMsg(this, "审核成功！");
		teacherManage();

	}

}
