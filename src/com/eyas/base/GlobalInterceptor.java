package com.eyas.base;

import javax.servlet.http.HttpSession;

import com.eyas.utils.ParaUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
import com.jfinal.core.Const;
import com.jfinal.core.Controller;
import com.jfinal.i18n.I18N;

public class GlobalInterceptor implements Interceptor {
	private String[] nofilter = { "/index/","/index/login","/index/logout"
			,"/index/img","/index/index","/index/body","/index/menu","/index/userEdit"
			,"/index/txUpdateUser","/index/editCheckCertificate","/index/editCheckPhone","/index/editCheckEmail"
			,"/index/header","/project/upload","/project/downLoad","/project/uploadApply","/project/applyDownLoad","/project/uploadSignup","/project/signupDownLoad",
			"/conclusion/upload","/conclusion/downLoad1","/conclusion/downLoad2","/news/upload","/news/downLoad","school/editCheckSchoolName","school/checkSchoolName",
			"/user/editCheckCertificate","/user/editCheckPhone","/user/editCheckEmail",
			"/record/upload","/record/downLoad","/report/upload","/report/downLoad","/report/select","/report/viewSelect","/record/queryProgram","/record/queryView","/index/downLoad",
			"/conclusion/select","/conclusion/selectViewC"};

	@Override
	public void intercept(ActionInvocation ai) {

		Controller c = ai.getController();

		/*// 国际化
		String tmp = c.getCookie(Const.I18N_LOCALE);

		String i18n = c.getRequest().getParameter("lang");
		if (i18n != null
				&& (!i18n.equals(tmp) || !I18N.getDefaultLocale().equals(i18n))) {
			ai.getController().setCookie(Const.I18N_LOCALE, i18n,
					Const.DEFAULT_I18N_MAX_AGE_OF_COOKIE);
			I18N.init("web", I18N.localeFromString(i18n), null);
			c.setSessionAttr("i18n", I18N.me());
		}
		c.setSessionAttr(CONST._LOCALE_, I18N.getDefaultLocale());*/
		String basePath = c.getSessionAttr(CONST.SESSION_BASE_PATH);
		if (basePath == null || "".equals(basePath.trim())) {
			// 标准路径
			String path = c.getRequest().getContextPath();
			basePath = c.getRequest().getScheme() + "://"
					+ c.getRequest().getServerName() + ":"
					+ c.getRequest().getServerPort() + path + "/";
			c.setSessionAttr(CONST.SESSION_BASE_PATH, basePath);
			
		}
		if (CONST.BASE_PATH == null || "null".equals(CONST.BASE_PATH)) {
			CONST.BASE_PATH = basePath;
		}
		String cKey = ai.getControllerKey() + "/" + ai.getMethodName();
		c.setSessionAttr(CONST.ACTION_PATH, ai.getActionKey());
		c.keepPara();

		// 检测是否登录
		if (c.getSessionAttr(CONST.SESSION_USER_ID) == null
				&& !cKey.contains("/login") && !cKey.contains("/logout")&& !cKey.contains("/img")&& !cKey.contains("/studentRegiste")&& !cKey.contains("/midTeacherRegiste")&& !cKey.contains("/collegeTeacherRegiste")
				&& !cKey.contains("/checkName")&& !cKey.contains("/checkCertificate")&& !cKey.contains("/checkPhone")&& !cKey.contains("/checkEmail")&& !cKey.contains("/txUserRegiste")&& !cKey.contains("/getGrade")&& !cKey.contains("/getClasss")&& !cKey.contains("/getNewsList")
				&& !cKey.contains("/getPolicyList")&& !cKey.contains("/getNews")&& !cKey.contains("/index/downLoad")) {
			// 未登录，进入登录界面
			c.redirect(CONST.BASE_PATH + "index/login");
			return;
		}
		HttpSession session = ai.getController().getSession();
		boolean isRight = rights(session, cKey);
		if (!isRight) {
			// 没有找到权限，进入无权限界面
			ai.getController().render("/views/common/norights.jsp");
			return;
		}
		try {
			// 设置ActionKey
			ai.getController().getSession()
					.setAttribute(CONST.ACTION_PATH, ai.getActionKey());
			ai.getController().keepPara();
			ParaUtils.clearError(c);
			ai.invoke();
		} catch (Exception e) {
			Log.logError(e);
			e.printStackTrace();
			// 发生异常，跳转至错误界面
			ai.getController().setAttr("exception", e);
			ai.getController().render("/views/common/500.jsp");
		}
	}

	/**
	 * 权限过滤
	 * 
	 * @return
	 */
	public boolean rights(HttpSession session, String key) {
		//判断哪些不需进行权限判断
		for (int i = 0; i < nofilter.length; i++) {
			if(key.indexOf(nofilter[i])>=0)
				return true;
		}
		String[] urls=session.getAttribute(CONST.URL).toString().split("%");
		for(int i=0;i<urls.length;i++){
			if(key.indexOf(urls[i])>=0)
				return true;
		}	
		return false;
	}
}
