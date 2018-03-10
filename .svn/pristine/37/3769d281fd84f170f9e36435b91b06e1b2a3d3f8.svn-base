package com.eyas.base;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import com.eyas.utils.ID;
import com.eyas.utils.Paginate;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.TableInfo;
import com.jfinal.plugin.activerecord.TableInfoMapping;

public abstract class BaseController extends Controller {
	private StringBuffer sql = new StringBuffer();
	private final String FLAG = "flag";
	protected final String SAVE = "save";
	protected final String UPDATE = "update";
	protected final String DELETE = "delete";
	private String PAGE_PATH = "";
	private TableInfo tableInfo;

	public BaseController() {
		setPath();
	}

	abstract protected void setPath();

	/**
	 * 数据保存成功时的提示信息
	 */
	public void msgSaveSuccess() {
		addMsg("common_save_success");
	}

	/**
	 * 数据保存失败时的提示信息
	 */
	public void msgSaveError() {
		addMsg("common_save_error");
	}

	/**
	 * 数据操作成功时的提示信息
	 */
	public void msgOperateSuccess() {
		addMsg("common_op_success");
	}

	/**
	 * 数据操作失败时的提示信息
	 */
	public void msgOperateError() {
		addMsg("common_op_error");
	}

	/**
	 * 数据操作成功时的提示信息
	 */
	public void msgDeleteSuccess() {
		addMsg("common_delete_success");
	}

	/**
	 * 数据操作失败时的提示信息
	 */
	public void msgDeleteError() {
		addMsg("common_delete_error");
	}

	/**
	 * 数据重复提示
	 */
	public void msgCheckSame() {
		addMsg("common_save_err_same");
	}
 
	/**
	 * 未找到相关数据
	 */
	public void msgCheckId() {
		addMsg("common_save_err_id");
	}

	protected void setPath(String path) {
		PAGE_PATH = path;
	}

	protected String getPath() {
		return PAGE_PATH;
	}

	public String view(String view) {
		keepPara();
		return PAGE_PATH + view;
	}

	/**
	 * 获取int参数，如果不为int类型，则返回-1
	 * 
	 * @param paraName
	 * @return
	 */
	public int getParaInt(String paraName) {
		try {
			return Integer.parseInt(getPara(paraName));
		} catch (Exception e) {
			return -1;
		}
	}

	/**
	 * 取得标志
	 * 
	 * @return
	 */
	public String getFlag() {
		return getPara(FLAG);
	}

	/**
	 * 通用分页查询
	 * 
	 * @param c
	 *            当前控制器
	 * @param sel
	 *            Select语句
	 * @param from
	 *            From语句
	 * @param params
	 *            参数
	 */
	public List<Record> pages(String sel, String from, Object... params) {

		if (from.indexOf("order by") == -1 && getPara("order") != null&& getPara("order").trim().length()>0 ) {
			String asc = getPara("ob_asc") == null
					|| getPara("ob_asc").trim().equals("a") ? " a" : " d";
			setAttr("myorderasc", asc.trim());
			from += " order by " + getPara("order")
					+ (asc.trim().equals("a") ? " asc" : " desc");
		}
		Paginate p = Paginate.init(this);
		Page<Record> page = Db.paginate(p.getPageNumber(), p.getPageSize(),
				sel, from, params);
		setAttr(CONST.PAGINATION, page);
		return page.getList();
	}

	/**
	 * 设置model属性
	 * 
	 * @param model
	 */
	private Model<?> setModel(Model<?> model) {
		Enumeration<String> e = getParaNames();
		boolean result=true;
		while (e.hasMoreElements()) {
			String name = e.nextElement();
			if (tableInfo.hasColumnLabel(name) && model.get(name) == null) {
				model.set(name, getParas(name)==null?null:getParas(name).trim());
			}
			if(result){
				//如果有操作人和操作时间，那么自动获取当前时间和当前操作人
				if (tableInfo.hasColumnLabel(CONST.OPTPERSON) && model.get(CONST.OPTPERSON) == null) {
					model.set(CONST.OPTPERSON, getSessionAttr(CONST.SESSION_USER_ID));
				}
				//如果有操作人和操作时间，那么自动获取当前时间和当前操作人
				if (tableInfo.hasColumnLabel(CONST.OPTDATE) && model.get(CONST.OPTDATE) == null) {
					model.set(CONST.OPTDATE, new Date());
				}
				result=false;
			}
		}
		return model;
	}

	/**
	 * 插入新的数据，如果插入成功，返回改ID，否则返回-1
	 * 
	 * @param model
	 */
	public BigInteger save(Model<?> model) {
		BigInteger id = BigInteger.valueOf(ID.getNumId());
		tableInfo = TableInfoMapping.me().getTableInfo(model.getClass());
		if (model.get(tableInfo.getPrimaryKey()) == null) {
			model.set(tableInfo.getPrimaryKey(), id);
		}
		model = setModel(model);
		if (model.save()) {
			return id;
		}
		return BigInteger.valueOf(-1L);
	}

	/**
	 * 更新数据，更新成功返回id，否则返回-1
	 * 
	 * @param model
	 */
	public BigInteger update(Model<?> model) {
		tableInfo = TableInfoMapping.me().getTableInfo(model.getClass());
		BigInteger id = BigInteger.valueOf(-1L);
		try {
			if (model.get(tableInfo.getPrimaryKey()) != null) {
				id = model.get(tableInfo.getPrimaryKey());
			} else {
				id = BigInteger
						.valueOf(getParaToLong(tableInfo.getPrimaryKey()));
			}
			model.set(tableInfo.getPrimaryKey(), id);
			model = setModel(model);
			if (model.update()) {
				return id;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return BigInteger.valueOf(-1L);
	}

	/**
	 * 如果参数为空则返回null
	 * 
	 * @param name
	 * @return
	 */
	private String getParas(String name) {
		return (getPara(name) == "" || getPara(name) == null) ? null
				: getPara(name);
	}

	/**
	 * 根据表名和ID值删除数据（单表单主键删除）
	 * 
	 * @param tableName
	 * @param idValue
	 */
	public boolean delById(String tableName, String idValue) {
		return Db.deleteById(tableName, idValue);
	}

	/**
	 * 根据条件进行删除
	 * 
	 * @param tableName
	 * @param where
	 * @param paras
	 */
	public void delByWhere(String tableName, String where) {
		sql.setLength(0);
		sql.append("delete from ").append(tableName);
		sql.append(" where ").append(where);
		List<String> batch = new ArrayList<String>();
		batch.add(sql.toString());
		Db.batch(batch, batch.size());
	}

	/**
	 * 根据主键进行删除，可存在多个主键值，默认从界面中获取指定的Key数据
	 * 
	 * @param tableName
	 * @param primaryKey
	 * @param in
	 */
	public void delById(Model<?> model) {
		tableInfo = TableInfoMapping.me().getTableInfo(model.getClass());
		model.deleteById(getPara(tableInfo.getPrimaryKey()));
	}

	/**
	 * 添加错误消息
	 * 
	 * @param c
	 * @param msg
	 */
	public String addMsg(String errorMsg) {
		List<String> list = getSessionAttr(CONST.PAGE_ERROR);
		if (list == null || list.size() == 0) {
			list = new ArrayList<String>();
		}
		list.add(getText(errorMsg));
		setSessionAttr(CONST.PAGE_ERROR, list);
		return errorMsg;
	}
	/**
	 * 添加错误消息
	 * 
	 * @param c
	 * @param msg
	 */
	public static String addMsg(Controller c, String errorMsg) {
		List<String> list = c.getSessionAttr(CONST.PAGE_ERROR);
		if (list == null || list.size() == 0) {
			list = new ArrayList<String>();
		}
		list.add(errorMsg);
		c.setSessionAttr(CONST.PAGE_ERROR, list);
		return errorMsg;
	}

	/**
	 * 清空错误消息
	 * 
	 * @param c
	 * @param msg
	 */
	public void clearError() {
		setSessionAttr(CONST.PAGE_ERROR, null);
	}

}