package com.eyas.tags;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.tagext.BodyTagSupport;

import com.eyas.base.CONST;

public class ErrorMsgTag extends BodyTagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String msgKeys = "";

	private String dialog(String dl) {
		StringBuffer dialog = new StringBuffer();
		dialog.append("<div class=\"modal fade\" id=\"_TIPS_MSG_DIALOG\" tabindex=\"-1\" role=\"dialog\" aria-hidden=\"true\">");
		dialog.append("  <div class=\"modal-dialog\">");
		dialog.append("    <div class=\"modal-content\">");
		dialog.append("      <div class=\"modal-header\">");
		dialog.append("        <button type=\"button\" class=\"close\" data-dismiss=\"modal\">&times;</button>");
		dialog.append("        <h4>温馨提示</h4>");
		dialog.append("      </div>");
		dialog.append("      <div class=\"modal-body\">");
		dialog.append(dl);
		dialog.append("      </div>");
		dialog.append("    </div>");
		dialog.append("  </div>");
		dialog.append("</div>");
		return dialog.toString();
	}

	public String getMsgKeys() {
		return msgKeys;
	}

	public void setMsgKeys(String msgKeys) {
		this.msgKeys = msgKeys;
	}

	@SuppressWarnings("unchecked")
	private int getPageError(HttpSession session, StringBuffer msg, int count) {
		List<String> list = (List<String>) session
				.getAttribute(CONST.PAGE_ERROR);
		if (list == null || list.size() == 0)
			return 0;
		for (int i = 0; i < list.size(); i++) {
			msg.append("<li class=\"list-group-item\">");
			msg.append("<span class='glyphicon glyphicon-warning-sign'></span> ");
			msg.append(list.get(i));
			msg.append("</li>");
			count++;
		}
		return count;
	}

	public int doStartTag() {
		StringBuffer msg = new StringBuffer();
		try {
			String[] keys = msgKeys.split(",");
			ServletRequest req = pageContext.getRequest();
			int count = 0;
			msg.append("<div class=\"panel panel-danger\" id='_TAG_MSG'>");
			msg.append("<ul class=\"list-group\">");
			for (int i = 0; i < keys.length; i++) {
				if (req.getAttribute(keys[i].trim()) != null) {
					msg.append("<li class=\"list-group-item\">");
					msg.append("<span class='glyphicon glyphicon-warning-sign'></span> ");
					msg.append(req.getAttribute(keys[i].trim()));
					msg.append("</li>");
					count++;
				}
			}
			count += getPageError(pageContext.getSession(), msg, count);
			msg.append("</ul>");
			msg.append("</div>");
			if (count > 0) {
				pageContext.getOut().print(dialog(msg.toString()));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return SKIP_BODY;
	}

	public int doEndTag() {
		return SKIP_BODY;
	}
}
