package com.eyas.base;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;


import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.ext.plugin.sqlinxml.SqlInXmlPlugin;
import com.jfinal.ext.plugin.tablebind.AutoTableBindPlugin;
import com.jfinal.ext.route.AutoBindRoutes;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.tx.TxByRegex;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.druid.DruidStatViewHandler;
import com.jfinal.plugin.druid.IDruidStatViewAuth;
import com.jfinal.render.ViewType;
import com.alibaba.druid.filter.stat.StatFilter;
import com.alibaba.druid.util.JdbcConstants;
import com.alibaba.druid.wall.WallFilter;
import com.eyas.controllers.IndexController;
import com.eyas.models.Users;
import com.eyas.utils.FileUtils;


public class BaseConfig extends JFinalConfig {
	@Override
	public void configConstant(Constants me) {
		me.setDevMode(true);
		me.setViewType(ViewType.JSP);
		me.setEncoding("UTF-8");
		me.setUrlParaSeparator("&");
		me.setMaxPostSize(1000000000);
		me.setError404View("/views/common/404.jsp");
		me.setError500View("/views/common/500.jsp");
		me.setI18n("web");
	}

	@Override
	public void configRoute(Routes me) {
		me.add("/",IndexController.class);
		me.add(new AutoBindRoutes());
	}

	private Properties loadConfigs(String name) throws IOException {
		// 注入路由访问配置
		InputStream in = BaseConfig.class.getResourceAsStream(name);
		Properties p = new Properties();
		p.load(in);
		return p;
	}

	@Override
	public void configPlugin(Plugins me) {
			/*Properties p = loadConfigs("db.properties");
			// 注入数据库访问配置
			C3p0Plugin cp = new C3p0Plugin(p);
			AutoTableBindPlugin atbp = new AutoTableBindPlugin(cp);

			me.add(cp);
			me.add(atbp);

			SqlInXmlPlugin sql = new SqlInXmlPlugin();
			me.add(sql);*/
			try {
				Properties p = loadConfigs("db.properties");
				 /**配置druid数据连接池插件**/
				 DruidPlugin dp=new DruidPlugin(p.getProperty("jdbcUrl")
						 ,p.getProperty("user"),p.getProperty("password").trim());
				 /**配置druid监控**/
				dp.addFilter(new StatFilter());
				WallFilter wall=new WallFilter();
				wall.setDbType("mysql");
				dp.addFilter(wall);
				me.add(dp);
				AutoTableBindPlugin atbp = new AutoTableBindPlugin(dp);
				me.add(atbp);
				SqlInXmlPlugin sql = new SqlInXmlPlugin();
				me.add(sql);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

	@Override
	public void configInterceptor(Interceptors me) {
		me.add(new GlobalInterceptor());
		me.add(new TxByRegex(".*tx.*", false));
	}

	@Override
	public void configHandler(Handlers me) {
		
	}

	@Override
	public void afterJFinalStart() {
		super.afterJFinalStart();
	}
}
