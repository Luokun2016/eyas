package com.eyas.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.BodyContent;
import javax.servlet.jsp.tagext.BodyTagSupport;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Parser;
import org.jsoup.parser.XmlTreeBuilder;
import org.jsoup.select.Elements;

import com.jfinal.i18n.I18N;

public class FormTag extends BodyTagSupport {

	private static final long serialVersionUID = 1L;
	private String layout;
	private String cols;

	public String getCols() {
		return cols;
	}

	public void setCols(String cols) {
		this.cols = cols;
	}

	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	@Override
	public int doStartTag() throws JspException {
		return EVAL_BODY_BUFFERED;
	}

	@Override
	public int doAfterBody() throws JspException {
		try {
			BodyContent bc = getBodyContent();
			// 解析xml内容
			Document doc = Jsoup.parse(bc.getString(), "", new Parser(
					new XmlTreeBuilder()));
			output(bc.getEnclosingWriter(), createForm(doc));
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("error:" + e.getMessage());
		}
		return super.doAfterBody();
	}

	@Override
	public void release() {
	}

	private void output(JspWriter out, String doc) {
		try {
			out.println(doc);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private String createForm(Document doc) {
		StringBuffer form = new StringBuffer();
		Elements es = doc.getElementsByTag("col");
		int len = es.size();
		int l1 = 2, l2 = 5, l3 = 5;
		if (layout != null && !"".equals(layout)) {
			l1 = Integer.valueOf(layout.split(",")[0]);
			l2 = Integer.valueOf(layout.split(",")[1]);
			l3 = Integer.valueOf(layout.split(",")[2]);
		}

		for (int i = 0; i < len; i++) {
			Element e = es.get(i);
			createControl(form, l1, l2, l3, e);
		}
		return form.toString();
	}

	private String createControl(StringBuffer form, int l1, int l2, int l3,
			Element e) {
		int _col = 1;
		if (cols != null && !"".equals(cols)) {
			_col = Integer.valueOf(cols);
		}
		form.append("<div class='col-md-");
		form.append(12 / _col).append("'>");
		form.append("<div class=\"form-group\">");
		String empty = e.attr("empty");
		if (empty != null && !"".equals(empty)) {
			form.append("<p class=\"form-control\" style=\"border:0px;box-shadow: inset 0 0px 0px rgba(0, 0, 0, 0);background:transparent;\">&nbsp;</p>");
		} else {
			form.append("<label class=\"col-md-").append(l1);
			form.append(" control-label Validform_label\">");
			form.append(e.attr("label")).append("</label>");
			form.append("<div class=\"col-md-").append(l2);
			form.append("\">");
			form.append(e.html());
			form.append("</div>");
			form.append("<div class=\"col-md-").append(l3);
			form.append("\">");
			form.append("<p class=\"form-control-static Validform_checktip\">");
			if (e.attr("required") != null && !"".equals(e.attr("required"))) {
				form.append(e.attr("label"));
				form.append("必须填写！").append("</p>");
			} else {
				form.append(e.attr("tips")).append("</p>");
			}
			form.append("</div>");
		}
		form.append("</div>");
		form.append("</div>");
		// 如果是填充整行
		if (e.attr("full") != null && !"".equals(e.attr("full"))) {
			form.append("<div class='col-md-6'></div>");
			form.append("<div class='col-md-12'></div>");
		}
		return form.toString();
	}
}
