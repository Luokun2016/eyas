package com.eyas.utils;

public class StrUtil {
	// 验证字符串是否为空
	public static boolean validateNull(String args) {
		if (args == null || args.length() == 0) {
			return true;
		}
		return false;
	}

	// 空就返回target
	public static String changeNull(String source, String target) {
		if (source == null || source.length() == 0
				|| source.equalsIgnoreCase("null")) {
			return target;
		}
		return source;
	}

	public static String filterHtml(String input) {
		if (input == null) {
			return null;
		}
		if (input.length() == 0) {
			return input;
		}
		input = input.replace("&", "&amp;");
		input = input.replace("<", "&lt;");
		input = input.replace(">", "&gt;");
		input = input.replace(" ", "&nbsp;");
		input = input.replace("'", "&#39;");
		input = input.replace("\"", "&quot;");
		input = input.replace("\n", "<br>");
		return input;
	}
}
