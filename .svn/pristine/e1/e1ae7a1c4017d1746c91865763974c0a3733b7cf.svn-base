package com.eyas.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.eyas.base.CONST;

public class FileUtils {
	private static String WEB_INF = "WEB-INF";

	private static int FILE_SIZE = 1024; 

	public static String getFileName(Integer uid, String fileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmssSSS");
		String tempName = uid + "_" + sdf.format(new Date()) + "_" + fileName;
		return tempName;
	}

	/**
	 * 上传文件 
	 * 
	 * @param source
	 * @param target
	 * @throws IOException 
	 */
	public static void upLoadFile(File source, File target) throws IOException {
		InputStream in = null;
		OutputStream out = null;
		try {
			in = new BufferedInputStream(new FileInputStream(source), FILE_SIZE);
			out = new BufferedOutputStream(new FileOutputStream(target),
					FILE_SIZE);
			byte[] image = new byte[FILE_SIZE];
			while (in.read(image) > 0) {
				out.write(image);
			}
			out.flush();
		} catch (IOException ex) {
			ex.printStackTrace();
			throw ex;
		} finally {
			try {
				in.close();
				out.close();
			} catch (IOException ex) {
				throw ex;
			}
		}
	}

	/**
	 * 保存文件
	 * 
	 * @param filePath
	 * @param context
	 */
	public static void saveFile(String filePath, String context, String ending) {
		try {
			File file = new File(filePath);
			Writer out = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), ending));
			out.write(context);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 保存文件,默认保存为GB2312格式
	 * 
	 * @param filePath
	 * @param context
	 */
	public static void saveFile(String filePath, String context) {
		saveFile(filePath, context, CONST.ENCODING_UTF8);
	}

	/**
	 * 保存XML文件
	 * 
	 * @param excelPath
	 * @param htmlPath
	 */
	public static String saveXmlFile(String fileName, String context) {
		String path = getWebInfPath() + fileName;
		String dirs = path.substring(0, path.lastIndexOf("/"));
		File file = new File(dirs);
		try {
			// 将XML文件转换为UTF-8编码
			context = URLDecoder.decode(context, CONST.ENCODING_UTF8);
			if (!file.exists()) {
				file.mkdirs();
			}
			file = new File(path);
			if (!file.exists()) {
				file.createNewFile();
			}
			saveFile(path, context, CONST.ENCODING_UTF8);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}

	/**
	 * 取得项目根目录
	 * 
	 * @return
	 */
	public static String getWebInfPath() {
		String path = "";
		try {
			path = FileUtils.class.getResource("/").toURI().getPath();
			path = path.substring(0, path.lastIndexOf(WEB_INF));
		} catch (URISyntaxException e) {
		}
		return path;
	}

	/**
	 * 删除文件或者目录
	 * 
	 * @param sPath
	 * @return
	 */
	public static boolean DeleteFolder(String sPath) {
		boolean flag = false;
		File file = new File(sPath);
		// 判断目录或文件是否存在
		if (!file.exists()) { // 不存在返回 false
			return flag;
		} else {
			// 判断是否为文件
			if (file.isFile()) { // 为文件时调用删除文件方法
				return deleteFile(sPath);
			} else { // 为目录时调用删除目录方法
				return deleteDirectory(sPath);
			}
		}
	}

	/**
	 * 删除文件
	 * 
	 * @param sPath
	 * @return
	 */
	public static boolean deleteFile(String sPath) {
		boolean flag = false;
		File file = new File(sPath);
		// 路径为文件且不为空则进行删除
		if (file.isFile() && file.exists()) {
			file.delete();
			flag = true;
		}
		return flag;
	}

	/**
	 * 删除目录
	 * 
	 * @param sPath
	 * @return
	 */
	public static boolean deleteDirectory(String sPath) {
		// 如果sPath不以文件分隔符结尾，自动添加文件分隔符
		if (!sPath.endsWith(File.separator)) {
			sPath = sPath + File.separator;
		}
		File dirFile = new File(sPath);
		// 如果dir对应的文件不存在，或者不是一个目录，则退出
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			return false;
		}
		boolean flag = true;
		// 删除文件夹下的所有文件(包括子目录)
		File[] files = dirFile.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 删除子文件
			if (files[i].isFile()) {
				flag = deleteFile(files[i].getAbsolutePath());
				if (!flag)
					break;
			} // 删除子目录
			else {
				flag = deleteDirectory(files[i].getAbsolutePath());
				if (!flag)
					break;
			}
		}
		if (!flag)
			return false;
		// 删除当前目录
		if (dirFile.delete()) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 创建目录
	 * 
	 */
	public static void createDir(String path) {
		// 判断是否目录
		File file = new File(path);
		if (file.isFile()) {
			String _path = path.substring(0, path.lastIndexOf("/") - 1);
			file = new File(_path);
		}
		if (file.isDirectory()) {
			if (!file.exists()) {
				file.mkdirs();
			}
		} else {
			file.mkdirs();
		}
	}

	/**
	 * 读取文件内容
	 * 
	 * @return
	 */
	public static String read(String fileName, String charset) {
		File file = new File(fileName);
		Reader reader = null;
		StringBuffer sb = new StringBuffer();
		try {
			// 一次读一个字符
			reader = new InputStreamReader(new FileInputStream(file), charset);
			int tempchar;
			while ((tempchar = reader.read()) != -1) {
				// 对于windows下，\r\n这两个字符在一起时，表示一个换行。
				// 但如果这两个字符分开显示时，会换两次行。
				// 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
				if (((char) tempchar) != '\r') {
					sb.append((char) tempchar);
				}
			}
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

	/**
	 * 读取文件内容
	 * 
	 * @return
	 */
	public static String read(String fileName) {
		File file = new File(fileName);
		Reader reader = null;
		StringBuffer sb = new StringBuffer();
		try {
			// 一次读一个字符
			reader = new InputStreamReader(new FileInputStream(file),
					CONST.ENCODING_UTF8);
			int tempchar;
			while ((tempchar = reader.read()) != -1) {
				// 对于windows下，\r\n这两个字符在一起时，表示一个换行。
				// 但如果这两个字符分开显示时，会换两次行。
				// 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
				if (((char) tempchar) != '\r') {
					sb.append((char) tempchar);
				}
			}
			reader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sb.toString();
	}

	/**
	 * 复制文件(以超快的速度复制文件)
	 * 
	 * @author:suhj 2006-8-31
	 * @param srcFile
	 *            源文件File
	 * @param destDir
	 *            目标目录File
	 * @param newFileName
	 *            新文件名
	 * @return 实际复制的字节数，如果文件、目录不存在、文件为null或者发生IO异常，返回-1
	 */
	@SuppressWarnings("resource")
	public static long copyFile(String srcFileStr, String destDirStr,
			String newFileName) {
		File srcFile = new File(srcFileStr);
		File destDir = new File(destDirStr);
		long copySizes = 0;
		if (!srcFile.exists()) {
			// 源文件不存在
			copySizes = -1;
		} else if (!destDir.exists()) {
			// 目标目录不存在
			copySizes = -1;
		} else if (newFileName == null) {
			// 文件名为null
			copySizes = -1;
		} else {
			try {
				FileChannel fcin = new FileInputStream(srcFile).getChannel();
				FileChannel fcout = new FileOutputStream(new File(destDir,
						newFileName)).getChannel();
				@SuppressWarnings("unused")
				ByteBuffer buff = ByteBuffer.allocate(1024);
				@SuppressWarnings("unused")
				int b = 0, i = 0;
				long size = fcin.size();
				fcin.transferTo(0, fcin.size(), fcout);
				fcin.close();
				fcout.close();
				copySizes = size;
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return copySizes;
	}

	public static void main(String[] args) {
		String src = "C:/Program Files/Apache Software Foundation/Tomcat 6.0/webapps/srsm/files";
		String dest = "C:/Program Files/Apache Software Foundation/Tomcat 6.0/webapps/srsm/files_bak";
		copyFileAndDir(src, dest);

	}

	/**
	 * 复制文件以及文件夹
	 * 
	 * @param sFile
	 * @param oFile
	 */
	public static void copyFileAndDir(String sFile, String oFile) {
		File file = new File(sFile);

		if (!file.exists()) {
			return;
		}
		File fileb = new File(oFile);

		if (file.isFile()) {
			FileInputStream fis = null;
			FileOutputStream fos = null;
			try {
				fis = new FileInputStream(file);
				fos = new FileOutputStream(fileb);

				byte[] bb = new byte[(int) file.length()];
				fis.read(bb);
				fos.write(bb);

			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					fis.close();
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		} else if (file.isDirectory()) {
			if (!fileb.exists()) {
				fileb.mkdir();
			}
			String[] fileList;
			fileList = file.list();
			for (int i = 0; i < fileList.length; i++) {
				copyFileAndDir(sFile + "/" + fileList[i], oFile + "/"
						+ fileList[i]);
			}
		}
	}

	/**
	 * 读取二进制文件
	 * 
	 * @return
	 */
	public static byte[] readFile(String path) throws Exception {
		File file = new File(path);
		if (!file.exists()) {
			throw new Exception(path + " file not exists!");
		}
		FileInputStream in = null;
		in = new FileInputStream(file);
		byte[] count = new byte[in.available()];
		in.read(count);
		in.close();
		return count;
	}

	/**
	 * 读取二进制文件
	 * 
	 * @return
	 */
	public static byte[] readFile(File file) throws Exception {
		if (file == null)
			return new byte[0];
		if (!file.exists()) {
			throw new Exception(file.getName() + " file not exists!");
		}
		FileInputStream in = null;
		in = new FileInputStream(file);
		byte[] count = new byte[in.available()];
		in.read(count);
		in.close();
		return count;
	}

	/**
	 * 获取文件类型
	 * 
	 * @return
	 */
	public static String getFileType(String fileName) {
		if (fileName == null || "".equals(fileName.trim()))
			return "";
		return fileName.substring(fileName.indexOf(".") + 1).toUpperCase();
	}
}
