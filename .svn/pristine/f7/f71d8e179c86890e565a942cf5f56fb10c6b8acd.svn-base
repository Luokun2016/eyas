package com.eyas.controllers;

import java.io.File;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.eyas.base.BaseController;
import com.eyas.base.CONST;
import com.eyas.models.AttachFile;
import com.eyas.models.News;
import com.eyas.models.NewsType;
import com.eyas.utils.FileUtils;
import com.eyas.utils.ID;
import com.eyas.utils.ParaUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

public class NewsController extends BaseController {

	@Override
	protected void setPath() {
		setPath("/views/news/");
	}

	/**
	 *界面加载时的初始化方法，默认名称为index() 
	 */
	public void index(){
		String userId = getSessionAttr(CONST.SESSION_NAME); // 获得登录用户ID
		//		Long role = getModel(Users.class).getBigRole(userId); // 获取用户角色
		StringBuffer from = new StringBuffer("from news n left join news_type nt on n.news_type_id=nt.news_type_id where 1=1 ");
		List<String> params = new ArrayList<String>();
		if (!ParaUtils.addLikeParam("keyWord", params, this)) {
			from.append(" and n.title like ?");
		}
		if (!ParaUtils.addParam("news_type", params, this)) {
			from.append(" and n.news_type_id = ?");
		}
		from.append(" order by n.publish_time desc");
		List<Record> list = pages("select n.news_id,n.title,nt.news_type_name,n.publish_time ",from.toString(), params.toArray());
		//类型列表
		List<Record> typeList=Db.find("select * from news_type");
		setAttr("typeList", typeList);
		render(view("news_manage.jsp"));
	}

	/**
	 * 管理界面跳转发布界面的跳转方法
	 */
	public void add(){
		setAttr("typeList", Db.find("select * from news_type"));
		setAttr("newsId", ID.getNumId());
		render(view("add.jsp"));
	}

	/**
	 * 新闻预览
	 */
	public void show(){
		String newsId=getPara("news_id");
		setAttr("oneNews", Db.findFirst("select * from news where news_id=?",newsId));
		setAttr("attachList",Db.find("select * from attach_file where news_id = ? order by file_id desc",newsId));
		render(view("show.jsp"));
	}

	/**
	 * 新增数据方法
	 */
	public void txAddNews(){
		if (SAVE.equals(getFlag())) {
			News n = new News();
			n.set("user_id", getSessionAttr(CONST.SESSION_USER_ID));
			n.set("publish_time", new Date());
			BigInteger b=save(n);
			//获取附件信息
			String[] attach_files=getParaValues("attach_file");
			String[] attach_names=getParaValues("attach_name");
			if(attach_files!=null&&attach_files.length>=1){
				for(int i=0;i<attach_files.length;i++){
					AttachFile af=new AttachFile();
					af.set("news_id", b);
					af.set("file_name", attach_names[i]);
					af.set("file_path", attach_files[i]);
					save(af);
				}
			}
			msgOperateSuccess();
		}		
		index();
	}

	/**
	 * 得到id，跳转
	 */
	public void edit(){
		String newsId=getPara("news_id");
		setAttr("typeList", Db.find("select * from news_type"));
		setAttr("oneNews", Db.findFirst("select * from news where news_id=?",newsId));
		setAttr("attachList",Db.find("select * from attach_file where news_id = ? order by file_id desc limit 3",newsId));
		render(view("edit.jsp"));
	}

	/**
	 * 更新新闻
	 */
	public void txEditNews(){
		Db.update("update news set title=?,content=?,news_type_id=?,user_id=?,publish_time=?,view_for_guest=? where news_id=?",
				getPara("title"),getPara("content"),getPara("news_type_id"), getSessionAttr(CONST.SESSION_USER_ID), new Date(),getPara("view_for_guest"),getPara("news_id"));
		//获取附件信息
		String[] attach_files=getParaValues("attach_file");
		String[] attach_names=getParaValues("attach_name");
		if(attach_files!=null&&attach_files.length>=1){
			Db.update("delete from attach_file where news_id=?",getPara("news_id").trim());
			for(int i=0;i<attach_files.length;i++){
				AttachFile af=new AttachFile();
				af.set("news_id", getPara("news_id"));
				af.set("file_name", attach_names[i]);
				af.set("file_path", attach_files[i]);
				save(af);
			}
		}
		msgOperateSuccess();
		index();
	}

	/**
	 * 删除新闻
	 */
	public void txDelNews(){
		try {
			Db.update("delete from news where news_id=?",getPara("news_id").trim());
			ParaUtils.addMsg(this, "删除成功");
		} catch (Exception e) {
			ParaUtils.addMsg(this, "删除操作失败！");
		}
		index();
	}

	public void newsType(){
		setAttr("typeList", Db.find("select * from news_type"));
		render(view("news_policy.jsp"));
	}

	public void addType(){
		render(view("addType.jsp"));
	}

	public void txAddType(){
		if (SAVE.equals(getFlag())) {
			NewsType nt = new NewsType();
			nt.set("news_type_id", ID.getNumId());
			nt.set("news_type_name", getPara("type_name"));
			nt.save();
			newsType();
			return;
		}
		newsType();
	}

	public void editType(){
		setAttr("type", Db.findFirst("select * from news_type where news_type_id=?",getPara("type_id")));
		render(view("editType.jsp"));
	}

	public void txEditType(){
		Db.update("update news_type set news_type_name=? where news_type_id=?",getPara("type_name"),getPara("type_id"));
		newsType();
	}

	public void txDelType(){
		try {
			Db.update("delete from news_type where news_type_id=?",getPara("type_id").trim());
			ParaUtils.addMsg(this, "删除成功");
		} catch (Exception e) {
			ParaUtils.addMsg(this, "删除操作失败！");
		}
		index();
	}

	/**
	 * 图片
	 */
	public void imgUpload(){
		System.out.println("imgUpload");
		render(view("imgUpload.jsp"));
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
		String path = FileUtils.getWebInfPath() +CONST.NEWS_PATH;
		File file = new File(path);
		//判断是否存在该文件夹，如果不存在则创建
		if(!file.exists()) {
			file.mkdir();
		}
		FileUtils.copyFile(uf.getFile().getAbsolutePath(), path, fileName);
		FileUtils.deleteFile(uf.getFile().getAbsolutePath());
		renderJson(fileName);
	}

	/**
	 * 自上传附件下载
	 */
	public void downLoad() {
		String docId = getPara("attach_file");
		try {
			File f = new File(FileUtils.getWebInfPath() +CONST.NEWS_PATH+docId);
			if(!f.isFile()){
				msgOperateError();
			}
			else renderFile(f);
		} catch (Exception e) {
			msgOperateError();
		}
	}

}
