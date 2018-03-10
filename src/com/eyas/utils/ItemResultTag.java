package com.eyas.utils;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class ItemResultTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
 
	private String name;
	
	private List<Map<String, Object>> list;

	private String key;
	
	private String defualValue;
	
	private Integer maxGrade;
	
	public Integer getMaxGrade() {
		return maxGrade;
	}

	public void setMaxGrade(Integer maxGrade) {
		this.maxGrade = maxGrade;
	}

	public String getDefualValue() {
		return defualValue;
	}

	public void setDefualValue(String defualValue) {
		this.defualValue = defualValue;
	}
	
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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
//		for (int i=0; i<dv.length; i++) {
//			System.out.println(i+":"+dv[i]);
//		}
		StringBuffer html = new StringBuffer();
		for (int i = 0; i < v.length; i++) {
			//System.out.println(v[i]+"  "+dv[i]);
			html.append("<div>");
			html.append("<label class=\"label_name\">");
			html.append(v[i]);
			html.append("</label>");
			html.append("<input class=\"input_grade\" type=\"text\" name=\"");
			html.append(name);
			html.append("\" value=\"");
			if (dv.length > 1) {
				//System.out.println("非空");
				html.append(dv[i]);
			} else {
				//System.out.println("空");
				html.append("");
			}
			html.append("\" onblur=\"checkGradeForm()\"/>");
			html.append("<label class=\"label_name\">");
			html.append("分&nbsp;&nbsp;&nbsp;&nbsp;");
			html.append("</label>");
			html.append("</div>");
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
