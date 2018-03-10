package com.eyas.base;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Level;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import org.apache.log4j.PropertyConfigurator;

public class MLog {
	public static final String PROFILE = "/log4j.properties";
	private static MLog encapsulationLog4J;
	private Logger log4j;

	private MLog() {
		log4j = LogManager.getLogger(MLog.class);
		Properties pro = new Properties();
		InputStream is = getClass().getResourceAsStream(PROFILE);
		try {
			pro.load(is);
		} catch (IOException e) {
			BasicConfigurator.configure();
			e.printStackTrace();
		}
		PropertyConfigurator.configure(pro);
	}

	public void log(String level, Object msg, Throwable e) {
		if (null != log4j) {
			log4j.log((Priority) Level.toLevel(level), msg, e);
		}
	}

	public void log(String level, Object msg) {
		log(level, msg, null);
	}

	public void log(String level, Throwable e) {
		log(level, null, e);
	}

	public static MLog getInstance() {
		if (encapsulationLog4J == null) {
			encapsulationLog4J = new MLog();
		}
		return encapsulationLog4J;
	}

}
