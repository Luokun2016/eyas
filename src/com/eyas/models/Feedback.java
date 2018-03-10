package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "feedback_table", pkName = "feedback_id")
public class Feedback extends Model<Feedback> {

	private static final long serialVersionUID = 1L;

}
