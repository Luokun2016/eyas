package com.eyas.tags;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.eyas.base.CONST;


/**
 * 权限标签，对比当前权限是否显示
 * 
 * @author Administrator
 * 
 */
public class RightTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	public int doAfterBody() throws JspTagException {
		HttpSession session = pageContext.getSession();
		Map<String, String> pMap = (Map<String, String>) session
				.getAttribute(CONST.RIGHTS);
		BodyContent bc = getBodyContent();
		// 解析html内容
		Document doc = Jsoup.parse(bc.getString());
		boolean isHaveRights = true;
		// 判断是否存在权限
		if (pMap == null || pMap.size() == 0) {
			isHaveRights = false;
		}
		Elements rights = doc.select("[pm]");
		int len = rights.size();
		Element el = null;
		// 遍历权限元素
		for (int i = 0; i < len; i++) {
			el = rights.get(i);
			// 如果没有找到权限，则不显示权限点
			if (!isHaveRights) {
				el.attr("style", "display:none");
				el.remove();
				continue;
			}
			if (el.attr("pm") != null && pMap.get(el.attr("pm")) == null) {
				el.attr("style", "display:none");
				el.remove();
			}
		}
		output(bc.getEnclosingWriter(), doc);
		return 1;
	}

	private void output(JspWriter out, Document doc) {
		try {
			out.println(doc.html());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
