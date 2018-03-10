package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "project_apply", pkName = "project_id")
public class ProjectApply extends Model<ProjectApply> {

}
