package com.example.demo.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Review_repVo {
	private int rr_no;
	private int r_no;
	private String id;
	private String rr_content;
	private Date rr_regdate;
	private int rr_ref;
	private int rr_step;
	private String rr_file;
	private String nickName;
	private String rank_icon;
}
