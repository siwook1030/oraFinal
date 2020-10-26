package com.example.demo.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewVo {
	private int r_no;
	private int c_no;
	private String id;
	private String r_title;
	private String r_content;
	private Date r_regdate;
	private int r_hit;
	private String c_name;
	private String nickName;
	private String rank_icon;
	private int total_reply;
}
