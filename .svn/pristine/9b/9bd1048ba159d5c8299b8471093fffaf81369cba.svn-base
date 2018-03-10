package com.eyas.tags;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class CheckBoxTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String name;

	private boolean check;

	private String defualValue;

	private List<Map<String, Object>> list;

	private String key;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public List<Map<String, Object>> getList() {
		return list;
	}

	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}

	public String getDefualValue() {
		return defualValue;
	}

	public void setDefualValue(String defualValue) {
		this.defualValue = defualValue;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isCheck() {
		return check;
	}

	public void setCheck(boolean check) {
		this.check = check;
	}

	@Override
	public int doAfterBody() throws JspException {
		BodyContent bc = getBodyContent();
		boolean c = false;
		String bodyValue = bc.getString();
		String[] v = null;
		if (bodyValue != null && !"".equals(bodyValue)) {
			v = bodyValue.split(";");
			c = true;
		}
		if (list != null && list.size() > 0) {
			v = new String[list.size()];
			for (int i = 0; i < list.size(); i++) {
				v[i] = list.get(i).get(getKey()).toString();
			}
			c = true;
		}
		// 如果都为null，这不执行
		if (!c) {
			return super.doAfterBody();
		}
		String[] dv = null;
		if (getDefualValue() != null) {
			dv = getDefualValue().split(";");
		}
		StringBuffer html = new StringBuffer();
		for (int i = 0; i < v.length; i++) {
			if (check) {
				html.append("<label class=\"checkbox-inline\">");
			} else {
				html.append("<label class=\"radio-inline\">");
			}
			html.append("<input type=\"");
			if (check) {
				html.append("checkbox");
			} else {
				html.append("radio");
			}
			html.append("\" value=\"").append(v[i]);
			html.append("\"");
			if (dv != null) {
				for (int j = 0; j < dv.length; j++) {
					if (dv[j].equals(v[i])) {
						html.append(" checked=\"checked\"");
					}
				}
			}
			html.append(" name=\"");
			html.append(name).append("\"/>");
			html.append(v[i]);
			html.append("</label>");
		}
		output(bc.getEnclosingWriter(), html.toString());
		return super.doAfterBody();
	}

	private void output(JspWriter out, String html) {
		try {
			out.println(html);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
