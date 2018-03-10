package com.eyas.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.experimental.theories.FromDataPoints;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Batch;
import com.eyas.models.TrainingPlanDetail;
import com.eyas.models.TrainingPlanMain;
import com.eyas.models.Users;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.org.apache.bcel.internal.generic.Select;

public class StudyController extends BaseController {
	@Override
	protected void setPath() {
		setPath("/views/study/");
	}

	/**
	 * 高校教师设置培养计划--主界面
	 */
	public void index() {
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色
		if (role == 3) {
			// 3表示高校教师
			// 获取学科分类
			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from project_apply pa where pa.submit_status=8 and pa.user_id=?)",userId);
			setAttr("subjectList", subjectList);
			StringBuffer from = new StringBuffer();
			from.append("from project_apply pa " + "left join schools sch on pa.school_id=sch.school_id "
					+ "left join batch b on pa.batch_id=b.batch_id "
					+ "left join subject_category sc on pa.subject_cat_id = sc.subject_cat_id "
					+ "left join users users on pa.user_id = users.user_id  where pa.submit_status=8");
			List<String> params = new ArrayList<String>();
			if (!ParaUtils.addLikeParam("projectName", params, this)) {
				from.append(" and pa.project_name like ?");
			}
			if (!ParaUtils.addParam("subjectCatId", params, this)) {
				from.append(" and pa.subject_cat_id = ?");
			}
			from.append(" and pa.user_id = " + userId);
			from.append(" order by b.batch_id desc,pa.project_name desc");
			List<Record> list = pages(
					"select b.batch_name,pa.project_name,sc.subject_name,sch.school_name,pa.leader_name,pa.project_id ",
					from.toString(), params.toArray());
			render(view("index.jsp"));
		}else{
			render("/views/common/norights.jsp");
		}
	}

	/**
	 * 进度安排--显示
	 */
	public void scheduleView() {
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色 3表示高校教师
		if (role == 3) {
			// 获取项目ID
			String project_id = getAttr("project_id");
			String sql = "Select * from project_apply pa left join users user on pa.user_id = user.user_id "
					+ "left join subject_category sc on pa.subject_cat_id = sc.subject_cat_id "
					+ "left join schools sch on pa.school_id=sch.school_id " + "where project_id=" + project_id
					+ " and user.user_id=" + userId;
			Record list = (Record) Db.findFirst(sql);
			setAttr("project", list);

			// 获取进度信息
			TrainingPlanMain trainingPlanMain = new TrainingPlanMain();
			TrainingPlanMain list2 = trainingPlanMain.getTrainingPlanMain(project_id);
			setAttr("trainingPlanMain", list2);
			render(view("schedule_view.jsp"));
		}else{
			render("/views/common/norights.jsp");
		}
	}

	/**
	 * 进度安排--提交
	 */
	public void txSetSchedule() {
		String plan_id = getAttr("plan_id");
		// 进度安排Model:TrainingPlanMain
		TrainingPlanMain trainingPlanMain = new TrainingPlanMain();
		// 获取操作时间
		trainingPlanMain.set("opt_date", new Date());
		if (plan_id == null || "".equals(plan_id)) {
			save(trainingPlanMain);
			ParaUtils.addMsg(this, "提交成功");
		} else {
			update(trainingPlanMain);
			ParaUtils.addMsg(this, "修改成功");
		}
		index();
	}

	/**
	 * 设置培养计划--培养计划-显示
	 */
	public void planView() {
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色 3表示高校教师
		if (role == 3) {
			Record trainingPlanMain=Db.findFirst("select * from training_plan_main_table where project_id=?",getPara("project_id"));
			if(trainingPlanMain==null){
				ParaUtils.addMsg(this, "请先制定进度安排！");
				index();
			}else{
				String planId=trainingPlanMain.get("plan_id").toString();
				StringBuffer from = new StringBuffer();
				from.append("from team_detail_table tdt " + "left join users user on tdt.user_id=user.user_id " // user表示学生
						+ "left join grade grade on user.grade_id = grade.grade_id "
						+ "left join class class on user.class_id = class.class_id "
						+ "left join team_table team on tdt.team_id=team.team_id "
						+ "left join schools sch on user.school_id=sch.school_id "
						+ "left join users u on team.user_id=u.user_id " // u表示中学指导教师
						+" left join project_apply pa on team.project_id=pa.project_id"
						+ " where pa.user_id = " + userId+" and pa.submit_status=8" );// 查询当前教师的
				List<String> params = new ArrayList<String>();
				if (!ParaUtils.addParam("project_id", params, this)) {
					from.append(" and team.project_id = ?");
				}
				from.append(" order by team.project_id desc, user.user_id desc");
				List<Record> list = pages(
						"select user.user_id, user.name, user.sex, sch.school_name, grade.grade_name, class.class_name, u.name as tname ",
						from.toString(), params.toArray());
				setAttr("plan_id",planId);
				setAttr("project_id",getPara("project_id"));
				render(view("plan_view.jsp"));
			}
		}
	}

	/**
	 * 培养计划制定-培养计划内容--显示
	 */

	public void setStudyPlan() {
		String user_id = getAttr("user_id");
		String plan_id = getAttr("plan_id");
		String project_id = getAttr("project_id");
		setAttr("user_id", user_id);
		setAttr("plan_id", plan_id);
		setAttr("project_id", project_id);
		TrainingPlanDetail trainingPlanDetail = new TrainingPlanDetail();
		TrainingPlanDetail list = trainingPlanDetail.getTrainingPlanDetail(plan_id, user_id);
		setAttr("planDetail", list);
		render(view("set_plan_content.jsp"));
	}

	/**
	 * 培养计划内容--提交
	 */
	public void txSetPlanContent() {
		String plan_id = getAttr("plan_id");
		String user_id = getAttr("user_id");
		String plan_id1 = getAttr("plan_id1");
		String user_id1 = getAttr("user_id1");
		String plan_content = getAttr("plan_content");

		if ((plan_id1 == null || "".equals(plan_id1)) && (user_id1 == null || "".equals(user_id1))) {
			Record trainingPlanDetail = new Record().set("plan_id", plan_id).set("user_id", user_id)
					.set("plan_content", plan_content).set("opt_date", new Date());
			Db.save("training_plan_detail_table", trainingPlanDetail);
			ParaUtils.addMsg(this, "提交成功");
		} else {
			Date opt_date = new Date();
			Db.update(
					"update training_plan_detail_table set plan_content =? ,opt_date =? where plan_id =? and user_id =?",
					plan_content, opt_date, plan_id, user_id);
			ParaUtils.addMsg(this, "修改成功");
		}

		planView();

	}

	/**
	 * 培养计划查询--主界面
	 */
	public void queryProgramme() {
		// 0—中学生用户、1—中学教师 2—中学管理员 3—高校教师
		// 4—高校管理员 5—创新学院用户 6—创新学院管理员
		String schoolId = getSessionAttr("SESSION_SCHOOL_ID");
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色 3表示高校教师
		// 4高校管理员 6系统管理员
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		// 获取培养计划列表信息
		StringBuffer from = new StringBuffer();
		from.append("from team_detail_table tdt " // tdt学生参加项目信息表，team_id和学生id
				+ "left join team_table team on team.team_id = tdt.team_id " // team组队信息,获得batch_id和project_id
				+ "left join batch b on team.batch_id = b.batch_id " // b批次信息表
				// b.batch_name批次名称
				+ "left join project_apply pa on team.project_id = pa.project_id " // pa项目信息表
				// project_name项目名称
				// leader_name负责人
				+ "left join subject_category sc on pa.subject_cat_id = sc.subject_cat_id " // sc学科信息
				// sc.subject_name
				+ "left join schools sch on pa.school_id = sch.school_id " // sch承担学校信息
				// sch.school_name承担单位
				+ "left join users student on tdt.user_id = student.user_id " // student学生信息
				+ "left join grade grade on student.grade_id = grade.grade_id "
				+ "left join class class on student.class_id = class.class_id "
				+ "left join schools middleSchool on student.school_id = middleSchool.school_id " // middleSchool中学信息
				+ " where pa.submit_status=8");

		if (role == 6) { // 6系统管理员
			// 获取批次
			List<Record> batchList = Db.find("select * from batch where batch_id in(select pa.batch_id from project_apply pa where pa.submit_status=8)");
			setAttr("batchList", batchList);
			// 获取学科分类
			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from project_apply pa where pa.submit_status=8)");
			setAttr("subjectList", subjectList);
			// 获取所有承担单位
			List<Record> schoolList = Db.find("select * from schools where school_id in (select pa.school_id from project_apply pa where pa.submit_status=8)");
			setAttr("schoolList", schoolList);
			// 获取所有中学学校
			List<Record> middleSchoolList = Db.find("select * from schools where school_id in(select ft.highschool_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.submit_status=8)");
			setAttr("middleSchoolList", middleSchoolList);
		} else if (role == 4) { // 高校管理员
			// 获取批次
			List<Record> batchList = Db.find("select * from batch where batch_id in(select pa.batch_id from project_apply pa where pa.submit_status=8 and pa.school_id=?)",schoolId);
			setAttr("batchList", batchList);

			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from project_apply pa where pa.submit_status=8 and pa.school_id=?)",schoolId);
			setAttr("subjectList", subjectList);
			// 只能选择其所在学校
			List<Record> schoolList = Db
					.find("select * from schools where school_type = 0 and school_id = " + schoolId);
			setAttr("schoolList", schoolList);
			// 获取其学校项目发给的中学学校
			/////////////////////////////////////////////////////////////////////////////////////////////////
			List<Record> middleSchoolList = Db.find("select * from schools where school_id in(select ft.highschool_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.submit_status=8 and pa.school_id=?)",schoolId);
			setAttr("middleSchoolList", middleSchoolList);
			// 高校管理员只能看到选本高校项目的培养计划列表
			from.append(" and pa.school_id ='" +schoolId+"'");
		}else if (role == 3) { // 高校教师 
			List<Record> batchList = Db.find("select * from batch where batch_id in(select pa.batch_id from project_apply pa where pa.submit_status=8 and pa.school_id=? and pa.user_id=?)",schoolId,userId);
			setAttr("batchList", batchList);

			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from project_apply pa where pa.submit_status=8 and pa.school_id=? and pa.user_id=?)",schoolId,userId);
			setAttr("subjectList", subjectList);
			// 只能选择其所在学校			
			List<Record> schoolList = Db
					.find("select * from schools where school_type = 0 and school_id = ?",schoolId);
			setAttr("schoolList", schoolList);
			// 获取其项目发给的中学学校
			/////////////////////////////////////////////////////////////////////////////////////////////////
			List<Record> middleSchoolList = Db.find("select * from schools where school_id in(select ft.highschool_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.submit_status=8 and pa.school_id=? and pa.user_id=?)",schoolId,userId);
			setAttr("middleSchoolList", middleSchoolList);

			from.append(" and pa.user_id ='" +userId+"'");
		}else if (role == 2) { // 中学管理员
			List<Record> batchList = Db.find("select * from batch where batch_id in(select pa.batch_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.submit_status=8 and ft.highschool_id=?)",schoolId);
			setAttr("batchList", batchList);

			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.submit_status=8 and ft.highschool_id=?)",schoolId);
			setAttr("subjectList", subjectList);
			// 只能选择其所在学校			
			List<Record> schoolList = Db
					.find("select * from schools where school_id in(select pa.school_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.submit_status=8 and ft.highschool_id=?)",schoolId);
			setAttr("schoolList", schoolList);
			// 获取其项目发给的中学学校
			/////////////////////////////////////////////////////////////////////////////////////////////////
			List<Record> middleSchoolList = Db
					.find("select * from schools where school_type = 1 and school_id = " + schoolId);
			setAttr("middleSchoolList", middleSchoolList);

			from.append(" and student.school_id ='" +schoolId+"'");
		}else if (role == 1) { // 中学指导教师
			List<Record> batchList = Db.find("select * from batch where batch_id in(select pa.batch_id from team_table tt left join project_apply pa on tt.project_id=pa.project_id where  pa.submit_status=8 and tt.user_id=?)",userId);
			setAttr("batchList", batchList);

			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from team_table tt left join project_apply pa on tt.project_id=pa.project_id where  pa.submit_status=8 and tt.user_id=?)",userId);
			setAttr("subjectList", subjectList);
			// 只能选择其所在学校			
			List<Record> schoolList = Db
					.find("select * from schools where school_id in(select pa.school_id from team_table tt left join project_apply pa on tt.project_id=pa.project_id where pa.submit_status=8 and tt.user_id=?)",userId);
			setAttr("schoolList", schoolList);
			// 获取其项目发给的中学学校
			/////////////////////////////////////////////////////////////////////////////////////////////////
			List<Record> middleSchoolList = Db
					.find("select * from schools where school_type = 1 and school_id = " + schoolId);
			setAttr("middleSchoolList", middleSchoolList);

			from.append(" and team.user_id ='" +userId+"'");
		}else if (role == 0) { // 中学生
			List<Record> batchList = Db.find("select * from batch where batch_id in(select pa.batch_id from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join project_apply pa on tt.project_id=pa.project_id where  pa.submit_status=8 and td.user_id=?)",userId);
			setAttr("batchList", batchList);

			List<Record> subjectList = Db.find("select * from subject_category where subject_cat_id in(select pa.subject_cat_id from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join project_apply pa on tt.project_id=pa.project_id where  pa.submit_status=8 and td.user_id=?)",userId);
			setAttr("subjectList", subjectList);
			// 只能选择其所在学校			
			List<Record> schoolList = Db
					.find("select * from schools where school_id in(select pa.school_id from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join project_apply pa on tt.project_id=pa.project_id where pa.submit_status=8 and td.user_id=?)",userId);
			setAttr("schoolList", schoolList);
			// 获取其项目发给的中学学校
			/////////////////////////////////////////////////////////////////////////////////////////////////
			List<Record> middleSchoolList = Db
					.find("select * from schools where school_type = 1 and school_id = " + schoolId);
			setAttr("middleSchoolList", middleSchoolList);

			from.append(" and tdt.user_id ='" +userId+"'");
		}

		//默认加载当前状态的申报项目,如果当前没有批次，则加载所有申报的项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			if(batch!=null){
				from.append(" and pa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}

		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pa.batch_id = ?");
		}
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addLikeParam("studentName", params, this)) {
			from.append(" and student.name like ?");
		}
		if (!ParaUtils.addParam("subjectCatId", params, this)) {
			from.append(" and pa.subject_cat_id = ?");
		}
		if (!ParaUtils.addParam("schoolId", params, this)) {
			from.append(" and pa.school_id = ?");
		}
		if (!ParaUtils.addParam("middleSchoolId", params, this)) {
			from.append(" and middleSchool.school_id = ?");
		}

		from.append(" order by b.batch_id desc,pa.project_name desc");
		List<Record> planList = pages(
				"select b.batch_name,pa.project_name,sc.subject_name,sch.school_name,pa.leader_name,middleSchool.school_name as middleSchool,grade.grade_name,class.class_name,student.name as student_name,b.batch_id,pa.project_id,student.user_id ",
				from.toString(), params.toArray());
		setAttr("planList", planList);
		render(view("query_programme.jsp"));
	}

	/**
	 * 查看项目培养计划详情
	 */
	public void detailPlanView() {
		String batchId = getAttr("batch_id"); // 批次id
		String projectId = getAttr("project_id"); // 项目id
		String studentId = getAttr("student_id"); // 学生id
		Record pa = Db.findFirst("select * from project_apply pa left join schools on pa.school_id = schools.school_id "
				+ "left join subject_category sc on pa.subject_cat_id = sc.subject_cat_id "
				+ "where project_id = ?",projectId);

		Record trainingPlanMain = Db.findFirst(
				"select * from training_plan_main_table where batch_id = ? and project_id = ?", batchId, projectId);
		long planId = trainingPlanMain.getLong("plan_id");
		Record trainingPlanDetail = Db.findFirst(
				"select * from training_plan_detail_table where plan_id = ? and user_id = ?", planId, studentId);
		setAttr("trainingPlanMain", trainingPlanMain); // 项目计划
		setAttr("trainingPlanDetail", trainingPlanDetail); // 个人计划

		setAttr("pa", pa);
		render(view("detail_plan_view.jsp"));
	}
}
