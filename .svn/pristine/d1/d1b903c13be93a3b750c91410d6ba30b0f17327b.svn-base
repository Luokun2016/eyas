package com.eyas.tags;

import java.io.IOException;

import javax.servlet.jsp.tagext.BodyTagSupport;

import com.jfinal.plugin.activerecord.Model;

public class MapTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Object var;
	private String key;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public Object getVar() {
		return var;
	}

	public void setVar(Object var) {
		this.var = var;
	}

	@Override
	public int doStartTag() {
		if (var == null) {
			return SKIP_BODY;
		}
		Model<?> map = (Model<?>) var;
		try {
			pageContext.getOut().print(map.get(key));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}
}
