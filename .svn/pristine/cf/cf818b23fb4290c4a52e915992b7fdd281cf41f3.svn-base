package com.eyas.controllers;


import java.util.ArrayList;
import java.util.List;

import org.jfree.util.PublicCloneable;
import org.junit.experimental.theories.FromDataPoints;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.RecordType;
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
public class RecordtypeController extends BaseController {	

	@Override
	protected void setPath() {
		// TODO Auto-generated method stub
		setPath("/views/recordType/");
	}
	
	
	
	/**
	 * 学习记录类别管理--主界面
	 */
	public void recordTypeManage(){
		
		String userId = getSessionAttr(CONST.SESSION_USER_ID); // 获得登录用户ID
		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色
		 //0—中学生用户 1—中学教师 2—中学管理员 3—高校教师  4—高校管理员 5—创新学院用户 6—创新学院管理员
		StringBuffer from = new StringBuffer();
		List<String> params = new ArrayList<String>();
		from.append(" from learning_record_type_table lrt where 1=1");
		if (!ParaUtils.addLikeParam("recordTypeName", params, this)) {
			from.append(" and lrt.l_record_type like ?");
		}
		if (!ParaUtils.addLikeParam("Descript", params, this)) {
			from.append(" and lrt.descript like ?");
		}
		List<Record> list = pages(
				"select lrt.l_record_type_id, lrt.l_record_type, lrt.descript",
				from.toString(), params.toArray());
		render(view("recordType_management.jsp"));
	}
	
	/**
	 * 添加学习记录类别--显示
	 */
	public void addRecordTypeView(){
		render(view("add_recordType.jsp"));
	}
	
	/**
	 * 添加学习记录类别--处理
	 */
	public void txAddRecordtype() {
		String recordTypeName = getAttr("recordType_name");
		String descript = getAttr("descript");
		RecordType recordType = new RecordType();
		boolean isOk = recordType.getRecordTypeByName(recordTypeName);
		if (isOk == true) {
			recordType.set("l_record_type", recordTypeName);
			recordType.set("descript", descript);
			if (!save(recordType).equals(-1)) {
				ParaUtils.addMsg(this, "添加成功");
			} else {
				ParaUtils.addMsg(this, "添加失败");
			}
		} else
			ParaUtils.addMsg(this, "添加失败,类别名称不能重复");
		recordTypeManage();
	}
	
	/**
	 * 修改学习记录类别--显示
	 */
	public void editRecordTypeView(){
		String recordTypeId = getAttr("recordTypeId");
		Record recordType=Db.findFirst("select * from learning_record_type_table where l_record_type_id=?",recordTypeId);
		setAttr("recordType", recordType);
		render(view("edit_recordType.jsp"));
	}
	
	/**
	 * 修改学习记录类别--提交
	 */
	public void txEditRecordType(){
		String recordTypeId = getAttr("recordTypeId");
		String recordTypeName = getAttr("recordType_name");
		String Descript = getAttr("descript");
		RecordType recordType = new RecordType();
		boolean isOk=recordType.checkRecordTypeByName(recordTypeName, recordTypeId);
		if(isOk==true){
			Db.update("update learning_record_type_table set l_record_type = ? ,descript = ? where l_record_type_id = ? ", 
					recordTypeName, Descript, recordTypeId );
			ParaUtils.addMsg(this, "修改成功");
		}else{
			ParaUtils.addMsg(this, "修改失败，类别名称不能重复");
		}
		recordTypeManage();		
	}
	
	/**
	 * 查看学习记录类别--显示
	 */
	public void showRecordTypeView(){
		String recordTypeId = getAttr("recordTypeId");
		Record recordType=Db.findFirst("select * from learning_record_type_table where l_record_type_id=?",recordTypeId);
		setAttr("recordType", recordType);
		render(view("show_recordType.jsp"));
	}
	
	/**
	 * 删除学习记录类别--操作
	 */
	public void txDeleteRecordType(){
		String recordTypeId = getAttr("recordTypeId");
        try {
			Db.update("delete from learning_record_type_table where l_record_type_id=?", recordTypeId);
			ParaUtils.addMsg(this, "删除成功");
		} catch (Exception e) {
			// TODO: handle exception
			ParaUtils.addMsg(this, "删除失败，存在关联");
		}
		recordTypeManage();
	}
}
