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
	private long date_diff;		// 현재시간-글등록시간
	private String date_diff_str;	// 현재시간-글등록시간을 문자열로
}
