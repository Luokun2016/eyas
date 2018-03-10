package com.eyas.utils;

import java.util.ArrayList;
import java.util.List;

import com.eyas.base.CONST;
import com.jfinal.core.Controller;

public class ParaUtils {
	/**
	 * 添加参数，如果参数为空或者"-1"则不添加
	 * 
	 * @param param
	 * @param pList
	 * @param c
	 * @return
	 */
	public static boolean addParam(String param, List<String> pList,
			Controller c) {
		String _param = c.getPara(param);
		if (_param == null || _param.equals("")|| _param.equals("-1")) {
			return true;
		}
		pList.add(_param);
		return false;
	}
	/**
	 * 添加like条件的参数，如：select * from a where b like %aaa%
	 * 
	 * @param param
	 * @param pList
	 * @param c
	 * @return
	 */
	public static boolean addLikeParam(String param, List<String> pList,
			Controller c) {
		String _param = c.getPara(param);
		if (_param == null || "".equals(_param)) {
			return true;
		}
		pList.add("%" + _param + "%");
		return false;
	}

	/**
	 * 取得返回结果，如：｛10219912-12012-123-123123｝，返回结果为：10219912-12012-123-123123
	 * 
	 * @param param
	 * @return
	 */
	public static String getResult(String param) {
		if (param == null)
			return null;
		return param.replace("{", "").replace("}", "");
	}

	public static String getArrayPara(String name, Controller c) {
		String[] _p = c.getParaValues(name);
		if (_p == null) {
			return null;
		}
		StringBuffer arr = new StringBuffer();
		for (int i = 0; i < _p.length; i++) {
			arr.append(_p[i]);
			if (i + 1 < _p.length) {
				arr.append(",");
			}
		}
		return arr.toString();
	}

	public static String getPara(String param, Controller c) {
		String _p = c.getPara(param);
		if (_p == null || "".equals(_p))
			return null;
		return _p;
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
	public static void clearError(Controller c) {
		c.setSessionAttr(CONST.PAGE_ERROR, null);
	}

	/**
	 * 检查是否为null，如果是返回空字符串
	 * 
	 * @param s
	 * @return
	 */
	public static String isEmpty(Object s) {
		return s == null ? "" : s.toString();
	}

}
