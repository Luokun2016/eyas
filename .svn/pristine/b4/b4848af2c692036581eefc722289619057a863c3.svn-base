package com.eyas.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

public class StringTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int maxLength = 10;

	public int getMaxLength() {
		return maxLength;
	}

	public void setMaxLength(int maxLength) {
		this.maxLength = maxLength;
	}

	@Override
	public int doAfterBody() throws JspException {
		BodyContent bc = getBodyContent();
		String regexstr = "<[^>]*>";
		String content = bc.getString().replaceAll(regexstr, "");
		if (content.length() > maxLength) {
			output(bc.getEnclosingWriter(), content.substring(0, maxLength)
					+ "...");
		} else {
			output(bc.getEnclosingWriter(), content);
		}
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
