package com.eyas.utils;

import java.util.UUID;

public class ID {
	private static long serialno = 0;

	public ID() {
	}

	static {
		serialno = System.currentTimeMillis();
	}

	public static synchronized long getNumId() {
		try {
			Thread.sleep(1);
		} catch (Exception ex) {
		}
		return serialno++;
	}
}
