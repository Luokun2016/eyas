package com.eyas.models;

import com.jfinal.ext.plugin.tablebind.TableBind;
import com.jfinal.plugin.activerecord.Model;

@TableBind(tableName = "team_table", pkName = "team_id")
public class TeamTable extends Model<TeamTable> {

}
