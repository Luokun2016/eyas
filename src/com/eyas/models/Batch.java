package com.eyas.models;

import java.util.List;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

@TableBind(tableName = "batch", pkName = "batch_id")
public class Batch extends Model<Batch> {

	private static final long serialVersionUID = 1L;
	
	//获取状态为当前的批次
	public Batch getCurBatch() {
		return findFirst(
				"select * from batch where batch_status=1");
	}

}
