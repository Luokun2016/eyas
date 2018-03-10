package com.eyas.controllers;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.Batch;
import com.eyas.models.Classes;
import com.eyas.models.DetailInformationApply;
import com.eyas.models.Feedback;
import com.eyas.models.Grade;
import com.eyas.models.ProjectApply;
import com.eyas.models.Schools;
import com.eyas.models.TeamTable;
import com.eyas.models.Users;
import com.eyas.utils.FileUtils;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

public class ProjectController extends BaseController {

	@Override
	protected void setPath() {
		setPath("/views/project/");
	}

	/**
	 * 获取批次列表
	 */
	public void index() {
		StringBuffer from = new StringBuffer();
		from.append("from batch b where 1=1");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("batchName", params, this)) {
			from.append(" and b.batch_name like ?");
		}
		if (!ParaUtils.addParam("batchStatus", params, this)) {
			from.append(" and b.batch_status = ?");
		}
		from.append(" order by b.batch_status desc,b.batch_id desc");
		List<Record> list=pages("select b.batch_id,b.batch_name,b.begin_date,b.apply_end_date,b.check_end_time,b.batch_status ", from.toString(), params.toArray());
		render(view("index.jsp"));
	}
	/**
	 * tx开头的方法，加入事务 添加新的签报是的加载
	 */
	public void txAddInitialize() {
		render(view("add.jsp"));
	}
	/**
	 * tx开头的方法，保存签报
	 */
	public void txSave() {
		Batch b = new Batch();
		b.set("batch_status", 0);
		Date now=new Date();
		SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String endDate=getPara("begin_date")+":00";
		Date beginDate=null;;
		try {
			beginDate = sim.parse(endDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(now.compareTo(beginDate)>0)
		{
			ParaUtils.addMsg(this, "立项失败，当前时间大于发布时间！");
			index();
		}else{
			//获取附件信息
			String[] attach_files=getParaValues("attach_file");
			String[] attach_files1=getParaValues("attach_file1");
			String[] attach_files2=getParaValues("attach_file2");
			String[] attach_files3=getParaValues("attach_file3");
			String[] attach_files4=getParaValues("attach_file4");
			if(attach_files!=null&&attach_files.length>=1)
				b.set("require_attach",attach_files[0]);
			if(attach_files1!=null&&attach_files1.length>=1)
				b.set("apply_temp",attach_files1[0]);
			if(attach_files2!=null&&attach_files2.length>=1)
				b.set("interim_report",attach_files2[0]);
			if(attach_files3!=null&&attach_files3.length>=1)
				b.set("final_report",attach_files3[0]);
			if(attach_files4!=null&&attach_files4.length>=1)
				b.set("conclusion_report",attach_files4[0]);
			save(b);
			ParaUtils.addMsg(this, "提交成功！");
			index();
		}
	}   


	/**
	 * 上传文件
	 */
	public void upload() {
		UploadFile uf = getFile();
		String ext = uf.getFileName().substring(
				uf.getFileName().lastIndexOf(".") + 1);
		ext = "." + ext;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String fileName = sdf.format(new Date()) + ext;
		String path = FileUtils.getWebInfPath() +CONST.BATCH_PATH;
		File file = new File(path);
		//判断是否存在该文件夹，如果不存在则创建
		if(!file.exists()) {
			file.mkdir();
		}
		FileUtils.copyFile(uf.getFile().getAbsolutePath(), path, fileName);
		FileUtils.deleteFile(uf.getFile().getAbsolutePath());
		renderJson(fileName);
	}

	public void downLoad() {
		String docId = getPara("attach_file");
		try {
			File f = new File(FileUtils.getWebInfPath() +CONST.BATCH_PATH+docId);
			if(!f.isFile()){
				msgOperateError();
			}
			else renderFile(f);
		} catch (Exception e) {
			msgOperateError();
		}
	}

	/**
	 * 查看立项详情
	 */
	public void view(){
		String batchId=getAttr("batch_id");
		Batch batch=getModel(Batch.class).findById(batchId);
		setAttr("batch", batch);
		render(view("view.jsp"));
	}

	/**
	 * 修改立项
	 */
	public void txEdit() {

		if (UPDATE.equals(getFlag())) {
			Batch b=new Batch();
			Date now=new Date();
			SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String endDate=getPara("begin_date")+":00";
			Date beginDate=null;;
			try {
				beginDate = sim.parse(endDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(now.compareTo(beginDate)>0)
			{
				ParaUtils.addMsg(this, "立项修改失败，当前时间大于发布时间！");
				index();
			}else{
				String[] attach_files=getParaValues("attach_file");
				String[] attach_files1=getParaValues("attach_file1");
				String[] attach_files2=getParaValues("attach_file2");
				String[] attach_files3=getParaValues("attach_file3");
				String[] attach_files4=getParaValues("attach_file4");
				if(attach_files!=null&&attach_files.length>=1)
					b.set("require_attach",attach_files[0]);
				if(attach_files1!=null&&attach_files1.length>=1)
					b.set("apply_temp",attach_files1[0]);
				if(attach_files2!=null&&attach_files2.length>=1)
					b.set("interim_report",attach_files2[0]);
				if(attach_files3!=null&&attach_files3.length>=1)
					b.set("final_report",attach_files3[0]);
				if(attach_files4!=null&&attach_files4.length>=1)
					b.set("conclusion_report",attach_files4[0]);
				update(b);
				ParaUtils.addMsg(this, "修改成功！");
				index();
			}
		}else{
			String batchId=getAttr("batch_id");
			Batch batch=getModel(Batch.class).findById(batchId);
			Date now = new Date(); 
			Date applyDate=batch.getTimestamp("apply_end_date");
			if(now.before(applyDate)){
				setAttr("batch", batch);
				render(view("edit.jsp"));
			}else{
				ParaUtils.addMsg(this, "该立项不能修改，当前时间大于申报截止时间");
				index();
			}
		}
	}

	/**
	 * 立项当前/非当前的切换
	 */
	public void txStatus() {
		String batchId=getAttr("batch_id");
		Batch batch=getModel(Batch.class).findById(batchId);
		int status=batch.getInt("batch_status");
		if(status==1){
			Db.update("update batch set batch_status=0 where batch_id=?", batchId);
			ParaUtils.addMsg(this, "设置为非当前操作成功");
		}
		else{
			Record b=Db.findFirst("select * from batch where batch_status=?", 1);
			if(b==null){
				Db.update("update batch set batch_status=1 where batch_id=?", batchId);
				ParaUtils.addMsg(this, "设置为当前操作成功");
			}else{
				ParaUtils.addMsg(this, "操作失败，只能有一个当前");
			}
		}
		index();
	}

	/**
	 * 删除立项
	 */
	public void txDel() {
		//删除批次
		String batchId=getAttr("batch_id");
		Batch batch=getModel(Batch.class).findById(batchId);
		Date now = new Date(); 
		Date applyDate=batch.getTimestamp("apply_end_date");
		if(now.before(applyDate)){
			List batchApplyList=Db.find("select * from project_apply where batch_id=?",getAttr("batch_id"));
			if(batchApplyList.size()==0)  //当前批次下没有项目
			{
				try {
					Db.update("delete from batch where batch_id=?", batchId);
					ParaUtils.addMsg(this, "删除成功");
				} catch (Exception e) {
					//存在级联，删除失败
					ParaUtils.addMsg(this, "操作失败，当前批次下有申报的项目");
				} 
			}else{
				ParaUtils.addMsg(this, "操作失败，当前批次下有申报的项目");
			}
		}else{			
			ParaUtils.addMsg(this, "操作失败，当前时间大于申报截止时间");
		}
		index();
	}

	/**
	 * 获取申报项目列表
	 */
	public void apply() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Long role=getModel(Users.class).getBigRole(userId);
		List batchList=null;
		StringBuffer from = new StringBuffer();
		from.append("from project_apply pa left join schools sch on pa.school_id=sch.school_id left join batch b on pa.batch_id=b.batch_id  where 1=1");
		if(role==6){
			//创新学院管理员，可以查看所有申报项目
			from.append(" and pa.submit_status!=0");
			batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select batch_id from project_apply) or b.batch_status=1  order by b.batch_status desc,b.batch_id desc");
		}else if(role==4){
			//高校管理员，只能查看自己学校的
			Users r=getModel(Users.class).getUserByUserId(userId);
			from.append(" and pa.school_id ="+r.get("school_id")+" and pa.submit_status!=0");
			batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pa.batch_id from project_apply pa where pa.school_id ="+r.get("school_id")+") or b.batch_status=1 order by b.batch_status desc,b.batch_id desc");
		}else{
			//高校教师只能查看自己申报的项目
			from.append(" and pa.user_id="+userId);
			batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pa.batch_id from project_apply pa where pa.user_id="+userId+") or b.batch_status=1 order by b.batch_status desc,b.batch_id desc");
		}
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addLikeParam("schoolName", params, this)) {
			from.append(" and sch.school_name like ?");
		}
		if (!ParaUtils.addLikeParam("leaderName", params, this)) {
			from.append(" and pa.leader_name like ?");
		}
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pa.batch_id = ?");
		}
		//默认加载当前状态的申报项目,如果当前没有批次，则加载所有申报的项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			Batch batch=getModel(Batch.class).getCurBatch();
			if(batch!=null){
				from.append(" and pa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		setAttr("batchList", batchList);
		from.append(" order by pa.submit_time desc");
		List<Record> list=pages("select b.batch_name,pa.batch_id,pa.project_id,pa.project_name,sch.school_name,pa.leader_name,pa.submit_time,pa.project_status,pa.submit_status ", from.toString(), params.toArray());
		render(view("apply.jsp"));
	}

	/**
	 * 添加新申报,同一批次只能申报一个项目
	 */
	public void txAddApplyInitialize() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Long role=getModel(Users.class).getBigRole(userId);
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			Date now=new Date();
			Date applyEndDate=batch.getTimestamp("apply_end_date");
			if(now.compareTo(applyEndDate)>0)
			{
				ParaUtils.addMsg(this, "项目申报失败，当前时间大于申报截止时间！");
				apply();
			}else if(role==3||role==4){  //高校教师或者高校管理员
				List applyList=Db.find("select * from project_apply where batch_id=? and user_id=?",batch.get("batch_id"),userId);  //获取当前批次的
				if(applyList.size()>0){
					ParaUtils.addMsg(this, "当前批次已有申报项目，不能重新申报项目");
					apply();
				}else{
					setAttr("batch", batch);
					render(view("apply_require_add.jsp"));
				}
			}else{
				ParaUtils.addMsg(this, "当前用户没有该权限！");
				apply();
			}
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行申报项目！");
			apply();
		}
	}

	/**
	 * 我要申报
	 */
	public void txAddApply() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			Date now=new Date();
			Date applyEndDate=batch.getTimestamp("apply_end_date");
			if(now.compareTo(applyEndDate)>0)
			{
				ParaUtils.addMsg(this, "项目申报失败，当前时间大于申报截止时间！");
				apply();
			}else{
				List subCategory=Db.find("select * from subject_category");
				Schools sch=getModel(Schools.class).findFirst("select * from schools s where s.school_id in(select school_id from users where user_id=?)",userId);
				setAttr("subCategory", subCategory);
				setAttr("sch", sch);
				setAttr("batch", batch);
				render(view("add_apply.jsp"));
			}
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行申报项目！");
			apply();
		}
	}

	/**
	 * 上传文件
	 */
	public void uploadApply() {
		UploadFile uf = getFile();
		String ext = uf.getFileName().substring(
				uf.getFileName().lastIndexOf(".") + 1);
		ext = "." + ext;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String fileName = sdf.format(new Date()) + ext;
		String path = FileUtils.getWebInfPath() +CONST.APPLY_PATH;
		File file = new File(path);
		//判断是否存在该文件夹，如果不存在则创建
		if(!file.exists()) {
			file.mkdir();
		}
		FileUtils.copyFile(uf.getFile().getAbsolutePath(), path, fileName);
		FileUtils.deleteFile(uf.getFile().getAbsolutePath());
		renderJson(fileName);
	}

	public void applyDownLoad() {
		String docId = getPara("attach_file");
		try {
			File f = new File(FileUtils.getWebInfPath() +CONST.APPLY_PATH+docId);
			if(!f.isFile()){
				msgOperateError();
			}
			else renderFile(f);
		} catch (Exception e) {
			msgOperateError();
		}
	}

	public void txApplySave() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			Long role=getModel(Users.class).getBigRole(userId);
			Date now=new Date();
			Date applyEndDate=batch.getTimestamp("apply_end_date");
			if(now.compareTo(applyEndDate)>0)
			{
				ParaUtils.addMsg(this, "项目申报失败，当前时间大于申报截止时间！");
			}else if(role==3||role==4){
				ProjectApply pa=new ProjectApply();
				pa.set("user_id", userId);
				pa.set("project_status", 0);  //审核状态为未审核
				pa.set("is_publish", 0);  //发布状态为否
				if("save".equals(getFlag())){
					pa.set("submit_status", 0);   //项目状态为未提交
				}else{
					pa.set("submit_status", 1);   //项目状态为申报已提交
				}
				pa.set("submit_time", new Date());
				//获取附件信息
				String[] attach_files=getParaValues("attach_file");
				if(attach_files!=null&&attach_files.length>=1)
					pa.set("project_attach",attach_files[0]);
				save(pa);
				if("save".equals(getFlag())){
					ParaUtils.addMsg(this, "保存成功！");
				}else{
					ParaUtils.addMsg(this, "提交成功！");
				}
			}else{
				ParaUtils.addMsg(this, "当前用户没有该权限！");
			}
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行申报项目！");
		}
		apply();
	}   


	/**
	 * 查看立项要求
	 */
	public void applyRequirement(){
		String batchId=getAttr("batch_id");
		Batch batch=getModel(Batch.class).findById(batchId);
		setAttr("batch", batch);
		render(view("apply_requirement.jsp"));
	}

	/**
	 * 查看项目详情
	 */
	public void txApplyView(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		String projectId=getAttr("project_id");
		Long role=getModel(Users.class).getBigRole(userId);
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join schools s on pa.school_id=s.school_id where pa.project_id=?",projectId);
		setAttr("projectApply", projectApply);
		setAttr("role", role);
		render(view("view_apply.jsp"));
	}

	/**
	 * 项目审核
	 */

	public void txApplyJudge() {
		int projectStatus = Integer.parseInt(getPara("project_status"));  //项目审核状态
		Batch batch=getModel(Batch.class).findById(getAttr("batch_id"));
		if(batch!=null){
			Date now=new Date();
			Date checkEndDate=batch.getTimestamp("check_end_time");
			if(now.compareTo(checkEndDate)>0)
			{
				ParaUtils.addMsg(this, "项目审核失败，当前时间大于申报截止时间！");
				apply();
			}else if("one".equals(getFlag())){
				//初审
				String remark1=getPara("remark1");
				Db.update("update project_apply set project_status=?,remark1=? where project_id=?", projectStatus,remark1,getPara("project_id"));
				ParaUtils.addMsg(this, "初审完成！");
				apply();
			}else{
				//复审
				int submitStatus = Integer.parseInt(getPara("submit_status"));  //项目状态
				String remark2=getPara("remark2");
				Db.update("update project_apply set project_status=?,submit_status=?,remark2=? where project_id=?", projectStatus,submitStatus,remark2,getPara("project_id"));
				ParaUtils.addMsg(this, "复审完成！");
				apply();
			}
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行申报项目！");
			apply();
		}
	}

	/**
	 * 修改申报项目
	 */
	public void txApplyEdit() {
		if (UPDATE.equals(getFlag())) {
			String userId=getSessionAttr(CONST.SESSION_USER_ID);
			String status=getPara("status");
			ProjectApply pa=new ProjectApply();
			pa.set("user_id", userId);
			pa.set("project_status", 0);  //审核状态为未审核
			pa.set("is_publish", 0);  //发布状态为否
			if("save".equals(status)){
				pa.set("submit_status", 0);   //项目状态为未提交
			}else{
				pa.set("submit_status", 1);   //项目状态为申报已提交
			}
			pa.set("remark1", "");
			pa.set("remark2", "");
			pa.set("submit_time", new Date());
			//获取附件信息
			String[] attach_files=getParaValues("attach_file");
			if(attach_files!=null&&attach_files.length>=1)
				pa.set("project_attach",attach_files[0]);
			update(pa);
			if("save".equals(status)){
				ParaUtils.addMsg(this, "保存成功！");
			}else{
				ParaUtils.addMsg(this, "提交成功！");
			}
			apply();
		}else{
			String projectId=getAttr("project_id");
			ProjectApply projectApply=getModel(ProjectApply.class).findById(projectId);
			Long projectStatus=projectApply.get("project_status");
			if(projectStatus==0||projectStatus==2||projectStatus==4)  //未审核，初审未通过，复审未通过
			{
				List subCategory=Db.find("select * from subject_category");
				Schools sch=getModel(Schools.class).findById(projectApply.get("school_id"));
				setAttr("projectApply", projectApply);
				setAttr("subCategory", subCategory);
				setAttr("sch", sch);
				render(view("edit_apply.jsp"));
			}else{
				ParaUtils.addMsg(this, "该申报项目不能修改");
				apply();
			}
		}
	}

	/**
	 * 删除申报项目
	 */
	public void txApplyDel() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		ProjectApply projectApply=getModel(ProjectApply.class).findById(getPara("project_id"));
		Long projectStatus=projectApply.get("project_status");
		String apply_tch_id=projectApply.get("user_id").toString();
		if(projectStatus==0||projectStatus==2||projectStatus==4)  //未审核，初审未通过，复审未通过
		{
			if(userId.equals(apply_tch_id))
			{
				Db.update("delete from project_apply where project_id=?", getPara("project_id"));
				ParaUtils.addMsg(this, "删除成功");
			}else{
				ParaUtils.addMsg(this, "操作失败，您没有相应的权限");
			}
		}else{			
			ParaUtils.addMsg(this, "操作失败，申报项目不能被删除");
		}
		apply();
	}

	/**
	 * *项目筛选和反馈   只有中学管理员才有的功能
	 */
	public void choose() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学管理员隶属的学校ID
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pa.batch_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.highschool_id=?) or b.batch_status=1  order by b.batch_status desc,b.batch_id desc",highSchoolId);
		List schoolList=Db.find("select school_id,school_name from schools where school_id in (select pa.school_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.highschool_id=?)",highSchoolId);
		StringBuffer from = new StringBuffer();
		from.append("from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id left join batch b on pa.batch_id=b.batch_id left join schools sch on pa.school_id=sch.school_id where ft.highschool_id='"+highSchoolId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pa.batch_id = ?");
		}
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addParam("schoolId", params, this)) {
			from.append(" and pa.school_id = ?");
		}
		//默认加载当前状态的申报项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			if(batch!=null){
				from.append(" and pa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		setAttr("batchList", batchList);
		setAttr("schoolList", schoolList);
		List<Record> list=pages("select * ", from.toString(), params.toArray());
		render(view("choose.jsp"));
	}

	/**
	 * 添加新的项目筛选的可以筛选的列表
	 */
	public void txChooseAddInitialize() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		//中学管理员所属的学校
		String highSchoolId=user.get("school_id").toString();
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			List schoolList=Db.find("select school_id,school_name from schools where school_id in (select pa.school_id from project_apply pa where pa.batch_id='"+batch.get("batch_id")+"' and pa.submit_status=3 and  pa.school_id in (select school_id from school_relationship where associate_school_id='"+highSchoolId+"') and pa.project_id not in (select project_id from feedback_table where highschool_id='"+highSchoolId+"'))");
			StringBuffer from = new StringBuffer();
			from.append("from project_apply pa left join schools sch on pa.school_id=sch.school_id left join batch b on pa.batch_id=b.batch_id where pa.batch_id='"+batch.get("batch_id")+"' and pa.submit_status=3 and pa.school_id in (select school_id from school_relationship where associate_school_id='"+highSchoolId+"') and pa.project_id not in (select project_id from feedback_table where highschool_id='"+highSchoolId+"') ");
			List<String> params = new ArrayList<String>();
			if (!ParaUtils.addLikeParam("projectName", params, this)) {
				from.append(" and pa.project_name like ?");
			}
			if (!ParaUtils.addParam("schoolId", params, this)) {
				from.append(" and pa.school_id = ?");
			}
			setAttr("schoolList", schoolList);
			List<Record> list=pages("select * ", from.toString(), params.toArray());
			render(view("choose_list.jsp"));
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行项目筛选反馈！");
			choose();
		}
	}

	/**
	 * 新增筛选时查看项目详情
	 */
	public void txChooseProjectView(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		String projectId=getPara("project_id");
		Long role=getModel(Users.class).getBigRole(userId);
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join schools s on pa.school_id=s.school_id where pa.project_id=?",projectId);
		setAttr("projectApply", projectApply);
		setAttr("role", role);
		render(view("view_choose.jsp"));
	}

	/**
	 * 新增筛选时的项目
	 */
	public void txChooseProjectAdd(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学管理员隶属的学校ID
		Feedback feedback=new Feedback();
		feedback.set("highschool_id",highSchoolId);
		feedback.set("assigned",0);
		save(feedback);
		ParaUtils.addMsg(this, "筛选项目成功");
		choose();
	}

	/**
	 * 删除筛选时的项目
	 */
	public void txChooseProjectDel(){
		Record projectApply =(Record) Db.findFirst("select * from project_apply where project_id in (select project_id from feedback_table where feedback_id="+getPara("feedback_id")+")");
		int submitStatus=Integer.parseInt(projectApply.get("submit_status").toString());
		if(submitStatus<5){
			Db.update("delete from feedback_table where feedback_id=?",getPara("feedback_id"));
			ParaUtils.addMsg(this, "项目删除成功");
		}else{
			ParaUtils.addMsg(this, "当前项目不能被删除");
		}
		choose();
	}

	/**
	 * 高校管理员正式发布项目
	 */
	public void release() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String schoolId=user.get("school_id").toString();   //高校管理员隶属的学校ID
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pa.batch_id from project_apply pa where pa.school_id=?) or b.batch_status=1  order by b.batch_status desc,b.batch_id desc",schoolId);
		StringBuffer from = new StringBuffer();
		from.append("from project_apply pa left join batch b on pa.batch_id=b.batch_id left join schools sch on pa.school_id=sch.school_id where pa.school_id='"+schoolId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pa.batch_id = ?");
		}
		if (!ParaUtils.addLikeParam("leaderName", params, this)) {
			from.append(" and pa.leader_name like ?");
		}
		if (!ParaUtils.addParam("isPublish", params, this)) {
			from.append(" and pa.is_publish = ?");
		}
		//默认加载当前状态的申报项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			if(batch!=null){
				from.append(" and pa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		from.append(" order by pa.publish_date desc");
		setAttr("batchList", batchList);
		List<Record> list=pages("select *", from.toString(), params.toArray());
		render(view("release.jsp"));
	}

	/**
	 * 高校管理员查看反馈的学校
	 */
	public void txReleaseSchoolView() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String schoolId=user.get("school_id").toString();   //高校管理员隶属的学校ID
		ProjectApply projectApply=getModel(ProjectApply.class).findById(getPara("project_id"));
		String schoolIdNow=projectApply.get("school_id").toString();
		StringBuffer from = new StringBuffer();
		if(!schoolId.equals(schoolIdNow)){
			ParaUtils.addMsg(this, "对不起，您不能查看相应的反馈学校情况");
			release();
		}else{
			from.append("from schools where school_id in (select highschool_id from feedback_table where project_id='"+getPara("project_id")+"')");
			List<String> params = new ArrayList<String>();
			if (!ParaUtils.addLikeParam("schoolName", params, this)) {
				from.append(" and school_name like ?");
			}
			List<Record> list=pages("select *", from.toString(), params.toArray());
			render(view("release_feedschool.jsp"));
		}
	}

	/**
	 * 高校管理员查看分配的学校     一个项目只能分配给一个中学去做
	 */
	public void txReleaseView() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String schoolId=user.get("school_id").toString();   //高校管理员隶属的学校ID
		ProjectApply projectApply=getModel(ProjectApply.class).findById(getPara("project_id"));
		String schoolIdNow=projectApply.get("school_id").toString();
		StringBuffer from = new StringBuffer();
		if(!schoolId.equals(schoolIdNow)){
			ParaUtils.addMsg(this, "对不起，您不能查看相应的分配学校情况");
			release();
		}else{
			from.append("from schools where school_id in(select highschool_id from feedback_table where project_id='"+getPara("project_id")+"' and assigned=1)");
			List<String> params = new ArrayList<String>();
			if (!ParaUtils.addLikeParam("schoolName", params, this)) {
				from.append(" and school_name like ?");
			}
			List<Record> list=pages("select *", from.toString(), params.toArray());
			render(view("release_releaseschool.jsp"));
		}
	}

	/**
	 * 点击发布按钮
	 */
	public void txReleaseInitialize() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String schoolId=user.get("school_id").toString();   //高校管理员隶属的学校ID
		ProjectApply projectApply=getModel(ProjectApply.class).findById(getPara("project_id"));
		String schoolIdNow=projectApply.get("school_id").toString();
		if(!schoolId.equals(schoolIdNow)){
			ParaUtils.addMsg(this, "对不起，您不能发布该项目");
			release();
		}else{
			int submitStatus=Integer.parseInt(projectApply.get("submit_status").toString());
			if(submitStatus>=5){
				ParaUtils.addMsg(this, "对不起，该项目不能发布");
				release();
			}else{
			StringBuffer from = new StringBuffer();
			from.append("from schools where school_id in (select highschool_id from feedback_table where project_id='"+getPara("project_id")+"')");
			List<String> params = new ArrayList<String>();
			List<Record> list=pages("select *", from.toString(), params.toArray());
			render(view("release_add.jsp"));
			}
		}
	}

	/**
	 * 发布项目
	 */
	public void txReleaseAdd() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String schoolId=user.get("school_id").toString();   //高校管理员隶属的学校ID
		ProjectApply projectApply=getModel(ProjectApply.class).findById(getPara("projectadd_id"));
		String schoolIdNow=projectApply.get("school_id").toString();
		if(!schoolId.equals(schoolIdNow)){
			ParaUtils.addMsg(this, "对不起，您不能发布该项目");
			release();
		}else{
			int submitStatus=Integer.parseInt(projectApply.get("submit_status").toString());
			if(submitStatus>5){
				ParaUtils.addMsg(this, "对不起，该项目不能发布");
				release();
			}
			Date now=new Date();
			SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			String endDate=getPara("enddate_id")+":00";
			Date d=null;;
			try {
				d = sim.parse(endDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(now.compareTo(d)>0)
			{
				ParaUtils.addMsg(this, "项目发布失败，当前时间大于学生报名截止时间！");
				release();
			}
			String schoolsList=getAttr("schoolList");
			String[] schoolsArray=schoolsList.split(",");
			Db.update("update feedback_table set assigned=?,assigned_person=?,assigned_date=?,apply_deadline=? where project_id=? and highschool_id=?",1,userId,new Date(),getPara("enddate_id"),getPara("projectadd_id"),schoolsArray[0]);
			Db.update("update project_apply set is_publish=?,submit_status=?,publish_date=? where project_id=?",1,5,new Date(),getPara("projectadd_id"));
			ParaUtils.addMsg(this, "项目发布成功");
			release();
		}
	}

	/**
	 * *学生报名
	 */
	public void signup() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select batch_id from students_apply_table where user_id='"+userId+"') or batch_status=1 order by b.batch_status desc,b.batch_id desc");
		List subjectCategoryList=Db.find("select subject_cat_id,subject_name from subject_category where subject_cat_id in (select pa.subject_cat_id from students_apply_table sa left join project_apply pa on sa.project_id=pa.project_id where sa.user_id='"+userId+"')");
		StringBuffer from = new StringBuffer();
		from.append("from students_apply_table sa left join team_table tt on sa.project_id=tt.project_id left join feedback_table ft on sa.project_id=ft.project_id left join project_apply pa on sa.project_id=pa.project_id left join batch b on pa.batch_id=b.batch_id left join schools sch on pa.school_id=sch.school_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where sa.user_id='"+userId+"' and ft.assigned=1");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and sa.batch_id = ?");
		}
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addParam("subjectCatId", params, this)) {
			from.append(" and pa.subject_cat_id = ?");
		}
		//默认加载当前状态的申报项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			if(batch!=null){
				from.append(" and sa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		setAttr("batchList", batchList);
		setAttr("subjectCategoryList", subjectCategoryList);
		List<Record> list=pages("select * ", from.toString(), params.toArray());
		render(view("signup.jsp"));
	}

	/**
	 * *学生新增报名的加载
	 */
	public void txSignupAddInitialize() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学学生隶属的学校ID
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch==null){
			ParaUtils.addMsg(this, "当前不存在批次，请联系创新管理员");
			signup();
		}else{
			List<Record> feedbackList=Db.find("select * from feedback_table where batch_id=? and highschool_id=? and assigned=?",batch.get("batch_id"),highSchoolId,1);
			if(feedbackList.size()==0){
				ParaUtils.addMsg(this, "对不起，您不能进行项目报名");
				signup();
			}else{
				Schools school=getModel(Schools.class).findById(user.get("school_id"));   //中学生的学校
				Grade grade=getModel(Grade.class).findById(user.get("grade_id"));
				Classes classes=getModel(Classes.class).findById(user.get("class_id"));
				DetailInformationApply detailInformation=getModel(DetailInformationApply.class).findById(userId);
				setAttr("user", user);
				setAttr("grade",grade);
				setAttr("classes",classes);
				setAttr("school", school);
				setAttr("detailInformation", detailInformation);
				render(view("add_studentinfo.jsp"));
			}
		}
	}

	/**
	 * *学生修改个人信息
	 */
	public void txSignupStudentSave() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Db.update("update users set mobile=?,qq=?,wechat=? where user_id=?",getPara("mobile"),getPara("qq"),getPara("wechat"),userId);
		DetailInformationApply detailInformation=getModel(DetailInformationApply.class).findById(userId);
		String[] attach_files=getParaValues("attach_file");
		if(detailInformation==null){
			Db.update("insert into detail_information_apply value (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", userId,getPara("post"),getPara("f_name"),getPara("f_unit"),getPara("f_qualification_major"),getPara("f_title"),
					getPara("f_number"),getPara("f_business"),getPara("m_name"),getPara("m_unit"),getPara("m_qualification_major"),getPara("m_title"),getPara("m_number"),getPara("m_business"),
					getPara("address"),getPara("interest"),getPara("t_name"),getPara("t_subject"),getPara("t_number"),getPara("s_introduce"),getPara("s_plan"),attach_files[0]);
		}else{
			Db.update("update detail_information_apply set post=?,f_name=?,f_unit=?,f_qualification_major=?,f_title=?,f_number=?,f_business=?,m_name=?,m_unit=?,m_qualification_major=?,m_title=?,m_number=?,m_business=?,"
					+ "address=?,interest=?,t_name=?,t_subject=?,t_number=?,s_introduce=?,s_plan=?,proof_path=? where user_id=?", getPara("post"),getPara("f_name"),getPara("f_unit"),getPara("f_qualification_major"),getPara("f_title"),
					getPara("f_number"),getPara("f_business"),getPara("m_name"),getPara("m_unit"),getPara("m_qualification_major"),getPara("m_title"),getPara("m_number"),getPara("m_business"),
					getPara("address"),getPara("interest"),getPara("t_name"),getPara("t_subject"),getPara("t_number"),getPara("s_introduce"),getPara("s_plan"),attach_files[0],userId);
		}
		txSignupStudentNext();
	}

	/**
	 * *加载可以报名的项目
	 */
	public void txSignupStudentNext() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学学生隶属的学校ID
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			List schoolList=Db.find("select school_id,school_name from schools where school_id in (select pa.school_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.batch_id="+batch.get("batch_id")+" "
					+ "and ft.highschool_id='"+highSchoolId+"' and ft.project_id not in (select project_id from students_apply_table where user_id='"+userId+"' and batch_id="+batch.get("batch_id")+"))");
			List subjectCategoryList=Db.find("select subject_cat_id,subject_name from subject_category where subject_cat_id in (select pa.subject_cat_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and pa.batch_id="+batch.get("batch_id")+" "
					+ "and ft.highschool_id='"+highSchoolId+"' and ft.project_id not in (select project_id from students_apply_table where user_id='"+userId+"' and batch_id="+batch.get("batch_id")+"))");
			StringBuffer from = new StringBuffer();
			from.append("from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id  left join schools sch on pa.school_id=sch.school_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where ft.assigned=1 and pa.batch_id="+batch.get("batch_id")+" "
					+ "and ft.highschool_id='"+highSchoolId+"' and ft.project_id not in (select project_id from students_apply_table where user_id='"+userId+"' and batch_id="+batch.get("batch_id")+")");
			List<String> params = new ArrayList<String>();
			if (!ParaUtils.addLikeParam("projectName", params, this)) {
				from.append(" and pa.project_name like ?");
			}
			if (!ParaUtils.addParam("schoolId", params, this)) {
				from.append(" and pa.school_id = ?");
			}
			if (!ParaUtils.addParam("subjectCatId", params, this)) {
				from.append(" and pa.subject_cat_id = ?");
			}
			setAttr("schoolList", schoolList);
			setAttr("subjectCategoryList", subjectCategoryList);
			List<Record> list=pages("select * ", from.toString(), params.toArray());
			render(view("signup_add.jsp"));
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行学生报名！");
			signup();
		}
	}

	/**
	 * *学生新增报名
	 */
	public void txSignupAdd() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		String projectList=getAttr("projectList");
		String[] projectArray=projectList.split(",");
		if(batch!=null){
			Users user=getModel(Users.class).findById(userId);
			String highSchoolId=user.get("school_id").toString();   //中学学生隶属的学校ID
			//检测一位中学生同一批次最多申报两个项目
			List<Record> studentApply=Db.find("select * from students_apply_table where user_id=? and batch_id=?",userId,batch.get("batch_id"));
			if(studentApply.size()+projectArray.length>2){
				ParaUtils.addMsg(this, "报名失败，同一批次最多申报两个项目");
			}else{
				int status=0;
				for(int i=0;i<projectArray.length;i++){
					Record feedback=Db.findFirst("select * from feedback_table where project_id=? and highschool_id=? and assigned=?",projectArray[i],highSchoolId,1);
					Date now=new Date();
					Date signupEndDate=feedback.getTimestamp("apply_deadline");   //学生报名截止日期
					if(now.compareTo(signupEndDate)>0)
					{
						status=1;
						break;
					}
				}
				if(status==0){
					for(int i=0;i<projectArray.length;i++){
						Db.update("insert into students_apply_table value(?,?,?,?)",userId,batch.get("batch_id"),projectArray[i],new Date());
					}
					ParaUtils.addMsg(this, "报名成功");
				}else{
					ParaUtils.addMsg(this, "当前时间大于报名截止时间，不能再进行报名");
				}
			}
			signup();
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行学生报名！");
			signup();
		}
	}

	/**
	 * 上传文件
	 */
	public void uploadSignup() {
		UploadFile uf = getFile();
		String ext = uf.getFileName().substring(
				uf.getFileName().lastIndexOf(".") + 1);
		ext = "." + ext;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String fileName = sdf.format(new Date()) + ext;
		String path = FileUtils.getWebInfPath() +CONST.SIGNUP_PATH;
		File file = new File(path);
		//判断是否存在该文件夹，如果不存在则创建
		if(!file.exists()) {
			file.mkdir();
		}
		FileUtils.copyFile(uf.getFile().getAbsolutePath(), path, fileName);
		FileUtils.deleteFile(uf.getFile().getAbsolutePath());
		renderJson(fileName);
	}

	public void signupDownLoad() {
		String docId = getPara("attach_file");
		try {
			File f = new File(FileUtils.getWebInfPath() +CONST.SIGNUP_PATH+docId);
			if(!f.isFile()){
				msgOperateError();
			}
			else renderFile(f);
		} catch (Exception e) {
			msgOperateError();
		}
	}

	/**
	 * *学生取消报名
	 */
	public void txSignupDel() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学学生隶属的学校ID
		Record feedback=Db.findFirst("select * from feedback_table where project_id=? and highschool_id=? and assigned=?",getPara("project_id"),highSchoolId,1);
		if(feedback==null){
			ParaUtils.addMsg(this, "对不起，取消报名失败");
			signup();
		}else{
			Date now=new Date();
			Date signupEndDate=feedback.getTimestamp("apply_deadline");   //学生报名截止日期
			if(now.compareTo(signupEndDate)>0)
			{
				ParaUtils.addMsg(this, "当前时间大于报名截止时间，不能进行取消报名");
				signup();
			}else{
				//检测是否已经组队
				Record record=Db.findFirst("select * from team_detail_table td left join team_table tt on td.team_id=tt.team_id where tt.project_id=? and td.user_id=?",getPara("project_id"),userId);
				if(record!=null){
					//已经组队
					ParaUtils.addMsg(this, "当前学校已经组队，不能进行取消报名");
					signup();
				}else{
					Db.update("delete from students_apply_table where user_id=? and project_id=?",userId,getPara("project_id"));
					ParaUtils.addMsg(this, "取消报名成功");
					signup();
				}						
			}
		}
	}

	/**
	 * 学生查看项目详情及老师信息
	 */
	public void txSignupView(){
		String projectId=getAttr("project_id");
		Record projectApply=(Record)Db.find("select * from project_apply pa left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join schools s on pa.school_id=s.school_id where pa.project_id=?",projectId).get(0);
		Users user=getModel(Users.class).findById(projectApply.get("user_id"));
		setAttr("projectApply", projectApply);
		setAttr("user", user);
		render(view("view_signup.jsp"));
	}

	/**
	 * 学生添加报名时查看项目详情及老师信息
	 */
	public void txSignupAddView(){
		String projectId=getAttr("project_id");
		Record projectApply=(Record)Db.find("select * from project_apply pa left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join schools s on pa.school_id=s.school_id where pa.project_id=?",projectId).get(0);
		Users user=getModel(Users.class).findById(projectApply.get("user_id"));
		setAttr("projectApply", projectApply);
		setAttr("user", user);
		render(view("view_signupadd.jsp"));
	}

	/**
	 * *项目组队报名  只有中学管理员才有的功能
	 */
	public void team() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学管理员隶属的学校ID
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		List batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select b.batch_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and ft.highschool_id='"+highSchoolId+"' ) or batch_status=1 order by b.batch_status desc,b.batch_id desc");
		List schoolList=Db.find("select school_id,school_name from schools where school_id in (select pa.school_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and ft.highschool_id='"+highSchoolId+"')");
		List subjectCategoryList=Db.find("select subject_cat_id,subject_name from subject_category where subject_cat_id in (select pa.subject_cat_id from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id where ft.assigned=1 and ft.highschool_id='"+highSchoolId+"')");
		StringBuffer from = new StringBuffer();
		from.append("from feedback_table ft left join project_apply pa on ft.project_id=pa.project_id left join batch b on pa.batch_id=b.batch_id left join schools sch on pa.school_id=sch.school_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join team_table tt on ft.project_id=tt.project_id where ft.assigned=1 and ft.highschool_id='"+highSchoolId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pa.batch_id = ?");
		}
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addParam("schoolId", params, this)) {
			from.append(" and pa.school_id = ?");
		}
		if (!ParaUtils.addParam("subjectCatId", params, this)) {
			from.append(" and pa.subject_cat_id = ?");
		}
		//默认加载当前状态的申报项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			if(batch!=null){
				from.append(" and pa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		setAttr("subjectCategoryList", subjectCategoryList);
		setAttr("batchList", batchList);
		setAttr("schoolList", schoolList);
		List<Record> list=pages("select *,pa.project_id as paproject_id", from.toString(), params.toArray());
		render(view("team.jsp"));
	}

	/**
	 * 组队报名时查看项目详情及老师信息
	 */
	public void txTeamView(){
		String projectId=getAttr("project_id");
		Record projectApply=Db.findFirst("select * from project_apply pa left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join schools s on pa.school_id=s.school_id where pa.project_id=?",projectId);
		Users user=getModel(Users.class).findById(projectApply.get("user_id"));
		setAttr("projectApply", projectApply);
		setAttr("user", user);
		render(view("view_team.jsp"));
	}

	/**
	 * 组队按钮时新建组队或者直接显示已有的组队
	 */
	public void txTeamAddTeamInit(){
		String projectId=getAttr("project_id");
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学管理员隶属的学校ID
		List<Record> teacherList=Db.find("select * from users u left join user_role ur on u.user_id=ur.user_id where u.school_id=? and (ur.role_id=? or ur.role_id=?)",highSchoolId,1,2);
		Record projectApply=Db.findFirst("select * from project_apply pa left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where pa.project_id=?",projectId);
		setAttr("teacherList", teacherList);
		setAttr("projectApply", projectApply);
		setAttr("projectId", projectId);
		setAttr("teamTable", teamTable);
		render(view("team_addteam.jsp"));
	}

	/**
	 * 组队按钮时新建组队的添加操作
	 */
	public void txTeamAddTeam(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		ProjectApply projectApply=getModel(ProjectApply.class).findById(getPara("project_id"));
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			List<Record> teacherTeamList=Db.find("select * from team_table where batch_id=? and user_id=?",batch.get("batch_id"),getPara("teacherId"));
			if(teacherTeamList.size()>=3){
				ParaUtils.addMsg(this, "该指导老师担任的项目过多，请重新分配");
				txTeamAddTeamInit();
			}else{
				Record teamTable=Db.findFirst("select * from team_table where project_id=?",getPara("project_id"));
				if(teamTable==null)
				{
					TeamTable tt=new TeamTable();
					tt.set("batch_id", projectApply.get("batch_id"));
					tt.set("user_id", getPara("teacherId"));
					tt.set("team_status", 0);
					save(tt);
				}else{
					Db.update("update team_table set user_id=?,opt_date=?,opt_person=?,team_status=0,remark1=?,remark2=?",getPara("teacherId"),new Date(),userId,null,null);
				}
				txTeamAddInitialize();
			}
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能进行组队报名！");
			team();
		}
	}

	/**
	 * 组队的成员情况加载
	 */
	public void txTeamAddInitialize(){
		String projectId=getAttr("project_id");
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join batch b on pa.batch_id=b.batch_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where pa.project_id=?",projectId);
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		Users teacher=getModel(Users.class).findById(teamTable.get("user_id"));
		StringBuffer from = new StringBuffer();
		List<String> params = new ArrayList<String>();
		from.append("from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id where tt.project_id='"+projectId+"'");
		if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
			from.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("stuName", params, this)) {
			from.append(" and u.name like ?");
		}
		List<Record> list=pages("select *", from.toString(), params.toArray());
		setAttr("projectApply", projectApply);
		setAttr("teacher", teacher);
		setAttr("projectId", projectId);
		render(view("team_addinit.jsp"));
	}

	/**
	 * 组队学生信息详情，暂时不做，
	 */
	public void txTeamStudentView(){
		String user_id=getAttr("user_id");
		String projectId=getAttr("project_id");
		Users user = getModel(Users.class).getUserByUserId(user_id);
		Record userInfo = Db.findFirst("select *,u.remark as uremark from users u left join schools sch on u.school_id=sch.school_id left join grade g on u.grade_id=g.grade_id"
				+ " left join class c on u.class_id=c.class_id where u.user_id = ?", user_id);
		setAttr("userInfo", userInfo);
		setAttr("projectId", projectId);
		render(view("view_junior_student.jsp"));
	}

	/**
	 * 组队学生移除
	 */
	public void txTeamStudentDel(){
		String userId=getAttr("user_id");
		String projectId=getAttr("project_id");
		String teamId=getAttr("team_id");
		Db.update("delete from team_detail_table where team_id=? and user_id=?",teamId,userId);
		setAttr("project_id",projectId);
		ParaUtils.addMsg(this, "移除学生成功");
		txTeamAddInitialize();
	}

	/**
	 * 组队时添加申报的学生加载
	 */
	public void txAddApplyStudentInitialize(){
		String projectId=getAttr("project_id");
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		StringBuffer from = new StringBuffer();
		from.append("from students_apply_table sa left join users u on sa.user_id=u.user_id where sa.project_id='"+getPara("project_id")+"' and sa.user_id not in (select td.user_id from team_detail_table td left join team_table tt on td.team_id=tt.team_id where tt.batch_id='"+batch.get("batch_id")+"')");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
			from.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("stuName", params, this)) {
			from.append(" and u.name like ?");
		}
		List<Record> list=pages("select *", from.toString(), params.toArray());
		setAttr("projectId",projectId);
		render(view("team_add_apply_student.jsp"));
	}

	/**
	 * 组队是添加申报的学生
	 */
	public void txAddApplyStudent(){
		String stuList=getAttr("stuList");
		String projectId=getPara("paproject_id");
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		String[] stuArray=stuList.split(",");
		for(int i=0;i<stuArray.length;i++){
			Db.update("insert into team_detail_table value(?,?,?)",teamTable.get("team_id"),stuArray[i],0);
		}
		ParaUtils.addMsg(this, "添加成功");
		setAttr("project_id", projectId);
		txTeamAddInitialize();
	}

	/**
	 * 组队时添加其他的学生加载
	 */
	public void txAddOtherStudentInitialize(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Users user=getModel(Users.class).findById(userId);
		String highSchoolId=user.get("school_id").toString();   //中学管理员隶属的学校ID
		String projectId=getAttr("project_id");
		StringBuffer from = new StringBuffer();
		Batch batch=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		if(batch!=null){
			from.append("from students_apply_table sa left join feedback_table ft on sa.project_id=ft.project_id left join users u on sa.user_id=u.user_id where sa.batch_id='"+batch.get("batch_id")+"' and ft.highschool_id='"+highSchoolId+"' and sa.project_id!='"+projectId+"' and sa.user_id not in (select td.user_id from team_detail_table td left join team_table tt on td.team_id=tt.team_id where tt.batch_id='"+batch.get("batch_id")+"')");
			List<String> params = new ArrayList<String>();
			if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
				from.append(" and u.user_name like ?");
			}
			if (!ParaUtils.addLikeParam("stuName", params, this)) {
				from.append(" and u.name like ?");
			}
			List<Record> list=pages("select *", from.toString(), params.toArray());
			setAttr("projectId",projectId);
			render(view("team_add_other_student.jsp"));
		}else{
			ParaUtils.addMsg(this, "没有当前批次，不能添加其他学生！");
			setAttr("project_id", projectId);
			txTeamAddInitialize();
		}
	}

	/**
	 * 组队时添加其他的学生
	 */
	public void txAddOtherStudent(){
		String stuList=getAttr("stuList");
		String projectId=getPara("paproject_id");
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		String[] stuArray=stuList.split(",");
		for(int i=0;i<stuArray.length;i++){
			Db.update("insert into team_detail_table value(?,?,?)",teamTable.get("team_id"),stuArray[i],1);
		}
		ParaUtils.addMsg(this, "添加成功");
		setAttr("project_id", projectId);
		txTeamAddInitialize();
	}

	/**
	 * 组队详情
	 */
	public void txTeamDetailView(){
		String projectId=getAttr("project_id");
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		Users teacher=getModel(Users.class).findById(teamTable.get("user_id"));
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join batch b on pa.batch_id=b.batch_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where pa.project_id=?",projectId);
		StringBuffer from = new StringBuffer();
		from.append("from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id where tt.project_id='"+projectId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
			from.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("stuName", params, this)) {
			from.append(" and u.name like ?");
		}
		List<Record> list=pages("select *", from.toString(), params.toArray());
		setAttr("projectApply", projectApply);
		setAttr("teacher", teacher);
		setAttr("projectId", projectId);
		setAttr("teamTable", teamTable);
		render(view("view_teamdetail.jsp"));  
	}

	/**
	 * 获取申报项目列表
	 */
	public void teamCheck() {
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		Long role=getModel(Users.class).getBigRole(userId);
		List batchList=null;
		List schooList=null;
		List highSchooList=null;
		List subjectList=null;
		Batch batchNow=getModel(Batch.class).findFirst("select * from batch b where b.batch_status=1");   //当前批次
		StringBuffer from = new StringBuffer();
		from.append("from project_apply pa join feedback_table ft on pa.project_id=ft.project_id left join schools highsch on ft.highschool_id=highsch.school_id join team_table tt on pa.project_id=tt.project_id left join schools sch on pa.school_id=sch.school_id left join subject_category sc on pa.subject_cat_id= sc.subject_cat_id left join batch b on pa.batch_id=b.batch_id  where ft.assigned=1");
		if(role==6){
			//创新学院管理员，可以查看所有申报项目
			batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select tt.batch_id from team_table tt) or b.batch_status=1 order by b.batch_status desc,b.batch_id desc");
			schooList=Db.find("select school_id,school_name from schools where school_id in (select pa.school_id from project_apply pa join team_table tt on pa.project_id=tt.project_id)");
			highSchooList=Db.find("select school_id,school_name from schools where school_id in (select ft.highschool_id from feedback_table ft join team_table tt on ft.project_id=tt.project_id where ft.assigned=1)");
			subjectList=Db.find("select subject_cat_id,subject_name from subject_category where subject_cat_id in (select pa.subject_cat_id from project_apply pa join team_table tt on pa.project_id=tt.project_id)");

		}else{
			//高校管理员，只能查看自己学校的
			Users r=getModel(Users.class).getUserByUserId(userId);
			from.append(" and pa.user_id in (select user_id from users where school_id="+r.get("school_id")+")");
			batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pa.batch_id from project_apply pa join team_table tt on pa.project_id=tt.project_id where pa.user_id in (select u.user_id from users u where u.school_id="+r.get("school_id")+")) or b.batch_status=1  order by b.batch_status desc,b.batch_id desc");
			subjectList=Db.find("select subject_cat_id,subject_name from subject_category where subject_cat_id in (select pa.subject_cat_id from project_apply pa join team_table tt on pa.project_id=tt.project_id where pa.user_id in (select u.user_id from users u where u.school_id="+r.get("school_id")+"))");
			schooList=Db.find("select school_id,school_name from schools where school_id=?",r.get("school_id"));
			highSchooList=Db.find("select school_id,school_name from schools where school_id in (select ft.highschool_id from project_apply pa join feedback_table ft on pa.project_id=ft.project_id join team_table tt on pa.project_id=tt.project_id where ft.assigned=1 and pa.user_id in (select u.user_id from users u where u.school_id="+r.get("school_id")+"))");			
		}
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addParam("batchId", params, this)) {
			from.append(" and pa.batch_id = ?");
		}
		if (!ParaUtils.addLikeParam("projectName", params, this)) {
			from.append(" and pa.project_name like ?");
		}
		if (!ParaUtils.addParam("schoolId", params, this)) {
			from.append(" and pa.school_id = ?");
		}
		if (!ParaUtils.addParam("subjectCatId", params, this)) {
			from.append(" and pa.subject_cat_id = ?");
		}
		if (!ParaUtils.addLikeParam("leaderName", params, this)) {
			from.append(" and pa.leader_name like ?");
		}
		if (!ParaUtils.addParam("highSchoolId", params, this)) {
			from.append(" and ft.highschool_id = ?");
		}
		if (!ParaUtils.addParam("teamStatus", params, this)) {
			from.append(" and tt.team_status = ?");
		}
		//默认加载当前状态的申报项目
		if(getAttr("batchId")==null||getAttr("batchId").equals("")){
			Batch batch=getModel(Batch.class).getCurBatch();
			if(batch!=null){
				from.append(" and pa.batch_id ="+batch.get("batch_id"));
				setAttr("batchId",batch.get("batch_id"));
			}else{
				setAttr("batchId",-1);
			}
		}
		setAttr("batchList", batchList);
		setAttr("subjectList", subjectList);
		setAttr("schooList", schooList);
		setAttr("highSchooList", highSchooList);
		setAttr("role", role);
		setAttr("batchNow", batchNow);
		from.append(" order by pa.submit_time desc");
		List<Record> list=pages("select b.batch_id,b.batch_name,pa.project_id,pa.project_name,pa.submit_status,sc.subject_name,sch.school_name,pa.leader_name,highsch.school_name as highschool_name,tt.team_status ", from.toString(), params.toArray());
		render(view("teamcheck.jsp"));
	}

	/**
	 * 组队详情
	 */
	public void txTeamCheckDetailView(){
		String projectId=getAttr("project_id");
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		Users teacher=getModel(Users.class).findById(teamTable.get("user_id"));
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join batch b on pa.batch_id=b.batch_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where pa.project_id=?",projectId);
		StringBuffer from = new StringBuffer();
		from.append("from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id where tt.project_id='"+projectId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
			from.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("stuName", params, this)) {
			from.append(" and u.name like ?");
		}
		List<Record> list=pages("select *", from.toString(), params.toArray());
		setAttr("projectApply", projectApply);
		setAttr("teacher", teacher);
		setAttr("projectId", projectId);
		setAttr("teamTable", teamTable);
		render(view("view_teamcheckdetail.jsp"));  
	}

	public void txTeamCheck1(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		String projectId=getAttr("project_id");
		Long role=getModel(Users.class).getBigRole(userId);
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",getPara("project_id"));
		Users teacher=getModel(Users.class).findById(teamTable.get("user_id"));
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join batch b on pa.batch_id=b.batch_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where pa.project_id=?",projectId);
		StringBuffer from = new StringBuffer();
		from.append("from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id where tt.project_id='"+projectId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
			from.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("stuName", params, this)) {
			from.append(" and u.name like ?");
		}
		List<Record> list=pages("select *", from.toString(), params.toArray());
		setAttr("projectApply", projectApply);
		setAttr("teacher", teacher);
		String status=getPara("status");
		setAttr("role", role);
		setAttr("status", status);
		setAttr("teamTable", teamTable);
		setAttr("projectId", projectId);
		render(view("view_teamcheck1.jsp"));  
	}

	public void txTeamCheck2(){
		String userId=getSessionAttr(CONST.SESSION_USER_ID);
		String projectId=getAttr("project_id");
		Long role=getModel(Users.class).getBigRole(userId);
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",getPara("project_id"));
		Users teacher=getModel(Users.class).findById(teamTable.get("user_id"));
		Record projectApply=(Record)Db.findFirst("select * from project_apply pa left join batch b on pa.batch_id=b.batch_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id where pa.project_id=?",projectId);
		StringBuffer from = new StringBuffer();
		from.append("from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id where tt.project_id='"+projectId+"'");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("stuUserName", params, this)) {
			from.append(" and u.user_name like ?");
		}
		if (!ParaUtils.addLikeParam("stuName", params, this)) {
			from.append(" and u.name like ?");
		}
		List<Record> list=pages("select *", from.toString(), params.toArray());
		setAttr("projectApply", projectApply);
		setAttr("teacher", teacher);
		String status=getPara("status");
		setAttr("role", role);
		setAttr("status", status);
		setAttr("teamTable", teamTable);
		setAttr("projectId", projectId);
		render(view("view_teamcheck2.jsp"));  
	}
	
	/**
	 * 组队审核学生信息详情，暂时不做，
	 */
	public void txTeamCheckStudentView1(){
		String user_id=getAttr("user_id");
		String projectId=getAttr("project_id");
		Users user = getModel(Users.class).getUserByUserId(user_id);
		int userType=user.getInt("user_type");
		Record userInfo = Db.findFirst("select *,u.remark as uremark from users u left join schools sch on u.school_id=sch.school_id left join grade g on u.grade_id=g.grade_id"
				+ " left join class c on u.class_id=c.class_id where u.user_id = ?", user_id);
		setAttr("userInfo", userInfo);
		setAttr("projectId", projectId);
		render(view("view_check_junior_student1.jsp"));
	}
	
	/**
	 * 组队审核学生信息详情，暂时不做，
	 */
	public void txTeamCheckStudentView2(){
		String user_id=getAttr("user_id");
		String projectId=getAttr("project_id");
		Users user = getModel(Users.class).getUserByUserId(user_id);
		int userType=user.getInt("user_type");
		Record userInfo = Db.findFirst("select *,u.remark as uremark from users u left join schools sch on u.school_id=sch.school_id left join grade g on u.grade_id=g.grade_id"
				+ " left join class c on u.class_id=c.class_id where u.user_id = ?", user_id);
		setAttr("userInfo", userInfo);
		setAttr("projectId", projectId);
		render(view("view_check_junior_student2.jsp"));
	}

	/**
	 * 组队审核
	 */

	public void txTeamJudge1() {
		int teamStatus = Integer.parseInt(getPara("team_status"));  //组队审核状态
		//初审
		String remark1=getPara("remark1");
		Db.update("update team_table set team_status=?,remark1=? where team_id=?", teamStatus,remark1,getPara("team_id"));
		ParaUtils.addMsg(this, "组队初审完成！");
		teamCheck();

	}

	/**
	 * 组队审核
	 */

	public void txTeamJudge2() {
		int teamStatus = Integer.parseInt(getPara("team_status"));  //组队审核状态
		//复审
		String remark2=getPara("remark2");
		Db.update("update team_table set team_status=?,remark2=? where team_id=?", teamStatus,remark2,getPara("team_id"));
		ParaUtils.addMsg(this, "组队复审完成！");
		teamCheck();
	}

	/**
	 * 创新学院的人正式发布项目
	 */
	public void txProjectRelease(){
		String projectId=getPara("project_id");
		Record teamTable=Db.findFirst("select * from team_table where project_id=?",projectId);
		if(Integer.parseInt(teamTable.get("team_status").toString())!=4){
			ParaUtils.addMsg(this, "该项目发布失败，存在组队报名为审核，请审核后再发布");
		}else{
			Db.update("update project_apply set submit_status=? where project_id=?",8,projectId);
			ParaUtils.addMsg(this, "项目发布成功");
		}
		teamCheck();
	}

	public void txProjectImportStudent(){
		//导出某一个项目的学生名单
		String projectId=getPara("project_id");
		Record projectApply=(Record)Db.findFirst("select *, sch.school_name as college_name from project_apply pa left join batch b on pa.batch_id=b.batch_id left join schools sch on pa.school_id=sch.school_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join team_table tt on pa.project_id=tt.project_id left join users u on"
				+ " tt.user_id=u.user_id left join schools highsch on u.school_id=highsch.school_id where pa.project_id=?",projectId);
		List<Record> list=Db.find("select * from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id left join grade g on u.grade_id=g.grade_id left join class c on u.class_id=c.class_id where tt.project_id=?",projectId);
		HSSFWorkbook excel = new HSSFWorkbook();
		// 创建HSSFSheet对象(操纵Sheet）
		HSSFSheet sheet = excel.createSheet("Sheet1");
		// 创建HSSFRow对象(操纵行)
		HSSFRow row[] = new HSSFRow[list.size()+1];
		for (int i = 0; i < row.length; ++i) {
			row[i] = sheet.createRow(i);
			row[i].setHeight((short) (370));
		}
		HSSFCell cell[] = new HSSFCell[10];
		for(int j=0;j<cell.length;j++){
			cell[j]=row[0].createCell(j);
		}
		cell[0].setCellValue("项目名称");
		cell[1].setCellValue("承担高校");
		cell[2].setCellValue("项目负责人");
		cell[3].setCellValue("中学名称");
		cell[4].setCellValue("中学指导老师");
		cell[5].setCellValue("学生用户名");
		cell[6].setCellValue("学生姓名");
		cell[7].setCellValue("学生性别");
		cell[8].setCellValue("学生年级");
		cell[9].setCellValue("学生班级");
		//填充数据
		for (int i = 1; i < row.length; ++i) {
			HSSFCell cell1[] = new HSSFCell[10];
			for(int j=0;j<cell1.length;j++){
				cell1[j]=row[i].createCell(j);
			}
			cell1[0].setCellValue(projectApply.get("project_name").toString());
			cell1[1].setCellValue(projectApply.get("college_name").toString());
			cell1[2].setCellValue(projectApply.get("leader_name").toString());
			cell1[3].setCellValue(projectApply.get("school_name").toString());
			cell1[4].setCellValue(projectApply.get("name").toString());
			cell1[5].setCellValue(list.get(i-1).get("user_name").toString());
			cell1[6].setCellValue(list.get(i-1).get("name").toString());
			if(list.get(i-1).get("sex").toString().equals("0")){
				cell1[7].setCellValue("女");
			}else{
				cell1[7].setCellValue("男");
			}
			cell1[8].setCellValue(list.get(i-1).get("grade_name").toString());
			cell1[9].setCellValue(list.get(i-1).get("class_name").toString());
		}
		/**
		 * 输出Excel
		 */
		OutputStream output=null;
		try {
			output = getResponse().getOutputStream();
		} catch (IOException e3) {
			// TODO Auto-generated catch block
			e3.printStackTrace();
		}
		getResponse().reset();
		// getResponse().setHeader("Content-disposition", "attachment;
		// filename=details.xls");
		String fileName=null;
		try {
			fileName = new String(
					("" + projectApply.get("batch_name") + "批次_" + projectApply.get("project_name") + "项目的学生名单").getBytes("gb2312"),
					"iso8859-1");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		getResponse().setHeader("Content-disposition", "attachment; filename=" + fileName + ".xls");
		getResponse().setContentType("application/msexcel");
		try {
			excel.write(output);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			output.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			output.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;  
	}

	/**
	 * 批次导出学生名单的加载
	 */
	public void txImportBatchInitialize(){
		List batchList=null;
		batchList=Db.find("select b.batch_id,b.batch_name from batch b where b.batch_id in (select pa.batch_id from project_apply pa join team_table tt on pa.project_id=tt.project_id where pa.submit_status=8) order by b.batch_status desc,b.batch_id desc");
		setAttr("batchList", batchList);
		render(view("view_teambatchimport.jsp"));  
	}

	public void txProjectImportAllStudent(){
		//导出某一个批次下的所有学生名单
		HSSFWorkbook excel = new HSSFWorkbook();
		// 创建HSSFSheet对象(操纵Sheet）
		HSSFSheet sheet = excel.createSheet("Sheet1");
		Batch b=getModel(Batch.class).findById(getPara("batchId"));
		int n=0;
		List<Record> projectList=Db.find("select * from project_apply pa join team_table tt on pa.project_id=tt.project_id where pa.submit_status=8 and pa.batch_id=?",getPara("batchId"));
		for(int i=0;i<projectList.size();i++){
			String projectId=projectList.get(i).get("project_id").toString();
			List<Record> list2=Db.find("select * from team_detail_table td left join team_table tt on td.team_id=tt.team_id where tt.project_id=?",projectId);
			n+=list2.size();
		}
		// 创建HSSFRow对象(操纵行)
		HSSFRow row[]=new HSSFRow[n+1];
		for (int i = 0; i < row.length; ++i) {
			row[i] = sheet.createRow(i);
			row[i].setHeight((short) (370));
		}
		HSSFCell cell[] = new HSSFCell[10];
		for(int j=0;j<cell.length;j++){
			cell[j]=row[0].createCell(j);
		}
		cell[0].setCellValue("项目名称");
		cell[1].setCellValue("承担高校");
		cell[2].setCellValue("项目负责人");
		cell[3].setCellValue("中学名称");
		cell[4].setCellValue("中学指导老师");
		cell[5].setCellValue("学生用户名");
		cell[6].setCellValue("学生姓名");
		cell[7].setCellValue("学生性别");
		cell[8].setCellValue("学生年级");
		cell[9].setCellValue("学生班级");
		int k=1;
		for(int i=0;i<projectList.size();i++){
			String projectId=projectList.get(i).get("project_id").toString();
			Record projectApply=(Record)Db.findFirst("select *, sch.school_name as college_name from project_apply pa left join batch b on pa.batch_id=b.batch_id left join schools sch on pa.school_id=sch.school_id left join subject_category sc on pa.subject_cat_id=sc.subject_cat_id left join team_table tt on pa.project_id=tt.project_id left join users u on"
					+ " tt.user_id=u.user_id left join schools highsch on u.school_id=highsch.school_id where pa.project_id=?",projectId);
			List<Record> list=Db.find("select * from team_detail_table td left join team_table tt on td.team_id=tt.team_id left join users u on td.user_id=u.user_id left join grade g on u.grade_id=g.grade_id left join class c on u.class_id=c.class_id where tt.project_id=?",projectId);
			//填充数据
			for (int i2 = k; i2 < k+list.size(); ++i2) {
				HSSFCell cell1[] = new HSSFCell[10];
				for(int j=0;j<cell1.length;j++){
					cell1[j]=row[i2].createCell(j);
				}
				cell1[0].setCellValue(projectApply.get("project_name").toString());
				cell1[1].setCellValue(projectApply.get("college_name").toString());
				cell1[2].setCellValue(projectApply.get("leader_name").toString());
				cell1[3].setCellValue(projectApply.get("school_name").toString());
				cell1[4].setCellValue(projectApply.get("name").toString());
				cell1[5].setCellValue(list.get(i2-k).get("user_name").toString());
				cell1[6].setCellValue(list.get(i2-k).get("name").toString());
				if(list.get(i2-k).get("sex").toString().equals("0")){
					cell1[7].setCellValue("女");
				}else{
					cell1[7].setCellValue("男");
				}
				cell1[8].setCellValue(list.get(i2-k).get("grade_name").toString());
				cell1[9].setCellValue(list.get(i2-k).get("class_name").toString());
			}
			k+=row.length;			
		}
		/**
		 * 输出Excel
		 */
		OutputStream output=null;
		try {
			output = getResponse().getOutputStream();
		} catch (IOException e3) {
			// TODO Auto-generated catch block
			e3.printStackTrace();
		}
		getResponse().reset();
		// getResponse().setHeader("Content-disposition", "attachment;
		// filename=details.xls");
		String fileName=null;
		try {
			fileName = new String(
					("" + b.get("batch_name") + "批次下所有项目的学生名单").getBytes("gb2312"),
					"iso8859-1");
		} catch (UnsupportedEncodingException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		getResponse().setHeader("Content-disposition", "attachment; filename=" + fileName + ".xls");
		getResponse().setContentType("application/msexcel");
		try {
			excel.write(output);
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			output.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			output.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;			
	}
}




