<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.json.simple.*" %>
<%
response.setContentType("text/html; charset=UTF-8");
//属性赋值
String url=request.getContextPath()+"/upload/news/";
String savePath=pageContext.getServletContext().getRealPath("/")+"upload/news/";
String ext[]={"gif","jpg","jpeg","png","bmp"};
long maxSize=100*1024*1024;

//判断文件是否符合规范：类型、大小...
if(!ServletFileUpload.isMultipartContent(request)){
	out.println("请单个单个上传");
	return;
}

//设值dirName
String dirName=request.getParameter("dir");
if(dirName==null){
	dirName="image";
}
//判断路径是否存在
/* File uploadDir=new File(savePath);
if(!uploadDir.isDirectory()){
	
} */
//创建文件夹
File saveDir = new File(savePath);
if(!saveDir.exists()){
	saveDir.mkdir();
}

//存储图片
FileItemFactory factory =new DiskFileItemFactory();
ServletFileUpload upload=new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");
List items=upload.parseRequest(request);
Iterator itr=items.iterator();
while(itr.hasNext()){
	FileItem item=(FileItem)itr.next();
	String fileName=item.getName();
	long fileSize=item.getSize();
	if(!item.isFormField()){
		if(fileSize>maxSize){
			out.println();
			return;
		}
		String fileExt=fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();
		if(!Arrays.asList(ext).contains(fileExt)){
			out.println("请上传图片");
			return;
		}
		
		long id=123456789012L;
		String finalName=id+"."+fileExt;
		try{
			File uploadFile = new File(savePath,finalName);
			item.write(uploadFile);
		}catch(Exception e){
			out.println("上传图片失败");
			return;
		}
		
		JSONObject obj=new JSONObject();
		obj.put("error", 0);
		obj.put("url", url+finalName);
		out.println(obj.toJSONString());
	}
}
%>