package com.example.demo.vo;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Meeting_repVo {
	private int mr_no;
	private int m_no;
	private String id;
	private String mr_content;
	private String mr_regdate;
	private int mr_ref;
	private int mr_step;
	private String mr_file1;
	
	private String rank_icon;
	private String nickName;
	
}