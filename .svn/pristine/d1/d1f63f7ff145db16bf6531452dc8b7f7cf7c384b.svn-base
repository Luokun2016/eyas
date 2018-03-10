package com.eyas.utils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Collections;

import com.jfinal.plugin.activerecord.Record;

public class TreeUtil {
	/*
	 * 将数据记录集合转换成层级结构
	 * dataList:记录集合
	 * return:根节点
	 */
	public static String getTreeMenu(List<Record> dataList,long rootId){
		if(dataList!=null&&dataList.size()>0){
			// 节点集合散列表
			HashMap<Long, Node> nodeList = new HashMap<Long, Node>();
			// 根节点
			Node root = null;
			// 将记录集合放入散列表nodeList
			for (Iterator<Record> it = dataList.iterator(); it
					.hasNext();) {
				Record dataRecord = it.next();
				Node node = new Node();
				node.id = dataRecord.get("org_id");
				node.name = (String) dataRecord.get("org_name");
				node.state=dataRecord.get("org_state");
				node.parentId = dataRecord.get("parent_id") ;
				nodeList.put(node.id, node);
			}
			// 转换成层级结构
			Set<Entry<Long, Node>> entrySet = nodeList.entrySet();
			for (Iterator<Entry<Long, Node>> it = entrySet.iterator(); it
					.hasNext();) {
				Node node = (Node) (it.next()).getValue();
				if (node.id == rootId ) {
					root = node;
				} else {
					((Node) nodeList.get(node.parentId)).addChild(node);
				}
			}
			root.sortChildren();
			return root.toString();
		}else{
			return "{}";
		}
		
	}
	
	/*
	 * 将数据记录集合转换成层级结构
	 * dataList:记录集合
	 * return:根节点
	 */
	public static String acctGetTreeMenu(List<Record> dataList, 
								String a_id, String a_name, String f_id){
		if(dataList!=null&&dataList.size()>0){
			// 节点集合散列表
			HashMap<Long, Node> nodeList = new HashMap<Long, Node>();
			// 根节点
			Node root = null;
			// 将记录集合放入散列表nodeList
			for (Iterator<Record> it = dataList.iterator(); it
					.hasNext();) {
				Record dataRecord = it.next();
				Node node = new Node();
				node.id = dataRecord.get(a_id);
				node.name = (String) dataRecord.get(a_name);
				node.parentId = dataRecord.get(f_id) ;
				nodeList.put(node.id, node);
			}
			// 转换成层级结构
			Set<Entry<Long, Node>> entrySet = nodeList.entrySet();
			for (Iterator<Entry<Long, Node>> it = entrySet.iterator(); it
					.hasNext();) {
				Node node = (Node) (it.next()).getValue();
				if (node.parentId == -1 ) {
					root = node;
				} else {
					((Node) nodeList.get(node.parentId)).addChild(node);
				}
			}
			root.sortChildren();
			return root.toString();
		}else{
			return "{}";
		}
		
	}

}

/**
 * 节点类
 */
 class Node {
	/**
	 * 节点id
	 */
	public long id;
	/**
	 * 节点名称
	 */
	public String name;
	/**
	 * 节点状态
	 */
	public int state;
	/**
	 * 父id
	 */
	public long parentId;
	/**
	 * 子节点
	 */
	private Children children = new Children();

	// 拼接json
	public String toString() {
		String result = "{" + "\"_id\": \"" + id + "\"" + ", \"name\" : \"" + name + "\""+ ", \"state\" : \"" + state + "\"";

		if (children != null && children.getSize() != 0) {
			result += ", \"children\": " + children.toString();
		} else {
			result += ", \"isParent\": false";
		}

		return result + "}";
	}

	// 子节点排序
	public void sortChildren() {
		if (children != null && children.getSize() != 0) {
			children.sortChildren();
		}
	}

	// 添加子节点
	public void addChild(Node node) {
		this.children.addChild(node);
	}
}

/**
 * 子列表
 */
class Children {
	private List<Node> list = new ArrayList<Node>();

	public int getSize() {
		return list.size();
	}

	public void addChild(Node node) {
		list.add(node);
	}

	// 拼接json
	public String toString() {
		String result = "[";
		for (Iterator<Node> it = list.iterator(); it.hasNext();) {
			result += ((Node) it.next()).toString();
			result += ",";
		}
		result = result.substring(0, result.length() - 1);
		result += "]";
		return result;
	}

	// 按照id排序
	public void sortChildren() {
		Collections.sort(list, new NodeIDComparator());
		for (Iterator<Node> it = list.iterator(); it.hasNext();) {
			((Node) it.next()).sortChildren();
		}
	}
}

/**
 *比较器
 */
class NodeIDComparator implements Comparator<Object> {

	public int compare(Object o1, Object o2) {
		long j1 = ((Node) o1).id;
		long j2 = ((Node) o2).id;
		return (j1 < j2 ? -1 : (j1 == j2 ? 0 : 1));
	}
}
